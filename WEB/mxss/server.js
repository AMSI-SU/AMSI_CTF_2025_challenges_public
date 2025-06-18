const express = require('express');
const path = require('path');
const { JSDOM } = require('jsdom');
const http = require('http');
const https = require('https');

const app = express();
const PORT = process.env.PORT || 3002;
const HOST = process.env.HOST || 'localhost';

let forumPosts = [];
let postIdCounter = 1;

// Bot configuration
const BOT_FLAG = 'AMSI{58653f70203832bb4357b79e1df4048fcda13f46635f1e90b726f166f2106178}';
const BOT_USER_AGENT = 'CTF-Bot/1.0';

app.use(express.json());
app.use(express.static('.'));

function vulnerableSanitize(html) {
  console.log('Input HTML:', html);

  const dom = new JSDOM('<!DOCTYPE html><html><body></body></html>');
  const document = dom.window.document;

  const container = document.createElement('div');
  container.innerHTML = html;

  console.log('After initial parsing:', container.innerHTML);

  const scripts = container.querySelectorAll('script');
  scripts.forEach(script => script.remove());

  // Remove on* event handlers (basic sanitization attempt)
  const allElements = container.querySelectorAll('*');
  allElements.forEach(element => {
    // Remove event handler attributes
    const attributes = Array.from(element.attributes);
    attributes.forEach(attr => {
      if (attr.name.toLowerCase().startsWith('on')) {
        element.removeAttribute(attr.name);
      }
    });
  });

  const elementsWithHref = container.querySelectorAll('[href]');
  elementsWithHref.forEach(element => {
    const href = element.getAttribute('href');
    if (href && href.toLowerCase().startsWith('javascript:')) {
      element.removeAttribute('href');
    }
  });

  const elementsWithSrc = container.querySelectorAll('[src]');
  elementsWithSrc.forEach(element => {
    const src = element.getAttribute('src');
    if (src && src.toLowerCase().startsWith('javascript:')) {
      element.removeAttribute('src');
    }
  });

  const sanitized = container.innerHTML;
  console.log('After sanitization:', sanitized);

  return sanitized;
}

async function executeXSSFetch(url) {
  try {
    console.log(`📡 Bot making XSS request to: ${url}`);

    const urlObj = new URL(url);
    const options = {
      hostname: urlObj.hostname,
      port: urlObj.port || (urlObj.protocol === 'https:' ? 443 : 80),
      path: urlObj.pathname + urlObj.search,
      method: 'GET',
      headers: {
        'User-Agent': BOT_USER_AGENT,
        'Referer': `http://${HOST}:${PORT}/`
      }
    };

    const protocol = urlObj.protocol === 'https:' ? https : http;

    const req = protocol.request(options, (res) => {
      console.log(`✅ XSS request completed: ${res.statusCode}`);

      let responseData = '';
      res.on('data', (chunk) => {
        responseData += chunk;
      });

      res.on('end', () => {
        console.log(`📨 XSS response: ${responseData.substring(0, 200)}...`);
      });
    });

    req.on('error', (err) => {
      console.log(`❌ XSS request failed: ${err.message}`);
    });

    req.setTimeout(3000, () => {
      req.destroy();
      console.log('⏰ XSS request timeout');
    });

    req.end();

  } catch (error) {
    console.log(`❌ Error executing XSS fetch: ${error.message}`);
  }
}

