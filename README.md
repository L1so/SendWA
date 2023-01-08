# SendWA

Kirim pesan WhatsApp langsung dari terminal, membutuhkan API dari WA Gateway.

## Instalasi
Melalui `git clone`.

	git clone https://github.com/L1so/SendWA.git
	cd SendWA
	./SendWA --install

Melalui `wget`.
	
	wget -O SendWA.zip https://github.com/L1so/SendWA/archive/refs/heads/main.zip
	unzip SendWA.zip && cd SendWA-main
	./SendWA --install
Melalui `curl`.
	
	curl -o SendWA.zip https://github.com/L1so/SendWA/archive/refs/heads/main.zip
	unzip SendWA.zip && cd SendWA-main
	./SendWA --install
Masukkan API Key dan URL pada proses instalasi.
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

Saya akan menanggapi formulir anda dalam waktu kurang lebih ~3 hari kerja jika tidak sibuk.