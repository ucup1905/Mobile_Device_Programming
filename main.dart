import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const CoffeetivityApp());
}

// ==================== THEME & COLORS ====================
class AppColors {
  static const Color primary = Color(0xFF3B1F0D);
  static const Color primaryLight = Color(0xFF6B3A2A);
  static const Color accent = Color(0xFFB5742A);
  static const Color background = Color(0xFFF9F4EF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textMuted = Color(0xFF9E9E9E);
  static const Color border = Color(0xFFE8DDD4);
  static const Color starColor = Color(0xFFF59E0B);
  static const Color greenOpen = Color(0xFF22C55E);
  static const Color chipBg = Color(0xFFF0EAE3);
  static const Color chipSelected = Color(0xFF3B1F0D);
}

// ==================== MODELS ====================
class CoffeeShop {
  final String id;
  final String name;
  final String address;
  final double rating;
  final int reviewCount;
  final String distance;
  final String openHours;
  final List<String> facilities;
  final String atmosphere;
  final String imageAsset;
  final String description;
  final bool isOpen;
  final double lat;
  final double lng;

  const CoffeeShop({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.reviewCount,
    required this.distance,
    required this.openHours,
    required this.facilities,
    required this.atmosphere,
    required this.imageAsset,
    required this.description,
    this.isOpen = true,
    this.lat = -7.9797,
    this.lng = 112.6304,
  });
}

class Review {
  final String userName;
  final String timeAgo;
  final double rating;
  final String text;
  final List<String> tags;

  const Review({
    required this.userName,
    required this.timeAgo,
    required this.rating,
    required this.text,
    required this.tags,
  });
}

// ==================== DUMMY DATA ====================
final List<CoffeeShop> dummyCoffeeShops = [
  const CoffeeShop(
    id: '1',
    name: 'KOPIBANG',
    address: 'Jl. Cokro Sujono No.12, Jogoyudan, Lumajang',
    rating: 4.4,
    reviewCount: 392,
    distance: '500 m',
    openHours: '09.00 - 22.00',
    facilities: ['Dekat Kota', 'Stop Kontak', 'Indoor'],
    atmosphere: 'Tenang',
    imageAsset: 'kopibang.png',
    description:
        'Tempat nyaman dengan suasana tenang, cocok untuk kerja, meeting, atau belajar.',
    isOpen: true,
    lat: -8.1347549,
    lng: 113.227003,
  ),
  const CoffeeShop(
    id: '2',
    name: 'Terracotta',
    address: 'Jalan MT. Haryono, Lumajang',
    rating: 3.6,
    reviewCount: 117,
    distance: '750 m',
    openHours: '09.00 - 00.00',
    facilities: ['Wi-Fi Cepat', 'Stop Kontak', 'Indoor', 'Cozy'],
    atmosphere: 'Cozy',
    imageAsset: 'terracotta',
    description:
        'Kafe dengan konsep simpel yang nyaman untuk bekerja atau bersantai.',
    isOpen: true,
    lat: -8.1328905,
    lng: 113.2296968,
  ),
  const CoffeeShop(
    id: '3',
    name: 'Kopi Begog Van De Kub',
    address: 'Jl. Jendral Haryono No.131, Lumajang',
    rating: 4.6,
    reviewCount: 364,
    distance: '1.2 km',
    openHours: '09.00 - 23.00',
    facilities: ['Wi-Fi', 'Indoor', 'Tenang'],
    atmosphere: 'Tenang',
    imageAsset: 'kopibegog',
    description:
        'Specialty coffee dengan ambience minimalis dan koneksi internet stabil.',
    isOpen: true,
    lat: -8.1318433,
    lng: 113.2301828,
  ),
  const CoffeeShop(
    id: '4',
    name: 'OALA Coffee',
    address: 'Jl. Juanda No.36, Lumajang',
    rating: 4.2,
    reviewCount: 231,
    distance: '1.4 km',
    openHours: '09.00 - 22.00',
    facilities: ['Wi-Fi', 'Outdoor', 'Stop Kontak', 'Ramai'],
    atmosphere: 'Ramai',
    imageAsset: 'oala',
    description:
        'Kafe outdoor yang cocok untuk casual meeting dan kerja santai.',
    isOpen: true,
    lat: -8.1277294,
    lng: 113.2303725,
  ),
  const CoffeeShop(
    id: '5',
    name: 'O-GUT!',
    address: 'Jl. Jendral Haryono No.44, Lumajang',
    rating: 4.6,
    reviewCount: 304,
    distance: '650 m',
    openHours: '09.00 - 22.30',
    facilities: ['Wi-Fi Cepat', 'Stop Kontak', 'Indoor'],
    atmosphere: 'Tenang',
    imageAsset: 'ogut',
    description:
        'Pilihan tepat untuk WFC dengan koneksi internet cepat dan suasana kondusif.',
    isOpen: true,
    lat: -8.1369776,
    lng: 113.2267241,
  ),
];

final List<Review> dummyReviews = [
  const Review(
    userName: 'Dinda A.',
    timeAgo: '2 hari lalu',
    rating: 5.0,
    text:
        'Tempatnya nyaman, wi-fi nya cepat, banyak colokan. Cocok banget buat WFC seharian!',
    tags: ['Wi-Fi Cepat', 'Stop Kontak', 'Tenang'],
  ),
  const Review(
    userName: 'Rizky Pratama',
    timeAgo: '1 minggu lalu',
    rating: 4.0,
    text: 'Suasana enak, tapi kadang rame di jam siang.',
    tags: ['Cozy', 'Indoor'],
  ),
  const Review(
    userName: 'Sarah M.',
    timeAgo: '2 minggu lalu',
    rating: 5.0,
    text: 'Kopi enak, tempat bersih, AC dingin. Recommended banget!',
    tags: ['AC', 'Non Smoking', 'Tenang'],
  ),
];

// ==================== HELPER WIDGET ====================
// Widget foto dengan fallback ke icon kalau file belum ada
Widget shopImage({
  required String imageAsset,
  required double width,
  required double height,
  BorderRadius? borderRadius,
}) {
  final Widget img = Image.asset(
    'assets/images/$imageAsset.jpg',
    width: width,
    height: height,
    fit: BoxFit.cover,
    errorBuilder: (_, __, ___) => Container(
      width: width,
      height: height,
      color: const Color(0xFF4A2C1A),
      child: Icon(Icons.local_cafe_rounded,
          color: Colors.white.withOpacity(0.4), size: width * 0.45),
    ),
  );

  if (borderRadius != null) {
    return ClipRRect(borderRadius: borderRadius, child: img);
  }
  return img;
}

// ==================== MAIN APP ====================
class CoffeetivityApp extends StatelessWidget {
  const CoffeetivityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffeetivity',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const MainScreen(),
      },
    );
  }
}

