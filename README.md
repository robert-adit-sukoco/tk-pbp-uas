# Kelompok PBP-E04 but with Flutter

## Anggota
|              Nama           |    NPM     |
| --------------------------- | ---------- |
| Fasya Prandari Shafira      | 2006483605 |
| Farah Sausan Aulita Adinata | 2006597140 |
| Ario Nugraha Ramadhanu      | 2006486273 |
| Robertus Aditya Sukoco      | 2006523016 |
| Fairuz Satria Mahardika     | 2006486361 |
| Bimasena Putra              | 2006530356 |

## Links
- [APK Releases](https://github.com/robert-adit-sukoco/tk-pbp-uas/releases)
- [GitHub](https://github.com/farahaulita/pbp-tk)

<br></br>

## Latar Belakang
Kelompok kami membuat aplikasi dalam bidang E-Learning bernama LeaN (Learning Environment) yang menawarkan pengalaman pembelajaran yang optimal berbasis online. Pada masa pandemi seperti ini, pembelajaran berbasis online memberikan dampak yang signifikan bagi pendidikan di Indonesia. Adanya teknologi yang dapat membantu pembelajaran online akan sangat membantu perkembangan pendidikan jenjang SD, SMP, dan SMA pada masa pandemi in. Aplikasi LeaN sendiri merupakan aplikasi yang bergerak dalam E-Learning system yang akan membantu murid dan guru.Terdapat dua role yang ditawarkan oleh aplikasi LeaN yaitu role murid dan role guru. Fitur utama yang ditawarkan aplikasi LeaN antara lain, task viewer dan grade viewer untuk murid serta task manager untuk guru. Akses setiap role terhadap modul akan dijelaskan pada poin di bawah. 

Dengan adanya LeaN, akses pendidikan yang ditawarkan dapat memberikan kemudahan bagi murid serta guru yang mengaksesnya. LeaN sebagai aplikasi yang membantu pengumpulan tugas murid serta pemberian nilai juga dapat menjadikan program pembelajaran menjadi efektif dan efisien karena penggunaannya yang mudah. 

<br></br>

## Cerita Aplikasi
Pandemi COVID-19 yang melanda dunia termasuk negara indonesia saat ini, telah menimbulkan banyak dampak terhadap pola kegiatan masyarakat dan infrastruktur negara. Penyebaran virus yang sangat cepat dan sulit dicegah memaksa pemerintah untuk melakukan lockdown, sehingga masyarakat sulit untuk melakukan kegiatan sehari-hari mereka termasuk kegiatan belajar mengajar. Sistem pendidikan termasuk salah satu hal yang paling terdampak oleh pandemi, masyarakat yang biasanya datang ke sekolah atau kampus mereka menjadi terhambat akibat adanya pemberlakuan lockdown.

Dengan adanya masalah tersebut kelompok kami terinspirasi untuk membuat sebuah platform aplikasi yang dapat memfasilitasi kegiatan belajar mengajar secara jarak jauh melalui jaringan internet atau yang biasa disebut pembelajaran daring. Aplikasi ini berisikan fitur yang dibutuhkan dalam belajar mengajar terutama dalam penugasan, pengajar dapat mengupload tugas beserta deadline dan deskripsinya agar dapat diakses oleh siswa, sedangkan siswa dapat mengumpulkan tugas mereka dengan mengupload file yang telah mereka kerjakan. Aplikasi ini sangat bermanfaat karena dapat membantu penugasan dalam kegiatan belajar dan mengajar tetap berjalan di tengah masa pandemi ini. Selain itu, pada aplikasi ini terdapat fitur raport siswa yang dapat digunakan untuk melihat nilai yang telah diberikan, juga kolom komentar untuk mengajukan perbaikan apabila terdapat kesalahan pada penilaian.

<br></br>


## Modul-modul yang Digunakan
### 1. Landing Page
Landing page berisikan profil sekolah yang memakai LeaN sebagai School Management System mereka. Profil sekolah tersebut mencakup deskripsi singkat dan hierarki sekolah. Di pojok kanan atas landing page terdapat tombol login yang akan mengarahkan pengguna ke login page.

### 2. Task Viewer
Pada page ini akan dibuat sebuah tampilan yang mana user yaitu siswa dapat melihat task atau tugas yang ada pada kelas yang bersangkutan. Model dari penampilan tugas ini dalam bentuk card yang di mana dalam card tersebut terdapat informasi mengenai tugas dan juga kantong submisi. Navbar dan profil akan tetap muncul, sama dengan yang ada di dashboard.


### 3. Task Manager
Fitur khusus guru ini dapat digunakan guru untuk melakukan tiga hal yaitu melihat daftar tugas pada fitur task viewer, membuat tugas baru pada fitur create task, dan melakukan penilaian tugas murid pada fitur submission grader.


### 4. Grade Viewer
Setiap murid memiliki halaman grade viewer. Grade viewer menampilkan informasi umum tentang kelas yang diikuti pengguna beserta nilainya dalam bentuk tabel. Untuk mengakses halaman ini, murid perlu mengakses halaman dashboard terlebih dahulu.

### 5. Dashboard
Berisi announcements, Grade Viewer (untuk murid), profile masing-masing akun, kalender (murid dan guru), dan Class Navigation (untuk murid dan guru). Fitur-fitur tersebut akan dimasukkan juga ke Navigation Bar yang terdapat pada dashboard. Fitur grade viewer akan men-direct user ke page Grade Viewer, fitur Class Navigation ditampilkan pada layar dashboard dan dapat men-direct user kedalam page Class yang didalamnya terdapat Task Manager, fitur profile akan men-direct ke halaman profile akun, dan fitur kalender akan ditampilkan di layar dashboard


### 6. Login
<i>Page</i> ini akan meminta <i>user</i> untuk <i>login</i> atau masuk ke dalam akun miliknya. Login user dilakukan dengan memasukan <i>username</i> dan <i>password</i> yang telah diberikan oleh admin secara manual sebelumnya. User yang akan login sebelumnya telah didaftarkan oleh admin sebagai guru atau murid sehingga role dari website ini terbagi menjadi dua yaitu guru dan murid. Tampilan website untuk role guru dan murid juga terdapat perbedaan.

<br></br>

## Peran-peran user

### 1. Guru
Guru berperan untuk memberikan <i>task</i> yang nantinya akan dikerjakan oleh murid yang bersangkutan pada kelas tertentu.

### 2. Murid
Murid berperan untuk mengunggah <i>file</i> yang akan dijadikan submission untuk <i>task</i> yang bersangkutan.

<br></br>

## Cara Integrasi dengan Web Service
Setelah membuat website dari LeaN, kami akan melakukan integrasikan LeaN menjadi sebuah aplikasi mobile yang dapat diakses oleh user yaitu murid dan guru. Integrasi antara front-end yang dibuat menggunakan Flutter dan back-end DJango dilakukan dengan menggunakan fetching data menggunakan package http yang kemudian diaplikasikan untuk asynchronous HTTP request-response. Back-end yang digunakan bersumber dari back-end dari web yang sebelumnya telah dibuat.