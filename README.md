📱 Suitmedia Mobile Developer Test - Flutter

Project ini merupakan implementasi test untuk posisi Mobile Developer dengan menggunakan Flutter, BLoC Pattern, dan API Pagination. Aplikasi terdiri dari tiga halaman utama dengan alur input nama, menampilkan nama yang dipilih, serta pengambilan data user dari API.

🚀 Features
1️⃣ First Screen
- User memasukkan nama
- Tombol untuk pindah ke Second Screen
- Validasi palindrom (jika diperlukan)

2️⃣ Second Screen
- Menampilkan nama yang dimasukkan pada First Screen
- Menampilkan Selected User dari Third Screen (default: “Selected User Name”)
- Tombol untuk menuju Third Screen

3️⃣ Third Screen
- Mengambil data user dari publik API (example: reqres.in)
- Menampilkan list user dengan:
    - Avatar
    - Fullname
    - Email
- Infinite scroll / pagination
- Pull-to-refresh
- Klik salah satu user → kembali ke Second Screen dan menampilkan nama user terpilih