// ==================== SPLASH SCREEN ====================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(Icons.local_cafe_rounded,
                    color: Colors.white, size: 54),
              ),
              const SizedBox(height: 20),
              const Text(
                'Coffeetivity',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Find the best coffee shop\nfor your productivity',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14, color: AppColors.textSecondary, height: 1.5),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _dot(true),
                  const SizedBox(width: 6),
                  _dot(false),
                  const SizedBox(width: 6),
                  _dot(false),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Work · Focus · Enjoy',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot(bool active) => Container(
        width: active ? 20 : 8,
        height: 8,
        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.border,
          borderRadius: BorderRadius.circular(4),
        ),
      );
}

// ==================== ONBOARDING SCREEN ====================
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                'Temukan Coffee Shop\nTerbaik untuk\nProduktivitasmu',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Filter suasana kerja, baca review nyata, dan temukan tempat favoritmu.',
                style: TextStyle(
                    fontSize: 15, color: AppColors.textSecondary, height: 1.6),
              ),
              const SizedBox(height: 40),
              Center(
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.laptop_mac_rounded,
                      size: 120, color: AppColors.accent),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _dot(true),
                  const SizedBox(width: 6),
                  _dot(false),
                  const SizedBox(width: 6),
                  _dot(false),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: const Text('Selanjutnya',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot(bool active) => Container(
        width: active ? 20 : 8,
        height: 8,
        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.border,
          borderRadius: BorderRadius.circular(4),
        ),
      );
}

