<?php
$real_flag = file_get_contents("flag.txt") ?: "FLAG{missing_real_flag}";
$username = $_COOKIE['username'] ?? 'guest';
$prefs_raw = $_COOKIE['prefs'] ?? '{}';
$prefs = json_decode(gzinflate(base64_decode($prefs_raw)), true);
$userlevel = $prefs['userlevel'] ?? 'basic';
$theme = $prefs['theme'] ?? 'light';

$body_class = $theme === 'dark' ? 'dark-mode' : '';

function generate_fun_flag($username) {
    $phrases = ["DreamingOf", "Conquers", "H4cks", "Controls", "Outsmarts", "Glitches"];
    $suffixes = ["TheMatrix", "TheSystem", "TheFlagGod"];
    $phrase = $phrases[array_rand($phrases)];
    $suffix = $suffixes[array_rand($suffixes)];
    $frag = strtoupper(substr(md5($username), 0, 6));
    return "FLAG{" . ucfirst($username) . "_$phrase" . "_$suffix" . "_$frag}";
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Flag-O-Matic Chamber</title>
    <style>
        body {
            font-family: monospace;
            background: #f5f5f5;
            padding: 30px;
        }

        .dark-mode {
            background: #121212;
            color: white;
        }

        .container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            max-width: 700px;
            margin: auto;
            box-shadow: 0 0 10px #ccc;
        }

        .dark-mode .container {
            background: #1e1e1e;
            box-shadow: 0 0 10px #444;
        }

        code {
            background: #eee;
            padding: 2px 6px;
            border-radius: 4px;
        }

        .dark-mode code {
            background: #333;
            color: #0f0;
        }

        a {
            color: #333;
        }

        .dark-mode a {
            color: #9cf;
        }
    </style>
</head>

<body class="<?= $body_class ?>">
<div class="container">
    <h1>Welcome to the Flag-O-Matic Chamber</h1>
    <p><strong>User:</strong> <?= htmlspecialchars($username) ?></p>
    <p><strong>Access Level:</strong> <code><?= htmlspecialchars($userlevel) ?></code></p>
    <p><strong>Theme:</strong> <?= htmlspecialchars($theme) ?></p>

    <hr>

    <?php if ($userlevel === 'superuser'): ?>
        <p>Access granted. Your flag:</p>
        <p><code><?= $real_flag ?></code></p>
    <?php else: ?>
        <p>Flag generated just for you:</p>
        <p><code><?= generate_fun_flag($username) ?></code></p>
    <?php endif; ?>

    <p><a href="index.php?logout=1">Logout</a></p>

    <hr>

</div>
</body>
</html>