function simulateJavaScriptExecution(html, cookies) {
  console.log('🤖 Simulating JavaScript execution...');

  // Create cookie string like a real browser would
  const cookieString = Object.entries(cookies)
    .map(([key, value]) => `${key}=${value}`)
    .join('; ');

  console.log('🍪 Bot cookies:', cookieString);

  // Create a mock document object for JavaScript execution
  const mockDocument = {
    cookie: cookieString
  };

  // Find all event handlers (onerror, onload, onclick, etc.)
  const eventHandlerRegex = /on\w+\s*=\s*([^>]+?)(?=\s|>|$)/gi;
  let match;

  while ((match = eventHandlerRegex.exec(html)) !== null) {
    let jsCode = match[1];

    // Clean up the JavaScript code
    jsCode = jsCode.replace(/^['"]|['"]$/g, '');
    jsCode = jsCode.trim();

    console.log(`🔍 Bot found event handler: ${jsCode}`);

    try {
      executeJavaScriptCode(jsCode, mockDocument);
    } catch (error) {
      console.log(`❌ Error executing JavaScript: ${error.message}`);
    }
  }
}

// Function to safely execute JavaScript code with mock browser environment
function executeJavaScriptCode(jsCode, mockDocument) {
  const context = {
    document: mockDocument,
    fetch: (url) => {
      console.log(`🚀 Bot executing fetch to: ${url}`);
      executeXSSFetch(url);
    },
    alert: (message) => {
      console.log(`🔔 Bot alert: ${message}`);
    },
    console: {
      log: (message) => console.log(`📝 Bot console: ${message}`)
    },
    setTimeout: (fn, delay) => {
      console.log(`⏰ Bot setTimeout called with delay: ${delay}ms`);
      if (typeof fn === 'function') {
        setTimeout(fn, Math.min(delay, 1000));
      }
    },
    location: {
      href: `http://localhost:4012/`,
      reload: () => console.log('🔄 Bot location.reload() called')
    }
  };

  try {
    const execFunction = new Function(...Object.keys(context), jsCode);
    execFunction(...Object.values(context));
  } catch (error) {
    console.log(`🔧 Attempting to parse JavaScript: ${jsCode}`);

    if (jsCode.includes('.concat(')) {
      const expandedCode = expandStringConcatenation(jsCode, context);
      console.log(`🔍 Expanded code: ${expandedCode}`);

      try {
        const execFunction = new Function(...Object.keys(context), expandedCode);
        execFunction(...Object.values(context));
      } catch (innerError) {
        console.log(`❌ Could not execute expanded code: ${innerError.message}`);
      }
    }
  }
}

function expandStringConcatenation(code, context) {
  let expandedCode = code.replace(/document\.cookie/g, `"${context.document.cookie}"`);

  expandedCode = expandedCode.replace(/(['"].*?['"])\.concat\(([^)]+)\)/g, (match, str, concatArg) => {
    const baseStr = str.slice(1, -1);
    const expandedArg = concatArg.replace(/["']/g, '');
    return `"${baseStr}${context.document.cookie}"`;
  });

  return expandedCode;
}

// Enhanced bot function with generic JavaScript execution
async function botVisitUrl(url) {
  return new Promise((resolve, reject) => {
    console.log(`🤖 Bot visiting: ${url}`);

    let urlObj;
    try {
      urlObj = new URL(url);
    } catch (error) {
      console.log(`❌ Invalid URL: ${url}`);
      reject(new Error('Invalid URL'));
      return;
    }

    const options = {
      hostname: urlObj.hostname,
      port: urlObj.port || (urlObj.protocol === 'https:' ? 443 : 80),
      path: urlObj.pathname + urlObj.search,
      method: 'GET',
      headers: {
        'User-Agent': BOT_USER_AGENT,
        'Cookie': `${BOT_FLAG}; admin=true; session_id=bot_session_${Date.now()}`,
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
      }
    };

    const protocol = urlObj.protocol === 'https:' ? https : http;

    const req = protocol.request(options, (res) => {
      let data = '';

      res.on('data', (chunk) => {
        data += chunk;
      });

      res.on('end', () => {
        console.log(`🤖 Bot received response from ${url} (${res.statusCode})`);

        // Check for any event handlers or JavaScript
        if (data.includes('on') && (data.includes('=') || data.includes('javascript:'))) {
          console.log('🚨 Bot detected potential JavaScript payload!');

          // Simulate JavaScript execution for any event handlers found
          simulateJavaScriptExecution(data, {
            'flag': BOT_FLAG,
            'admin': 'true',
            'session_id': `bot_session_${Date.now()}`
          });
        }

        resolve({
          statusCode: res.statusCode,
          headers: res.headers,
          body: data,
          cookies: res.headers['set-cookie'] || []
        });
      });
    });

    req.on('error', (err) => {
      console.log(`🤖 Bot visit failed: ${err.message}`);
      reject(err);
    });

    req.setTimeout(5000, () => {
      req.destroy();
      reject(new Error('Bot visit timeout'));
    });

    req.end();
  });
}

// Bot function to visit URLs directly from forum posts
async function botVisitForumLinks() {
  try {
    console.log('🤖 Bot checking forum posts for URLs to visit...');

    const postsWithUrls = forumPosts.filter(post => post.url && !post.visited);

    if (postsWithUrls.length === 0) {
      console.log('🔗 No new URLs found in forum posts');
      return;
    }

    console.log(`🔗 Bot found ${postsWithUrls.length} new URLs to visit`);

    for (let i = 0; i < postsWithUrls.length; i++) {
      const post = postsWithUrls[i];
      console.log(`🔗 Bot visiting URL ${i + 1}/${postsWithUrls.length} from post "${post.title}": ${post.url}`);

      try {
        await botVisitUrl(post.url);
        post.visited = true;

        if (i < postsWithUrls.length - 1) {
          await new Promise(resolve => setTimeout(resolve, 500));
        }
      } catch (error) {
        console.error(`❌ Error visiting URL ${post.url}: ${error.message}`);
        post.visited = true;
      }
    }

    console.log(`✅ Bot finished visiting all forum URLs`);

  } catch (error) {
    console.error(`❌ Bot error: ${error.message}`);
  }
}

// Bot function to visit forum page and extract links
async function botVisitForumAndClickLinks() {
  try {
    console.log('🤖 Bot visiting forum page to find links...');

    const forumResponse = await botVisitUrl(`http://${HOST}:${PORT}/forum`);

    const dom = new JSDOM(forumResponse.body);
    const document = dom.window.document;

    const allLinks = document.querySelectorAll('a[href], [href]');
    const linksToVisit = [];

    allLinks.forEach(link => {
      const href = link.getAttribute('href');
      if (href &&
        !href.startsWith('#') &&
        !href.startsWith('javascript:') &&
        href !== '/' &&
        !href.includes('/forum') &&
        !href.includes('/api/')) {

        let fullUrl;
        if (href.startsWith('http')) {
          fullUrl = href;
        } else {
          fullUrl = `http://${HOST}:${PORT}${href}`;
        }
        linksToVisit.push(fullUrl);
      }
    });

    const textContent = document.body.textContent || '';
    const urlRegex = /https?:\/\/[^\s<>"']+/g;
    const textUrls = textContent.match(urlRegex) || [];

    textUrls.forEach(url => {
      if (!linksToVisit.includes(url) &&
        !url.includes('/forum') &&
        !url.includes('/api/')) {
        linksToVisit.push(url);
      }
    });

    console.log(`🔗 Bot found ${linksToVisit.length} links to visit on forum page`);
    console.log('Links found:', linksToVisit);

    for (let i = 0; i < linksToVisit.length; i++) {
      const link = linksToVisit[i];
      console.log(`🔗 Bot clicking link ${i + 1}/${linksToVisit.length}: ${link}`);

      try {
        await botVisitUrl(link);
        if (i < linksToVisit.length - 1) {
          await new Promise(resolve => setTimeout(resolve, 500));
        }
      } catch (error) {
        console.error(`❌ Error visiting link ${link}: ${error.message}`);
      }
    }

    console.log(`✅ Bot finished visiting all forum links`);

  } catch (error) {
    console.error(`❌ Bot error visiting forum: ${error.message}`);
  }
}

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

app.get('/forum', (req, res) => {
  const linkify = (text) => {
    // Improved URL regex that properly handles URLs in XSS contexts
    const urlRegex = /(https?:\/\/[^\s<>'"()]+)/g;
    return text.replace(urlRegex, url => {
      // Clean up the URL by removing trailing punctuation
      let cleanUrl = url.replace(/[)'".,;:!?]+$/, '');

      return `<a href="${cleanUrl}" target="_blank" rel="noopener noreferrer">${cleanUrl}</a>`;
    });
  };

  const forumHtml = `
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Retro Arcade - Community Forum</title>
      <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #1a1a2e; color: #00ffff; }
        .post { border: 1px solid #ff6b35; margin: 10px 0; padding: 15px; border-radius: 5px; }
        .post-title { color: #ff6b35; font-weight: bold; font-size: 1.2em; margin-bottom: 10px; }
        .post-content { margin: 10px 0; line-height: 1.5; }
        .post-url { background: rgba(155, 89, 182, 0.2); padding: 10px; margin: 10px 0; border-radius: 5px; }
        .post-url a { color: #f7931e; text-decoration: none; }
        .timestamp { color: #9b59b6; font-size: 0.9em; }
        .no-posts { text-align: center; color: #9b59b6; font-style: italic; padding: 40px; }
        h1 { text-align: center; color: #ff6b35; margin-bottom: 30px; }
      </style>
    </head>
    <body>
      <h1>Forum Posts</h1>
      <div id="posts-container">
        ${forumPosts.length === 0
      ? '<div class="no-posts">No posts yet.</div>'
      : forumPosts.slice().reverse().map(post => `
            <div class="post">
              <div class="post-title">${post.title}</div>
              <div class="post-content">${linkify(post.content)}</div>
              ${post.url ? `<div class="post-url">URL: <a href="${post.url}" target="_blank">${post.url}</a></div>` : ''}
              <div class="timestamp">${new Date(post.timestamp).toLocaleString()} ${post.visited ? '(Visited by bot)' : '(Pending bot visit)'}</div>
            </div>
          `).join('')
    }
      </div>
    </body>
    </html>`;

  res.send(forumHtml);
});

app.get('/api/posts', (req, res) => {
  res.json({
    success: true,
    posts: forumPosts.slice().reverse() // Show newest first
  });
});

app.post('/api/posts', async (req, res) => {
  const { title, content, url } = req.body;

  if (!title || !content) {
    return res.json({
      success: false,
      error: 'Title and content are required'
    });
  }

  const sanitizedTitle = title.replace(/<script[^>]*>.*?<\/script>/gi, '');
  const sanitizedContent = content.replace(/<script[^>]*>.*?<\/script>/gi, '');

  const post = {
    id: postIdCounter++,
    title: sanitizedTitle,
    content: sanitizedContent,
    url: url || null,
    timestamp: new Date().toISOString(),
    visited: false
  };

  forumPosts.push(post);

  console.log(`📝 New forum post: "${post.title}" by user`);
  if (post.url) {
    console.log(`🔗 URL included: ${post.url}`);
  }

  setTimeout(async () => {
    await botVisitForumLinks();
    await botVisitForumAndClickLinks();
  }, 2000);

  res.json({
    success: true,
    post: post
  });
});

app.post('/submit-score', (req, res) => {
  const { playerName, gameScore } = req.body;

  console.log('\n=== SCORE SUBMISSION ===');
  console.log('Player Name:', playerName);
  console.log('Game Score:', gameScore);

  if (!playerName || !gameScore) {
    return res.json({
      success: false,
      error: 'Missing player name or score'
    });
  }

  const welcomeMessage = `
        <div style="color: #00ffff; font-weight: bold;">
            🎉 Score submitted successfully!
        </div>
        <div style="margin-top: 10px;">
            Player: ${playerName}<br>
            Score: ${gameScore}
        </div>
        <div style="color: #9b59b6; margin-top: 10px; font-size: 12px;">
            Thanks for playing! Your score has been recorded.
        </div>
    `;

  const sanitizedMessage = vulnerableSanitize(welcomeMessage);

  console.log('Final sanitized message:', sanitizedMessage);
  console.log('=========================\n');

  res.json({
    success: true,
    message: sanitizedMessage
  });
});

app.post('/welcome', (req, res) => {
  const { player } = req.body;

  console.log('\n=== WELCOME MESSAGE ===');
  console.log('Player from URL:', player);

  if (!player) {
    return res.json({
      success: false,
      error: 'No player specified'
    });
  }

  const welcomeMessage = `
        <div style="color: #ff6b35; font-weight: bold;">
            🎮 Welcome back, ${player}!
        </div>
        <div style="color: #ccc; margin-top: 5px;">
            Ready to beat your high score?
        </div>
    `;

  const sanitizedMessage = vulnerableSanitize(welcomeMessage);

  console.log('Final welcome message:', sanitizedMessage);
  console.log('========================\n');

  res.json({
    success: true,
    message: sanitizedMessage
  });
});

app.use((err, req, res, next) => {
  console.error('Server error:', err);
  res.status(500).json({
    success: false,
    error: 'Internal server error'
  });
});

app.listen(PORT, () => {
  console.log(`🚀 MathML Mutation XSS Challenge Server running on http://${HOST}:${PORT}`);
  console.log(`🏠 Host: ${HOST}`);
  console.log(`🔌 Port: ${PORT}`);
  console.log(`🤖 Bot User-Agent: ${BOT_USER_AGENT}`);
  console.log(`🏁 Flag: ${BOT_FLAG}`);
});

process.on('SIGINT', () => {
  console.log('\n👋 Server shutting down gracefully...');
  process.exit(0);
});
