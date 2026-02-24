Nama: Ahmad Qomarul Arifin
NIM: 2409116114
Mata Kuliah: Pemrograman Aplikasi Bergerak




📌 PART 5: Shopping Cart Hands-On
🎯 Tujuan Project

Pada sesi ini, saya diminta untuk mencoba sebuah aplikasi Mini E-Commerce Shopping Cart menggunakan Flutter dengan pendekatan state management Provider. Project ini dirancang untuk memberikan pemahaman praktik mengenai bagaimana sebuah aplikasi dapat mengelola data secara dinamis, khususnya dalam konteks sistem keranjang belanja seperti yang terdapat pada aplikasi marketplace modern.

Melalui project ini, saya mempelajari bagaimana ChangeNotifier bekerja dalam mengelola perubahan data, bagaimana state dapat dibagikan ke beberapa halaman sekaligus, serta bagaimana perubahan tersebut langsung mempengaruhi tampilan (UI) tanpa perlu melakukan refresh manual. Selain itu, project ini juga melatih pemahaman dalam mengelola quantity produk, menghitung total harga secara otomatis, serta memastikan sinkronisasi data antar halaman seperti Product Page, Cart Page, dan Checkout Page. Secara keseluruhan, project ini mensimulasikan alur belanja digital yang realistis dan interaktif.

# Konsep yang Digunakan

## Product Model

Product Model merupakan representasi struktur data dari sebuah produk yang ditampilkan dalam aplikasi. Model ini berfungsi sebagai blueprint atau cetak biru untuk setiap produk yang tersedia di dalam sistem. Data yang disimpan meliputi ID produk, nama produk, harga, serta kategori produk.

Dengan adanya Product Model, data menjadi lebih terorganisir dan mudah dikelola. Model ini memungkinkan setiap produk memiliki struktur yang konsisten sehingga dapat digunakan kembali di berbagai bagian aplikasi, seperti pada halaman daftar produk maupun pada halaman keranjang. Pendekatan ini juga membantu dalam penerapan konsep Object-Oriented Programming (OOP) di dalam Flutter.

## Cart Model (ChangeNotifier)

CartModel merupakan komponen inti dalam sistem keranjang belanja yang dibuat dengan mewarisi kelas ChangeNotifier. Dengan pendekatan ini, CartModel bertanggung jawab untuk mengelola seluruh data yang berkaitan dengan keranjang belanja, seperti daftar item yang ditambahkan, jumlah (quantity) masing-masing produk, serta perhitungan total harga.

CartModel tidak hanya menyimpan data, tetapi juga mengatur logika bisnis di dalam aplikasi, seperti menambah produk ke keranjang, mengurangi quantity, menghapus item, dan menghitung total pembayaran. Setiap kali terjadi perubahan data, method notifyListeners() akan dipanggil. Method ini berfungsi untuk memberi sinyal kepada seluruh widget yang sedang “mendengarkan” perubahan state, sehingga tampilan dapat diperbarui secara otomatis dan real-time tanpa perlu pengaturan manual tambahan.

Dengan kata lain, ChangeNotifier membuat sistem menjadi reaktif dan efisien karena UI akan selalu menyesuaikan dengan kondisi data terbaru.

## Provider

Provider digunakan sebagai jembatan untuk menghubungkan CartModel dengan seluruh halaman dalam aplikasi. Dengan membungkus aplikasi menggunakan ChangeNotifierProvider di dalam main.dart, CartModel dapat diakses secara global oleh berbagai halaman seperti Product Page, Cart Page, maupun Checkout Page.

Implementasi ini memungkinkan setiap halaman membaca dan memodifikasi data keranjang yang sama tanpa perlu mengirim data secara manual melalui constructor antar halaman. Provider memastikan bahwa state yang digunakan bersifat terpusat (centralized state management), sehingga meminimalisir duplikasi data dan potensi inkonsistensi.

Dengan penggunaan Provider, aplikasi menjadi lebih terstruktur, mudah dikembangkan, serta lebih scalable jika nantinya ingin ditambahkan fitur yang lebih kompleks seperti integrasi database atau sistem pembayaran.

# Features Checklist

Berikut fitur yang berhasil saya implementasikan pada sesi hands-on:

✔ Product Model
✔ Cart Model with ChangeNotifier
✔ Product List Page
✔ Add to Cart Button
✔ Cart Badge Showing Item Count
✔ Cart Page with All Items
✔ Increase / Decrease Quantity
✔ Remove Item Button
✔ Total Price Calculation
✔ Empty Cart Message

