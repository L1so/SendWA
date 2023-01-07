# SendWA

Kirim pesan WhatsApp langsung dari terminal, membutuhkan API dari WA Gateway.

## Program Prasyarat
- ImageMagick &rarr; untuk kirim gambar.
- `curl` atau `wget` &rarr; untuk melakukan api call.
- `jq` &rarr; untuk melakukan parsing JSON.

## Daftar Provider

Berikut adalah daftar provider WA Gateway yang sudah di dukung oleh SendWA.

| Provider | Functionality|
| --- | --- |
| OneSender | ✔ |

Bagi provider yang mau diintegrasikan layanannya ke skrip ini, bisa kirim email ke liso17(at)proton.me dengan melampirkan data berikut.

- URL dari API.
- API Key.
- Nomor WhatsApp yang sudah disambungkan ke WA Gateway.

Saya akan menanggapi formulir anda dalam waktu kurang lebih ~3 hari kerja jika tidak sibuk— kemudian ketika sudah terimplementasi, saya akan reply email anda dengan info lebih lanjut.