// ==================== LOGIN SCREEN ====================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              const Text('Masuk ke Coffeetivity',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary)),
              const SizedBox(height: 6),
              const Text('Selamat datang kembali!',
                  style:
                      TextStyle(fontSize: 14, color: AppColors.textSecondary)),
              const SizedBox(height: 32),
              _socialBtn(Icons.g_mobiledata, 'Masuk dengan Google', Colors.red),
              const SizedBox(height: 12),
              _socialBtn(Icons.email_outlined, 'Masuk dengan Email',
                  AppColors.primary),
              const SizedBox(height: 24),
              const Row(children: [
                Expanded(child: Divider(color: AppColors.border)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('atau',
                      style:
                          TextStyle(color: AppColors.textMuted, fontSize: 13)),
                ),
                Expanded(child: Divider(color: AppColors.border)),
              ]),
              const SizedBox(height: 24),
              _label('Email'),
              const SizedBox(height: 8),
              _textField(_emailController, 'masukkan email anda', false),
              const SizedBox(height: 16),
              _label('Password'),
              const SizedBox(height: 8),
              TextField(
                controller: _passController,
                obscureText: _obscure,
                decoration: InputDecoration(
                  hintText: 'masukkan password',
                  hintStyle:
                      const TextStyle(color: AppColors.textMuted, fontSize: 14),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textMuted,
                        size: 20),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Align(
                alignment: Alignment.centerRight,
                child: Text('Lupa password?',
                    style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: const Text('Masuk',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum punya akun? ",
                      style: TextStyle(
                          color: AppColors.textSecondary, fontSize: 14)),
                  Text('Daftar',
                      style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialBtn(IconData icon, String label, Color color) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: const BorderSide(color: AppColors.border),
        backgroundColor: AppColors.surface,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 10),
          Text(label,
              style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(text,
      style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary));

  Widget _textField(TextEditingController ctrl, String hint, bool obscure) {
    return TextField(
      controller: ctrl,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

// ==================== MAIN SCREEN (Bottom Nav) ====================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    ReviewListScreen(),
    MapScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.border, width: 1)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(0, Icons.home_rounded, 'Beranda'),
                _navItem(1, Icons.search_rounded, 'Cari'),
                _navItem(2, Icons.star_rounded, 'Review'),
                _navItem(3, Icons.map_rounded, 'Peta'),
                _navItem(4, Icons.person_rounded, 'Profil'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final bool selected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              color: selected ? AppColors.primary : AppColors.textMuted,
              size: 26),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(
                color: selected ? AppColors.primary : AppColors.textMuted,
                fontSize: 11,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
              )),
        ],
      ),
    );
  }
}

// ==================== HOME SCREEN ====================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> atmospheres = ['Tenang', 'Ramai', 'Cozy', 'Outdoor'];
  final List<IconData> atmosphereIcons = [
    Icons.volume_off_rounded,
    Icons.volume_up_rounded,
    Icons.weekend_rounded,
    Icons.park_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(child: _buildSearchBar()),
          SliverToBoxAdapter(child: _buildFeaturedCard()),
          SliverToBoxAdapter(child: _buildAtmosphereSection()),
          SliverToBoxAdapter(child: _buildNearbySection()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 16),
      child: Row(
        children: [
          const Icon(Icons.location_on_rounded,
              color: AppColors.accent, size: 18),
          const SizedBox(width: 4),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lokasi Anda',
                    style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                Text('Lumajang, Jawa Timur',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(Icons.notifications_outlined,
                size: 20, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchScreen()),
          ),
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: AppColors.textMuted, size: 20),
                SizedBox(width: 10),
                Text('Cari coffee shop...',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCard() {
    final shop = dummyCoffeeShops[0];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rekomendasi Untukmu',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'Lihat semua',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => _openDetail(context, shop),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── FOTO FEATURED ──
                  Stack(
                    children: [
                      shopImage(
                        imageAsset: shop.imageAsset,
                        width: double.infinity,
                        height: 180,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.bookmark_border,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shop.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: AppColors.starColor,
                              size: 16,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '${shop.rating} (${shop.reviewCount})',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '· ${shop.distance}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: shop.facilities
                              .take(3)
                              .map((f) => _facilityChip(f))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAtmosphereSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Kategori Suasana',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                4, (i) => _atmosphereItem(atmospheres[i], atmosphereIcons[i])),
          ),
        ],
      ),
    );
  }

  // Wrap _atmosphereItem dengan GestureDetector + navigasi ke SearchScreen
  Widget _atmosphereItem(String label, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SearchScreen(initialAtmosphere: label),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(height: 6),
          Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildNearbySection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Coffee Shop Terdekat',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary)),
              Text('Lihat semua',
                  style: TextStyle(
                      fontSize: 13,
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 14),
          ...dummyCoffeeShops.take(3).map((shop) => _nearbyCard(shop)),
        ],
      ),
    );
  }

  Widget _nearbyCard(CoffeeShop shop) {
    return GestureDetector(
      onTap: () => _openDetail(context, shop),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // ── FOTO NEARBY ──
            shopImage(
              imageAsset: shop.imageAsset,
              width: 60,
              height: 60,
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(shop.name,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppColors.starColor, size: 13),
                      const SizedBox(width: 2),
                      Text('${shop.rating} (${shop.reviewCount})',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textSecondary)),
                      Text(' · ${shop.distance}',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textMuted)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Buka · ${shop.openHours}',
                      style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.greenOpen,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                color: AppColors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _facilityChip(String label) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: AppColors.chipBg, borderRadius: BorderRadius.circular(20)),
        child: Text(label,
            style: const TextStyle(
                fontSize: 12,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500)),
      );

  void _openDetail(BuildContext context, CoffeeShop shop) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => DetailScreen(shop: shop)));
  }
}

