<?php
if (isset($_GET['logout'])) {
    setcookie("username", "", time() - 3600);
    setcookie("prefs", "", time() - 3600);
    header("Location: index.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'];
    $theme = $_POST['theme'] ?? 'light';
    if ($username === 'admin') {
        $error = "Access denied for admin.";
    } else {
        $prefs = json_encode([
            "theme" => $theme,
            "userlevel" => "basic"
        ]);
        setcookie("username", $username);
        setcookie("prefs", base64_encode(gzdeflate($prefs)));
        header("Location: chamber.php");
        exit;
    }
}

// Récupérer le thème depuis le cookie si déjà défini
$prefs_raw = $_COOKIE['prefs'] ?? '{}';
$prefs = json_decode(base64_decode(gzinflate($prefs_raw)), true);
$theme = $prefs['theme'] ?? 'light';
$body_class = $theme === 'dark' ? 'dark-mode' : '';
?>

<!DOCTYPE html>
<html>
<head>
    <title>Flag-O-Matic 3000</title>
    <style>
        body {
            font-family: monospace;
            background: #f5f5f5;
            padding: 30px;
            transition: background 0.3s ease, color 0.3s ease;
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

        input, button, select {
            padding: 8px;
            margin: 5px 0;
            width: 100%;
            font-family: monospace;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        .dark-mode input,
        .dark-mode select {
            background-color: #333;
            color: white;
            border: 1px solid #555;
        }

        button {
            background: #222;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background: #444;
        }

        .error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>

<body class="<?= $body_class ?>">
<div class="container">
    <h1>Welcome to the Flag-O-Matic 3000</h1>

    <?php if (isset($error)): ?>
        <p class="error"><?= htmlspecialchars($error) ?></p>
    <?php endif; ?>

    <form method="POST">
        <label for="theme">Choose a Theme:</label>
        <select name="theme" id="theme">
            <option value="light">☀️ Light</option>
            <option value="dark">🌙 Dark</option>
        </select><br><br>
        
        <label for="username">Username:</label>
        <input name="username" id="username" placeholder="Enter your name" required>
        <button type="submit">Enter the Chamber</button>
    </form>
</div>
<script>
    const themeSelect = document.getElementById("theme");

    if (themeSelect.value === "dark") {
        document.body.classList.add("dark-mode");
    }

    themeSelect.addEventListener("change", function () {
        if (this.value === "dark") {
            document.body.classList.add("dark-mode");
        } else {
            document.body.classList.remove("dark-mode");
        }
    });
</script>
</body>
</html>
