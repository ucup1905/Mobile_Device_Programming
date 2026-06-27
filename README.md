# Coffeetivity

Aplikasi pencari coffee shop untuk produktivitas (WFC - Work From Cafe) di area Malang.

## Fitur
- Splash Screen + Onboarding + Login
- Home Screen: rekomendasi & coffee shop terdekat
- Search + Filter (suasana, fasilitas)
- Detail Shop + Review
- Peta interaktif (OpenStreetMap via flutter_map)
- Navigasi ke coffee shop
- Write Review
- Profil pengguna

## Dependencies
- `flutter_map: ^6.1.0` — peta OpenStreetMap (gratis, tanpa API key)
- `latlong2: ^0.9.0` — koordinat lat/lng untuk flutter_map

---

## Cara Setup & Jalankan

### 1. Pastikan Flutter sudah terinstall
```
flutter --version
```
Minimal Flutter 3.10.0, Dart 3.0.0

### 2. Extract folder ini, lalu masuk ke direktori project
```
cd coffeetivity
```

### 3. Install dependencies
```
flutter pub get
```

### 4. Jalankan di emulator / device
```
flutter run
```

Atau jalankan di web (tanpa emulator):
```
flutter run -d chrome
```

### 5. Build APK (Android)
```
flutter build apk --release
```
APK akan ada di: `build/app/outputs/flutter-apk/app-release.apk`

---

## Struktur Project
```
coffeetivity/
├── lib/
│   └── main.dart          ← Semua kode app (single file)
├── pubspec.yaml           ← Dependencies
├── android/               ← Config Android
├── ios/                   ← Config iOS
└── README.md
```

## Catatan
- App menggunakan **OpenStreetMap** — tidak perlu Google Maps API key
- Semua data coffee shop masih dummy (hardcoded)
- Untuk production: tambahkan backend / Firestore untuk data real
- Untuk GPS real: tambahkan package `geolocator` + `permission_handler`

## Optional Packages (uncomment di pubspec.yaml)
| Package | Fungsi |
|---|---|
| `geolocator` | Deteksi lokasi GPS real |
| `permission_handler` | Minta izin lokasi di runtime |
| `url_launcher` | Buka Google Maps / WhatsApp |
| `shared_preferences` | Simpan favorit & sesi login |
| `cached_network_image` | Load foto dari URL |