// ==================== SEARCH SCREEN ====================
class SearchScreen extends StatefulWidget {
  final String initialAtmosphere;
  const SearchScreen({super.key, this.initialAtmosphere = ''});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  bool _showFilter = false;

  List<String> selectedFacilities = [];
  String selectedAtmosphere = '';

  final List<String> facilities = [
    'Wi-Fi Cepat',
    'Stop Kontak',
    'Indoor',
    'Outdoor',
    'AC',
    'Non Smoking',
    'Ruang Meeting'
  ];
  final List<String> atmospheres = ['Tenang', 'Sedang', 'Ramai'];

  List<CoffeeShop> get filteredShops {
    return dummyCoffeeShops.where((shop) {
      final matchQuery = _query.isEmpty ||
          shop.name.toLowerCase().contains(_query.toLowerCase());
      final matchAtmo =
          selectedAtmosphere.isEmpty || shop.atmosphere == selectedAtmosphere;
      final matchFac = selectedFacilities.isEmpty ||
          selectedFacilities.every((f) => shop.facilities.contains(f));
      return matchQuery && matchAtmo && matchFac;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchHeader(),
            if (_showFilter) _buildFilterPanel(),
            Expanded(
              child: filteredShops.isEmpty
                  ? const Center(
                      child: Text('Tidak ada hasil',
                          style: TextStyle(color: AppColors.textMuted)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredShops.length,
                      itemBuilder: (_, i) =>
                          _searchResultCard(filteredShops[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Cari coffee shop...',
                hintStyle:
                    const TextStyle(color: AppColors.textMuted, fontSize: 14),
                prefixIcon: const Icon(Icons.search,
                    color: AppColors.textMuted, size: 20),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => setState(() => _showFilter = !_showFilter),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _showFilter ? AppColors.primary : AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.tune_rounded,
                  color: _showFilter ? Colors.white : AppColors.textPrimary,
                  size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPanel() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Filter Suasana Kerja',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          _filterSection(
              'Tingkat Kebisingan',
              Row(
                children: atmospheres
                    .map((a) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _filterChip(
                              a,
                              selectedAtmosphere == a,
                              () => setState(() => selectedAtmosphere =
                                  selectedAtmosphere == a ? '' : a)),
                        ))
                    .toList(),
              )),
          const SizedBox(height: 12),
          _filterSection(
              'Fasilitas',
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: facilities
                    .map((f) =>
                        _filterChip(f, selectedFacilities.contains(f), () {
                          setState(() {
                            if (selectedFacilities.contains(f)) {
                              selectedFacilities.remove(f);
                            } else {
                              selectedFacilities.add(f);
                            }
                          });
                        }))
                    .toList(),
              )),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => setState(() => _showFilter = false),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Text('Terapkan Filter (${filteredShops.length})',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        content,
      ],
    );
  }

  Widget _filterChip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.chipBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selected ? AppColors.primary : AppColors.border),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: selected ? Colors.white : AppColors.textPrimary)),
      ),
    );
  }

  Widget _searchResultCard(CoffeeShop shop) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => DetailScreen(shop: shop))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // ── FOTO SEARCH RESULT ──
            shopImage(
              imageAsset: shop.imageAsset,
              width: 90,
              height: 90,
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(14)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shop.name,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: AppColors.starColor, size: 13),
                        Text(' ${shop.rating} (${shop.reviewCount})',
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textSecondary)),
                        Text(' · ${shop.distance}',
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textMuted)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('Buka · ${shop.openHours}',
                        style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.greenOpen,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: shop.facilities
                          .take(2)
                          .map((f) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                    color: AppColors.chipBg,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(f,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textPrimary)),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(Icons.bookmark_border,
                  color: AppColors.textMuted, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== DETAIL SCREEN ====================
class DetailScreen extends StatefulWidget {
  final CoffeeShop shop;
  const DetailScreen({super.key, required this.shop});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final shop = widget.shop;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: const Icon(Icons.arrow_back,
                    color: AppColors.primary, size: 20),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () => setState(() => _isFavorite = !_isFavorite),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : AppColors.primary,
                      size: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: const Icon(Icons.share_outlined,
                    color: AppColors.primary, size: 20),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              // ── FOTO DETAIL HEADER ──
              background: shopImage(
                imageAsset: shop.imageAsset,
                width: double.infinity,
                height: 220,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(shop.name,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppColors.starColor, size: 16),
                      Text(' ${shop.rating} (${shop.reviewCount} ulasan)',
                          style: const TextStyle(
                              fontSize: 13, color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.greenOpen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('Buka',
                            style: TextStyle(
                                color: AppColors.greenOpen,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 8),
                      Text('· ${shop.openHours}',
                          style: const TextStyle(
                              fontSize: 13, color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          color: AppColors.textMuted, size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                          child: Text(shop.address,
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary))),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Fasilitas',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        shop.facilities.map((f) => _facilityBadge(f)).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text('Deskripsi',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  Text(shop.description,
                      style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          height: 1.6)),
                  const SizedBox(height: 20),
                  const Text('Ulasan Pengguna',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 12),
                  ...dummyReviews.map((r) => _reviewCard(r)),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map_outlined, size: 18),
                label: const Text('Rute'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => WriteReviewScreen(shop: widget.shop))),
                icon: const Icon(Icons.rate_review_outlined,
                    size: 18, color: Colors.white),
                label: const Text('Tulis Ulasan',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _facilityBadge(String label) {
    final IconData icon;
    if (label.contains('Wi-Fi')) {
      icon = Icons.wifi;
    } else if (label.contains('Stop'))
      icon = Icons.power_outlined;
    else if (label.contains('Indoor'))
      icon = Icons.home_outlined;
    else if (label.contains('AC'))
      icon = Icons.ac_unit_outlined;
    else if (label.contains('Outdoor'))
      icon = Icons.park_outlined;
    else
      icon = Icons.check_circle_outline;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.chipBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: AppColors.primary),
          const SizedBox(width: 5),
          Text(label,
              style:
                  const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _reviewCard(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.accent.withOpacity(0.2),
                radius: 18,
                child: Text(review.userName[0],
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, color: AppColors.accent)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.userName,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    Text(review.timeAgo,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textMuted)),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                    5,
                    (i) => Icon(
                          i < review.rating.floor()
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          color: AppColors.starColor,
                          size: 14,
                        )),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(review.text,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: review.tags
                .map((t) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.chipBg,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check,
                              size: 11, color: AppColors.accent),
                          const SizedBox(width: 3),
                          Text(t,
                              style: const TextStyle(
                                  fontSize: 11, color: AppColors.textPrimary)),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ==================== REVIEW LIST SCREEN ====================
class ReviewListScreen extends StatelessWidget {
  const ReviewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shop = dummyCoffeeShops[0];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Ulasan Pengguna',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _ratingOverview(shop),
          const SizedBox(height: 20),
          _sortRow(),
          const SizedBox(height: 16),
          ...dummyReviews.map((r) => _reviewCard(r)),
          ...dummyReviews.map((r) => _reviewCard(r)),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: ElevatedButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => WriteReviewScreen(shop: shop))),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 0,
          ),
          child: const Text('Tulis Ulasan',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }

  Widget _ratingOverview(CoffeeShop shop) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text('${shop.rating}',
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary)),
              Row(
                children: List.generate(
                    5,
                    (i) => Icon(
                          i < shop.rating.floor()
                              ? Icons.star_rounded
                              : Icons.star_half_rounded,
                          color: AppColors.starColor,
                          size: 18,
                        )),
              ),
              const SizedBox(height: 4),
              Text('${shop.reviewCount} ulasan',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textMuted)),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                _ratingBar(5, 0.8),
                _ratingBar(4, 0.6),
                _ratingBar(3, 0.2),
                _ratingBar(2, 0.1),
                _ratingBar(1, 0.05),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingBar(int star, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text('$star',
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(width: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: AppColors.chipBg,
                valueColor: const AlwaysStoppedAnimation(AppColors.starColor),
                minHeight: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sortRow() {
    return Row(
      children: [
        _sortChip('Semua', true),
        const SizedBox(width: 8),
        _sortChip('Terbaru', false),
        const SizedBox(width: 8),
        _sortChip('Tertinggi', false),
        const SizedBox(width: 8),
        _sortChip('Terendah', false),
      ],
    );
  }

  Widget _sortChip(String label, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: selected ? AppColors.primary : AppColors.border),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : AppColors.textPrimary)),
    );
  }

  Widget _reviewCard(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.accent.withOpacity(0.15),
                radius: 20,
                child: Text(review.userName[0],
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                        fontSize: 16)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review.userName,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14)),
                      Text(review.timeAgo,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textMuted)),
                    ]),
              ),
              Row(
                  children: List.generate(
                      5,
                      (i) => Icon(
                            i < review.rating.floor()
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            color: AppColors.starColor,
                            size: 15,
                          ))),
            ],
          ),
          const SizedBox(height: 10),
          Text(review.text,
              style: const TextStyle(
                  fontSize: 14, color: AppColors.textSecondary, height: 1.5)),
          const SizedBox(height: 8),
          Wrap(
              spacing: 6,
              children: review.tags
                  .map((t) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: AppColors.chipBg,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          const Icon(Icons.check,
                              size: 11, color: AppColors.accent),
                          const SizedBox(width: 3),
                          Text(t, style: const TextStyle(fontSize: 11)),
                        ]),
                      ))
                  .toList()),
        ],
      ),
    );
  }
}

