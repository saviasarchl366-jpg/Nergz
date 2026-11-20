CREATE TABLE IF NOT EXISTS users (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 username TEXT NOT NULL UNIQUE,
 password_hash TEXT NOT NULL,
 salt TEXT NOT NULL,
 role TEXT NOT NULL CHECK(role IN ('admin','user')),
 created_at INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS sessions (
 token_hash TEXT PRIMARY KEY,
 user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 expires_at INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS sections (
 section_key TEXT PRIMARY KEY,
 title TEXT NOT NULL,
 content TEXT NOT NULL DEFAULT '',
 sort_order INTEGER NOT NULL,
 updated_at INTEGER NOT NULL DEFAULT 0
);
INSERT OR IGNORE INTO sections(section_key,title,content,sort_order) VALUES
('food_info','زانیاری فۆرمی خۆراک','',1),
('food_password','پاسۆردی فۆرمی خۆراک','',2),
('food_phone','ژمارەی تەلەفونی فۆرمی خۆراک','',3);