# Struktur Folder
lib/
├── main.dart
└── models/
product.dart
cart_model.dart
cart_item.dart
└── pages/
product_list_page.dart
cart_page.dart
checkout_page.dart

TUGAS RUMAH – Shopping Cart Enhancement

Pada tugas rumah, project dikembangkan lebih lanjut dengan fitur tambahan WAJIB dan BONUS.

🟢 WAJIB (70 Points)

# Berikut fitur wajib yang saya kerjakan:

## Add to Cart dari Product List

User dapat menekan tombol "Add to Cart" pada halaman produk.

Ketika ditekan:

- Produk masuk ke keranjang
- Jika produk sudah ada, maka quantity bertambah
- Badge jumlah item di AppBar otomatis berubah

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/f29cbb44-f7c4-4e37-9392-08e318ccd31b" />

## Menampilkan Cart Items dengan Quantity

Pada Cart Page, semua item yang dimasukkan ditampilkan dalam bentuk list.

Setiap item menampilkan:

- Nama produk
- Harga satuan
- Quantity
- Total harga per item

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/6a3f8aff-c534-45d8-aa96-864a171b66f3" />

## Update Quantity (+ / -)

User dapat:

- Menekan tombol "+" untuk menambah jumlah produk
- Menekan tombol "-" untuk mengurangi jumlah produk
- Jika quantity menjadi 0, maka item otomatis terhapus

  <img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/d1f7d302-5d20-46da-9988-e298b6c5ace9" />

## Remove Item dari Cart

Setiap item memiliki tombol hapus (delete).

Ketika ditekan:
- Item langsung dihapus dari cart
- Total harga otomatis diperbarui

  <img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/4fc7301e-6520-4af7-affe-813cc84f1aca" />

## Perhitungan Total Harga Otomatis

Total harga dihitung berdasarkan rumus:
- harga × quantity
- Perhitungan dilakukan secara dinamis setiap kali ada perubahan data.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/d7e18de8-4f6d-4d26-8a06-803c0fb8a727" />

🟣 BONUS (30 Points)

Selain fitur wajib, saya juga menambahkan fitur bonus untuk meningkatkan nilai.

## Search / Filter Produk (+10)

Saya menambahkan fitur pencarian produk berdasarkan nama.

Cara kerja:
- User mengetik di search bar
- Produk otomatis difilter sesuai kata kunci

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/b7a42a6a-6b5b-4d53-9a69-74c87eb3d63a" />

## Filter Berdasarkan Kategori (+10)

Produk dapat difilter berdasarkan kategori.

kategori:
- Electronics
- Accessories
Ketika kategori dipilih, produk yang ditampilkan hanya sesuai kategori tersebut.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/c43853d3-ff0f-4cec-8e71-c44328749225" />

## Checkout Page (+10)

Saya menambahkan halaman checkout lengkap yang berisi:

- Order Summary
- Daftar item yang dibeli
- Total harga akhir
- Form Pembeli
- Nama lengkap
- Email
- Nomor HP
- Alamat lengkap
- kota
- kode pos
- Metode pembayaran (Dropdown)

Form dilengkapi validasi agar tidak bisa submit jika data kosong.

Setelah submit:

Muncul dialog konfirmasi

Keranjang dikosongkan

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/cf9c8263-8417-4bfa-999d-08784adc0f3e" />

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/67ca2481-77c6-4ffc-9cd4-e051b59a8349" />

## Alur Kerja Sistem (Flow Add → Cart → Checkout)

Dalam aplikasi Mini E-Commerce ini, alur kerja sistem dirancang mengikuti logika belanja digital yang realistis. Pertama, pengguna melihat daftar produk pada Product Page. Setiap produk dapat ditambahkan ke keranjang melalui tombol “Add to Cart”. Ketika tombol ditekan, data produk beserta quantity default akan dikirim ke CartModel, yang secara otomatis memperbarui daftar item di keranjang.

Selanjutnya, pada Cart Page, pengguna dapat meninjau semua item yang telah ditambahkan, menyesuaikan quantity, atau menghapus item tertentu. Setiap perubahan quantity maupun penghapusan item langsung diperhitungkan dalam total harga, berkat mekanisme reaktif dari ChangeNotifier.

Akhirnya, pengguna dapat melanjutkan ke Checkout Page, di mana seluruh ringkasan belanja ditampilkan secara komprehensif. Total harga yang muncul selalu mencerminkan kondisi terbaru dari keranjang. Alur ini mensimulasikan perjalanan belanja yang intuitif dan interaktif, memastikan data tetap konsisten di seluruh halaman tanpa memerlukan refresh manual.









