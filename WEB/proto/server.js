const express = require('express');
const session = require('express-session');
const bodyParser = require('body-parser');
const _ = require('lodash');
const bcrypt = require('bcrypt');
const { v4: uuidv4 } = require('uuid');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 4011;

app.use(helmet({
  contentSecurityPolicy: false,
  crossOriginEmbedderPolicy: false
}));

// const limiter = rateLimit({
//   windowMs: 15 * 60 * 1000,
//   max: 100
// });
// app.use(limiter);

app.use(session({
  secret: 'luxury-marketplace-secret-key-2024',
  resave: false,
  saveUninitialized: false,
  cookie: { secure: false, maxAge: 24 * 60 * 60 * 1000 }
}));

app.use(bodyParser.json({ limit: '10mb' }));
app.use(bodyParser.urlencoded({ extended: true, limit: '10mb' }));
app.use(express.static('public'));

const users = new Map();
const products = new Map();
const orders = new Map();
const adminUsers = new Set(['admin@luxe.com']);

const blacklistedKeys = [
  'constructor',
  'prototype',
  '__proto__',
  'isAdmin',
  'role',
  'admin'
];

const initializeData = () => {
  products.set('prod1', {
    id: 'prod1',
    name: 'Rolex Submariner',
    price: 12000,
    category: 'watches',
    description: 'Luxury diving watch',
    inventory: 5,
    featured: true
  });

  products.set('prod2', {
    id: 'prod2',
    name: 'Hermès Birkin Bag',
    price: 25000,
    category: 'bags',
    description: 'Iconic luxury handbag',
    inventory: 2,
    featured: true
  });

  products.set('prod3', {
    id: 'prod3',
    name: 'Patek Philippe Nautilus',
    price: 45000,
    category: 'watches',
    description: 'Prestigious sports watch',
    inventory: 1,
    featured: false
  });

  users.set('admin@luxe.com', {
    id: 'admin',
    email: 'admin@luxe.com',
    password: '$2b$10$K2HgQz5RhwWjxjFzKnKrKuQKjqrPdYGqDjmzGFLQgBzRmQDGm5K7e', // admin123
    role: 'admin',
    profile: {
      name: 'Admin User',
      phone: '+1-555-ADMIN',
      address: '123 Admin St'
    }
  });
};

// Enhanced input sanitization with basic blacklist
const sanitizeInput = (obj, depth = 0) => {
  if (depth > 10) return {};

  if (obj === null || typeof obj !== 'object') return obj;
  if (Array.isArray(obj)) return obj.map(item => sanitizeInput(item, depth + 1));

  const sanitized = {};

  for (let key in obj) {
    // Block direct blacklisted keys
    if (blacklistedKeys.includes(key.toLowerCase())) {
      console.log(`Blocked suspicious key: ${key}`);
      continue;
    }

    // Block keys that contain blacklisted terms
    if (blacklistedKeys.some(blocked => key.toLowerCase().includes(blocked))) {
      console.log(`Blocked key containing suspicious term: ${key}`);
      continue;
    }

    if (obj.hasOwnProperty(key)) {
      sanitized[key] = sanitizeInput(obj[key], depth + 1);
    }
  }

  return sanitized;
};

// Deep merge utility with enhanced vulnerability
const deepMerge = (target, source) => {
  for (let key in source) {
    if (source[key] && typeof source[key] === 'object' && !Array.isArray(source[key])) {
      if (!target[key]) target[key] = {};
      deepMerge(target[key], source[key]);
    } else {
      target[key] = source[key];
    }
  }
  return target;
};

// Custom object cloning with prototype pollution risk
const cloneObject = (obj) => {
  if (obj === null || typeof obj !== 'object') return obj;
  if (obj instanceof Date) return new Date(obj.getTime());
  if (Array.isArray(obj)) return obj.map(cloneObject);

  const cloned = {};
  for (let key in obj) {
    if (obj.hasOwnProperty(key)) {
      cloned[key] = cloneObject(obj[key]);
    }
  }
  return cloned;
};

// Enhanced admin check with multiple validation layers
const requireAdmin = (req, res, next) => {
  if (!req.session.user) {
    return res.status(401).json({ error: 'Authentication required' });
  }

  const user = req.session.user;

  // Multiple ways to check admin status - this creates more attack surface
  const isAdmin = adminUsers.has(user.email) ||
    user.role === 'admin' ||
    user.isAdmin === true ||
    user.permissions?.admin === true ||
    user.access?.level === 'admin' ||
    user.flags?.elevated === true;

  if (!isAdmin) {
    return res.status(403).json({ error: 'Admin access required' });
  }

  next();
};

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.get('/admin', requireAdmin, (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'admin.html'));
});

app.get('/login', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'login.html'));
});

app.get('/register', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'register.html'));
});

app.get('/profile', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'profile.html'));
});

app.get('/cart', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'cart.html'));
});

