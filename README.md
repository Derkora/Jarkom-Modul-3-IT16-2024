# Jarkom-Modul-3-IT16-2024

## Anggota Kelompok
| NRP        | Nama                    |
|:----------:|:-----------------------:|
| 5027221020 | Wikri Cahya Syahrila    |
| 5027221021 | Steven Figo             |

### prolog
Planet Caladan sedang mengalami krisis karena kehabisan spice, klan atreides berencana untuk melakukan eksplorasi ke planet arakis dipimpin oleh duke leto mereka meregister domain name `atreides.yyy.com` untuk worker Laravel mengarah pada Leto `Atreides` . Namun ternyata tidak hanya klan atreides yang berusaha melakukan eksplorasi, Klan harkonen sudah mendaftarkan domain name `harkonen.yyy.com` untuk worker PHP mengarah pada Vladimir `Harkonen`

penyelesaian:

### bagian 1

Lakukan konfigurasi sesuai dengan peta yang sudah diberikan.

Kemudian, karena masih banyak spice yang harus dikumpulkan, bantulah para aterides untuk bersaing dengan harkonen dengan kriteria berikut.:
- Semua `CLIENT` harus menggunakan konfigurasi dari DHCP Server.
- Client yang melalui House Harkonen mendapatkan range IP dari [prefix IP].1.14 - [prefix IP].1.28 dan [prefix IP].1.49 - [prefix IP].1.70 
- Client yang melalui House Atreides mendapatkan range IP dari [prefix IP].2.15 - [prefix IP].2.25 dan [prefix IP].2.200 - [prefix IP].2.210 
- Client mendapatkan DNS dari Princess `Irulan` dan dapat terhubung dengan internet melalui DNS tersebut 
- Durasi DHCP server meminjamkan alamat IP kepada Client yang melalui House Harkonen selama 5 menit sedangkan pada client yang melalui House Atreides selama 20 menit. Dengan waktu maksimal dialokasikan untuk peminjaman alamat IP selama 87 menit
*house == switch

penyelesaian:

### bagian 2
Seiring berjalannya waktu kondisi semakin memanas, untuk bersiap perang. Klan Harkonen melakukan deployment sebagai berikut
- Vladimir Harkonen memerintahkan setiap worker(harkonen) PHP, untuk melakukan konfigurasi virtual host untuk website berikut dengan menggunakan php 7.3.
- Aturlah agar Stilgar dari fremen dapat dapat bekerja sama dengan maksimal, lalu lakukan testing dengan 5000 request dan 150 request/second.
- Karena diminta untuk menuliskan peta tercepat menuju spice, buatlah analisis hasil testing dengan 500 request dan 50 request/second masing-masing algoritma Load Balancer dengan ketentuan sebagai berikut:
    - Nama Algoritma Load Balancer
    - Report hasil testing pada Apache Benchmark
    - Grafik request per second untuk masing masing algoritma. 
    - Analisis 
- Dengan menggunakan algoritma Least-Connection, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 1000 request dengan 10 request/second, kemudian tambahkan grafiknya pada peta. 
- Selanjutnya coba tambahkan keamanan dengan konfigurasi autentikasi di LB dengan dengan kombinasi username: “secmart” dan password: “kcksyyy”, dengan yyy merupakan kode kelompok. Terakhir simpan file “htpasswd” nya di /etc/nginx/supersecret/ 
- Lalu buat untuk setiap request yang mengandung /dune akan di proxy passing menuju halaman https://www.dunemovie.com.au/.  `hint: (proxy_pass)`
- Selanjutnya LB ini hanya boleh diakses oleh client dengan IP [Prefix IP].1.37, [Prefix IP].1.67, [Prefix IP].2.203, dan [Prefix IP].2.207. `hint: (fixed in dulu clientnya)`

penyelesaian:

### bagian 3
Tidak mau kalah dalam perburuan spice, House atreides juga mengatur para pekerja di `atreides.yyy.com`.
- Semua data yang diperlukan, diatur pada Chani dan harus dapat diakses oleh Leto, Duncan, dan Jessica. 
- Leto, Duncan, dan Jessica memiliki `atreides` Channel sesuai dengan quest guide berikut. Jangan lupa melakukan instalasi PHP8.0 dan Composer 
- `atreides` Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request dengan 10 request/second. Tambahkan response dan hasil testing pada grimoire.
    - POST /auth/register 
    - POST /auth/login 
    - GET /me 
- Untuk memastikan ketiganya bekerja sama secara adil untuk mengatur `atreides` Channel maka implementasikan Proxy Bind pada Eisen untuk mengaitkan IP dari Leto, Duncan, dan Jessica. 
- Untuk meningkatkan performa dari Worker, coba implementasikan PHP-FPM pada Leto, Duncan, dan Jessica. Untuk testing kinerja naikkan 
    - pm.max_children
    - pm.start_servers
    - pm.min_spare_servers
    - pm.max_spare_servers
- sebanyak tiga percobaan dan lakukan testing sebanyak 100 request dengan 10 request/second kemudian berikan hasil analisisnya pada PDF.
- Nampaknya hanya menggunakan PHP-FPM tidak cukup untuk meningkatkan performa dari worker maka implementasikan Least-Conn pada Stilgar. Untuk testing kinerja dari worker tersebut dilakukan sebanyak 100 request dengan 10 request/second. 

#### PS:
Peta dikumpulkan dalam bentuk PDF dengan format yyy_Spice.pdf
yyy merupakan kode kelompok

penyelesaian:
