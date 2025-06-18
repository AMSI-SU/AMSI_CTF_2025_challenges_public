DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS projects;

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    password TEXT NOT NULL
);

CREATE TABLE projects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    project_name TEXT NOT NULL
);

INSERT INTO users (username, password) VALUES ('admin', 'd891521434cc42ea0693fb15708ede66');
INSERT INTO projects (username, project_name) VALUES ('admin', 'super_secret_project');