// ==================== WRITE REVIEW SCREEN ====================
class WriteReviewScreen extends StatefulWidget {
  final CoffeeShop shop;
  const WriteReviewScreen({super.key, required this.shop});

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  double _rating = 4.0;
  final Map<String, int> _aspectRatings = {
    'Wi-Fi': 4,
    'Kebisingan': 3,
    'Kenyamanan': 5,
    'Fasilitas': 4,
    'Kebersihan': 5,
  };
  final _textController = TextEditingController();
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tulis Ulasan',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary)),
            Text(widget.shop.name,
                style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ),
      body: _submitted ? _buildSuccess() : _buildForm(),
    );
  }

  Widget _buildForm() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Berikan Rating',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      5,
                      (i) => GestureDetector(
                            onTap: () => setState(() => _rating = i + 1.0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Icon(
                                i < _rating
                                    ? Icons.star_rounded
                                    : Icons.star_border_rounded,
                                color: AppColors.starColor,
                                size: 44,
                              ),
                            ),
                          )),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nilai Suasana',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _aspectRatings.entries
                    .map((e) => Column(
                          children: [
                            GestureDetector(
                              onTap: () => setState(() =>
                                  _aspectRatings[e.key] =
                                      (_aspectRatings[e.key]! % 5) + 1),
                              child: Container(
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                  color: AppColors.accent.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                    child: Text(_getEmoji(e.value),
                                        style: const TextStyle(fontSize: 26))),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(e.key,
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textSecondary)),
                          ],
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tulis Pengalamanmu',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              TextField(
                controller: _textController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Ceritakan pengalamanmu di sini...',
                  hintStyle:
                      const TextStyle(color: AppColors.textMuted, fontSize: 14),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.all(14),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Tambahkan Foto (Opsional)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.background,
                ),
                child:
                    const Icon(Icons.add, color: AppColors.textMuted, size: 28),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => setState(() => _submitted = true),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 0,
          ),
          child: const Text('Kirim Ulasan',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildSuccess() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: AppColors.greenOpen.withOpacity(0.1),
                shape: BoxShape.circle),
            child: const Icon(Icons.check_circle_rounded,
                color: AppColors.greenOpen, size: 60),
          ),
          const SizedBox(height: 20),
          const Text('Ulasan Terkirim!',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          const Text('Terima kasih atas ulasanmu.',
              style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              elevation: 0,
            ),
            child: const Text('Kembali',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  String _getEmoji(int rating) {
    const emojis = ['😞', '😕', '😊', '😄', '🤩'];
    return emojis[(rating - 1).clamp(0, 4)];
  }
}

// ==================== MAP SCREEN ====================
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  CoffeeShop? _selectedShop;

  static const LatLng _initialCenter = LatLng(-8.1347549, 113.227003);

  void _goToShop(CoffeeShop shop) {
    _mapController.move(LatLng(shop.lat, shop.lng), 16);
    setState(() => _selectedShop = shop);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _initialCenter,
              initialZoom: 14,
              onTap: (_, __) => setState(() => _selectedShop = null),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.coffeetivity',
              ),
              MarkerLayer(
                markers: dummyCoffeeShops
                    .map((shop) => Marker(
                          point: LatLng(shop.lat, shop.lng),
                          width: 40,
                          height: 40,
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedShop = shop),
                            child: const Icon(Icons.location_on,
                                color: Color(0xFFB5742A), size: 36),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
          Positioned(
            top: 48,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.12), blurRadius: 12)
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search,
                      color: AppColors.textMuted, size: 20),
                  const SizedBox(width: 8),
                  const Text('Cari area ini',
                      style:
                          TextStyle(color: AppColors.textMuted, fontSize: 14)),
                  const Spacer(),
                  Container(width: 1, height: 20, color: AppColors.border),
                  const SizedBox(width: 10),
                  const Icon(Icons.tune_rounded,
                      color: AppColors.textSecondary, size: 18),
                ],
              ),
            ),
          ),
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: dummyCoffeeShops.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final shop = dummyCoffeeShops[i];
                  final selected = _selectedShop?.id == shop.id;
                  return GestureDetector(
                    onTap: () => _goToShop(shop),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6)
                        ],
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.local_cafe_rounded,
                            size: 13,
                            color: selected ? Colors.white : AppColors.primary),
                        const SizedBox(width: 5),
                        Text(shop.name,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: selected
                                    ? Colors.white
                                    : AppColors.textPrimary)),
                      ]),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: _selectedShop != null ? 210 : 90,
            child: Column(
              children: [
                _mapFab(Icons.my_location_rounded,
                    () => _mapController.move(_initialCenter, 14)),
                const SizedBox(height: 8),
                _mapFab(
                    Icons.add_rounded,
                    () => _mapController.move(_mapController.camera.center,
                        _mapController.camera.zoom + 1)),
                const SizedBox(height: 8),
                _mapFab(
                    Icons.remove_rounded,
                    () => _mapController.move(_mapController.camera.center,
                        _mapController.camera.zoom - 1)),
              ],
            ),
          ),
          if (_selectedShop != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 36),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: Offset(0, -4))
                  ],
                ),
                child: Row(
                  children: [
                    // ── FOTO MAP POPUP ──
                    shopImage(
                      imageAsset: _selectedShop!.imageAsset,
                      width: 64,
                      height: 64,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_selectedShop!.name,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary)),
                          const SizedBox(height: 3),
                          Row(children: [
                            const Icon(Icons.star_rounded,
                                color: AppColors.starColor, size: 13),
                            Text(
                                ' ${_selectedShop!.rating} (${_selectedShop!.reviewCount})',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary)),
                            Text(' · ${_selectedShop!.distance}',
                                style: const TextStyle(
                                    fontSize: 12, color: AppColors.textMuted)),
                          ]),
                          const SizedBox(height: 3),
                          Text('Buka · ${_selectedShop!.openHours}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.greenOpen,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  NavigationScreen(shop: _selectedShop!))),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                      ),
                      child: const Text('Lihat Detail',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _mapFab(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 8)
          ],
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
    );
  }
}