app.post('/api/register', async (req, res) => {
  try {
    const { email, password, name, phone, address } = req.body;

    if (!email || !password || !name) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    if (users.has(email)) {
      return res.status(400).json({ error: 'User already exists' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const userId = uuidv4();

    const user = {
      id: userId,
      email,
      password: hashedPassword,
      role: 'user',
      profile: {
        name,
        phone: phone || '',
        address: address || ''
      },
      createdAt: new Date().toISOString()
    };

    users.set(email, user);

    req.session.user = {
      id: userId,
      email,
      role: 'user',
      profile: user.profile
    };

    res.json({
      success: true,
      message: 'Registration successful',
      user: { id: userId, email, role: 'user', profile: user.profile }
    });
  } catch (error) {
    res.status(500).json({ error: 'Registration failed' });
  }
});

app.post('/api/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ error: 'Email and password required' });
    }

    const user = users.get(email);
    if (!user || !await bcrypt.compare(password, user.password)) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    req.session.user = {
      id: user.id,
      email: user.email,
      role: user.role,
      profile: user.profile,
      isAdmin: adminUsers.has(email)
    };

    res.json({
      success: true,
      message: 'Login successful',
      user: req.session.user
    });
  } catch (error) {
    res.status(500).json({ error: 'Login failed' });
  }
});

app.post('/api/logout', (req, res) => {
  req.session.destroy();
  res.json({ success: true, message: 'Logged out successfully' });
});

app.get('/api/products', (req, res) => {
  const { category, featured } = req.query;
  let productList = Array.from(products.values());

  if (category) {
    productList = productList.filter(p => p.category === category);
  }

  if (featured === 'true') {
    productList = productList.filter(p => p.featured);
  }

  res.json(productList);
});

app.get('/api/user/profile', (req, res) => {
  if (!req.session.user) {
    return res.status(401).json({ error: 'Not authenticated' });
  }

  res.json(req.session.user);
});

app.post('/api/user/profile', (req, res) => {
  if (!req.session.user) {
    return res.status(401).json({ error: 'Not authenticated' });
  }

  try {
    const updates = req.body;
    const user = users.get(req.session.user.email);

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Apply input sanitization
    const sanitizedUpdates = sanitizeInput(updates);

    console.log('Original updates:', JSON.stringify(updates, null, 2));
    console.log('Sanitized updates:', JSON.stringify(sanitizedUpdates, null, 2));

    const updatedProfile = deepMerge(cloneObject(user.profile), sanitizedUpdates);
    user.profile = updatedProfile;

    req.session.user.profile = updatedProfile;

    deepMerge(req.session.user, sanitizedUpdates);

    users.set(req.session.user.email, user);

    res.json({
      success: true,
      message: 'Profile updated successfully',
      profile: updatedProfile
    });
  } catch (error) {
    console.error('Profile update error:', error);
    res.status(500).json({ error: 'Profile update failed' });
  }
});

// Vulnerable order processing endpoint
app.post('/api/orders', (req, res) => {
  if (!req.session.user) {
    return res.status(401).json({ error: 'Not authenticated' });
  }

  try {
    const { items, shippingAddress, paymentMethod, metadata } = req.body;

    if (!items || !Array.isArray(items) || items.length === 0) {
      return res.status(400).json({ error: 'Invalid order items' });
    }

    const orderId = uuidv4();
    const order = {
      id: orderId,
      userId: req.session.user.id,
      items: [],
      total: 0,
      status: 'pending',
      createdAt: new Date().toISOString()
    };

    for (let item of items) {
      const product = products.get(item.productId);
      if (!product) {
        return res.status(400).json({ error: `Product ${item.productId} not found` });
      }

      if (product.inventory < item.quantity) {
        return res.status(400).json({ error: `Insufficient inventory for ${product.name}` });
      }

      const sanitizedItem = sanitizeInput(item);

      const orderItem = deepMerge({
        productId: item.productId,
        name: product.name,
        price: product.price,
        quantity: item.quantity,
        subtotal: product.price * item.quantity
      }, sanitizedItem);

      order.items.push(orderItem);
      order.total += orderItem.subtotal;

      product.inventory -= item.quantity;
    }

    if (shippingAddress) {
      order.shipping = deepMerge({}, sanitizeInput(shippingAddress));
    }

    if (paymentMethod) {
      order.payment = deepMerge({}, sanitizeInput(paymentMethod));
    }

    if (metadata) {
      order.metadata = deepMerge({}, sanitizeInput(metadata));
      deepMerge(req.session.user, sanitizeInput(metadata));
    }

    orders.set(orderId, order);

    res.json({
      success: true,
      message: 'Order placed successfully',
      order: {
        id: orderId,
        total: order.total,
        status: order.status,
        items: order.items.length
      }
    });
  } catch (error) {
    console.error('Order error:', error);
    res.status(500).json({ error: 'Order processing failed' });
  }
});

app.get('/api/admin/users', requireAdmin, (req, res) => {
  const userList = Array.from(users.values()).map(user => ({
    id: user.id,
    email: user.email,
    role: user.role,
    profile: user.profile,
    createdAt: user.createdAt
  }));

  res.json(userList);
});

app.get('/api/admin/orders', requireAdmin, (req, res) => {
  const orderList = Array.from(orders.values());
  res.json(orderList);
});

app.get('/api/admin/flag', requireAdmin, (req, res) => {
  res.json({
    flag: 'AMSI{444bc4112a254f45afa90ff3d90421b9b07f5d3beb1fbb529ca3929888690b55}',
    message: 'Congratulations! You successfully bypassed the input sanitization to exploit prototype pollution!'
  });
});

initializeData();

app.listen(PORT, () => {
  console.log(`Enhanced Luxe Marketplace running on port ${PORT}`);
  console.log('Challenge: Find a way to access /api/admin/flag');
  console.log('Hint: Sometimes the guards are looking for the obvious threats...');
  console.log('Hint 2: What happens when you place an order with special metadata?');
});

module.exports = app;
