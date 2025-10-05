# Widgets Reusable - Portal Mahasiswa

Folder ini berisi komponen-komponen UI yang dapat digunakan kembali di seluruh aplikasi untuk menjaga konsistensi desain.

---

## 📱 appBar.dart

File ini berisi 3 komponen utama:

### 1. **CustomAppBar** - AppBar yang dapat dikustomisasi

AppBar dengan warna konsisten `#233746` yang dapat disesuaikan untuk berbagai kebutuhan halaman.

#### Parameters:
- `title` (String) - Judul yang ditampilkan di AppBar
- `showBackButton` (bool) - Tampilkan tombol back (default: false)
- `showMenuButton` (bool) - Tampilkan tombol menu drawer (default: false)
- `showProfileMenu` (bool) - Tampilkan menu profil (default: true)
- `onBackPressed` (VoidCallback?) - Custom action untuk tombol back
- `onMenuPressed` (VoidCallback?) - Custom action untuk tombol menu
- `additionalActions` (List<Widget>?) - Widget actions tambahan

#### Contoh Penggunaan:

**Dashboard (dengan menu & profile):**
```dart
import '../widgets/appBar.dart';

Scaffold(
  appBar: CustomAppBar(
    title: 'Dashboard',
    showMenuButton: true,
    showProfileMenu: true,
  ),
  drawer: const AppDrawer(),
  body: ...
)
```

**Halaman Detail (dengan back button):**
```dart
Scaffold(
  appBar: const CustomAppBar(
    title: 'Profil Saya',
    showBackButton: true,
    showProfileMenu: false,
  ),
  body: ...
)
```

**Dengan Custom Actions:**
```dart
Scaffold(
  appBar: CustomAppBar(
    title: 'Notifikasi',
    showBackButton: true,
    additionalActions: [
      IconButton(
        icon: Icon(Icons.search, color: Colors.white),
        onPressed: () {
          // Handle search
        },
      ),
    ],
  ),
  body: ...
)
```

---

### 2. **ProfileMenu** - Menu Popup untuk Profil User

Widget popup menu yang menampilkan informasi user dan menu navigasi.

#### Menu Items:
1. **Info Akun** - Menampilkan nama dan email
2. **Profil** - Navigasi ke halaman profil
3. **Settings** - Navigasi ke pengaturan
4. **Keluar** - Logout dari aplikasi

#### Contoh Penggunaan Standalone:

```dart
// Jika ingin menggunakan ProfileMenu sendiri tanpa CustomAppBar
actions: [
  ProfileMenu(
    onSelected: (value) {
      if (value == 2) {
        // Navigate ke profil
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilPage()),
        );
      }
    },
  ),
]
```

## 🎨 Warna Tema

Semua komponen menggunakan warna konsisten:
- **Primary Color**: `#233746` (Biru gelap)
- **Background**: `Colors.grey.shade100`
- **Text Primary**: `Colors.white`
- **Text Secondary**: `Colors.black87`

---

## 📝 Catatan

- Semua widget telah dioptimasi untuk performa
- Mendukung material design guidelines
- Responsif untuk berbagai ukuran layar
- Dapat dikustomisasi sesuai kebutuhan tanpa mengubah file source

---

## 🔄 Update History

- **v1.0** - Initial release dengan CustomAppBar, ProfileMenu, dan AppDrawer