// ==================== NAVIGATION SCREEN ====================
class NavigationScreen extends StatefulWidget {
  final CoffeeShop shop;
  const NavigationScreen({super.key, required this.shop});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final MapController _navController = MapController();
  bool _started = false;

  static const LatLng _userLocation = LatLng(-8.1347549, 113.227003);

  @override
  Widget build(BuildContext context) {
    final midLat = (_userLocation.latitude + widget.shop.lat) / 2;
    final midLng = (_userLocation.longitude + widget.shop.lng) / 2;

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _navController,
            options: MapOptions(
              initialCenter: LatLng(midLat, midLng),
              initialZoom: 14,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.coffeetivity',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      _userLocation,
                      LatLng(widget.shop.lat, widget.shop.lng)
                    ],
                    color: const Color(0xFF2196F3),
                    strokeWidth: 5,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  const Marker(
                    point: _userLocation,
                    width: 40,
                    height: 40,
                    child: Icon(Icons.my_location,
                        color: Color(0xFF2196F3), size: 32),
                  ),
                  Marker(
                    point: LatLng(widget.shop.lat, widget.shop.lng),
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.location_on,
                        color: Color(0xFFB5742A), size: 36),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 18),
              decoration: BoxDecoration(
                color: _started ? const Color(0xFF1A7A3A) : AppColors.primary,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Icon(
                      _started
                          ? Icons.arrow_upward_rounded
                          : Icons.navigation_rounded,
                      color: Colors.white,
                      size: 32),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_started ? '500 m' : widget.shop.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800)),
                        Text(
                            _started
                                ? 'ke arah ${widget.shop.address.split(',')[0]}'
                                : widget.shop.address,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 13)),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_vert_rounded,
                      color: Colors.white, size: 22),
                ],
              ),
            ),
          ),
          Positioned(
            top: 110,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1), blurRadius: 8)
                  ],
                ),
                child: const Icon(Icons.arrow_back,
                    color: AppColors.primary, size: 20),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 36),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 16,
                      offset: Offset(0, -4))
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time_rounded,
                          color: AppColors.textSecondary, size: 18),
                      const SizedBox(width: 6),
                      const Text('6 mnt (1,8 km)',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                            color: AppColors.chipBg,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text('Rute terpendek',
                            style: TextStyle(
                                fontSize: 11, color: AppColors.textPrimary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Rute tercepat · lalu lintas normal',
                        style: TextStyle(
                            fontSize: 13, color: AppColors.textMuted)),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => setState(() => _started = !_started),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _started ? Colors.red : const Color(0xFF1A7A3A),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                            _started
                                ? Icons.stop_rounded
                                : Icons.navigation_rounded,
                            color: Colors.white,
                            size: 20),
                        const SizedBox(width: 8),
                        Text(_started ? 'Berhenti' : 'Mulai Navigasi',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== PROFILE SCREEN ====================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: const Row(
                  children: [
                    Text('Profil',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary)),
                    Spacer(),
                    Icon(Icons.settings_outlined,
                        color: AppColors.textSecondary, size: 22),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: AppColors.accent.withOpacity(0.2),
                          child: const Text('A',
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.accent)),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('user',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textPrimary)),
                              Text('@user',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textMuted)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statItem('12', 'Ulasan'),
                        Container(
                            width: 1, height: 30, color: AppColors.border),
                        _statItem('8', 'Favorit'),
                        Container(
                            width: 1, height: 30, color: AppColors.border),
                        _statItem('23', 'Kunjungan'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    _menuItem(Icons.history_rounded, 'Riwayat Kunjungan'),
                    _divider(),
                    _menuItem(Icons.rate_review_outlined, 'Ulasan Saya'),
                    _divider(),
                    _menuItem(
                        Icons.favorite_border_rounded, 'Coffee Shop Favorit'),
                    _divider(),
                    _menuItem(Icons.settings_outlined, 'Pengaturan'),
                    _divider(),
                    _menuItem(Icons.help_outline_rounded, 'Bantuan & Dukungan'),
                    _divider(),
                    _menuItem(
                        Icons.info_outline_rounded, 'Tentang Coffeetivity'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: OutlinedButton.icon(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                  icon: const Icon(Icons.logout_rounded,
                      size: 18, color: Colors.red),
                  label: const Text('Keluar',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w700)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red.withOpacity(0.3)),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary)),
        const SizedBox(height: 2),
        Text(label,
            style: const TextStyle(fontSize: 13, color: AppColors.textMuted)),
      ],
    );
  }

  Widget _menuItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 22),
          const SizedBox(width: 14),
          Text(label,
              style:
                  const TextStyle(fontSize: 15, color: AppColors.textPrimary)),
          const Spacer(),
          const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 20),
        ],
      ),
    );
  }

  Widget _divider() =>
      const Divider(height: 1, indent: 56, color: AppColors.border);
}
