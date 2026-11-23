-- Etalase Digital Stella (gabungan)
CREATE DATABASE IF NOT EXISTS ukk_lvl3
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ukk_lvl3;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('super_admin', 'admin', 'siswa') DEFAULT 'siswa'
);

CREATE TABLE IF NOT EXISTS projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    nama_project VARCHAR(150) NOT NULL,
    deskripsi TEXT NOT NULL,
    gambar VARCHAR(255) NOT NULL,
    link_project VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Akun default (password semuanya: password123) -- segera ganti setelah login pertama
INSERT IGNORE INTO users (nama, email, password, role) VALUES
('Super Admin Stella', 'superadmin@stella.sch.id', '$2y$10$7C8r/agxCXnosP8mnSlZbOsWoUaW06UUJtuIFkUHuShVNBJ2pz0S.', 'super_admin'),
('Admin Stella',       'admin@stella.sch.id',      '$2y$10$7C8r/agxCXnosP8mnSlZbOsWoUaW06UUJtuIFkUHuShVNBJ2pz0S.', 'admin'),
('Siswa Contoh',       'siswa@stella.sch.id',      '$2y$10$7C8r/agxCXnosP8mnSlZbOsWoUaW06UUJtuIFkUHuShVNBJ2pz0S.', 'siswa');

-- Contoh karya (memakai gambar yang sudah ada di folder uploads/), hanya ditambahkan jika tabel masih kosong
INSERT INTO projects (user_id, nama_project, deskripsi, gambar, link_project)
SELECT u.id, 'Contoh Karya Siswa',
       'Ini adalah contoh karya. Klik kartu karya di galeri untuk melihat detailnya pada pop-up, lalu coba tambah karya milik Anda sendiri.',
       'project_6b0058ba1fc5b6.19834890.png', 'https://github.com/'
FROM users u
WHERE u.email = 'siswa@stella.sch.id'
  AND NOT EXISTS (SELECT 1 FROM projects);
