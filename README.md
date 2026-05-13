# Rein Store - Tugas Praktikum PBM 2026

Aplikasi Flutter untuk manajemen katalog produk yang terintegrasi dengan REST API.

## Identitas
- **Nama:** Advent Nito Reinner Janoma
- **NIM:** 242410102094
- **Kelas:** PBM A
- **Mata Kuliah:** Pemrograman Berbasis Mobile

## Fitur Aplikasi
- Login menggunakan NIM sebagai username dan password
- Melihat daftar draft produk
- Menambah produk baru
- Menghapus produk (soft delete)
- Submit tugas dengan GitHub URL

## Struktur Project
lib/
├── main.dart
├── constants.dart
├── models/
│   ├── user_model.dart
│   └── product_model.dart
├── services/
│   └── api_service.dart
└── pages/
├── login_page.dart
├── home_page.dart
├── add_product_page.dart
└── submit_page.dart

## Screenshot
### Login
![Login](screenshots/halaman%20login.png)

### Katalog Produk
![Katalog](screenshots/halaman%20katalog.png)

### Tambah Produk
![Tambah Produk](screenshots/tambah%20produk.png)

### Submit Tugas
![Submit](screenshots/halaman%20submit%20tug....png)

### Submit Berhasil
![Submit Berhasil](screenshots/submit%20tugas%20berhasil.png)

## Teknologi yang Digunakan
- Flutter 3.41.2
- Dart
- REST API (https://task.itprojects.web.id)
- flutter_secure_storage
- http package

## Status Pengumpulan
 **Tugas berhasil disubmit**
- Data produk sudah masuk ke dashboard asisten praktikum
- Repository GitHub: https://github.com/adventnito/Tugas-PBM-Flutter