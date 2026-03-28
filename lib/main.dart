// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'app/bindings/auth_binding.dart';
// import 'app/screens/splash_screen.dart';
// import 'firebase_options.dart';
// import 'package:radius_employee/servies/notifications_services.dart';
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // GetStorage init
//   await GetStorage.init();
//
//   // Firebase init
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   // Notifications init
//   await NotificationService.initialize();
//
//   // Background handler
//   FirebaseMessaging.onBackgroundMessage(
//     NotificationService.firebaseMessagingBackgroundHandler,
//   );
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       initialBinding: AuthBinding(),
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../firebase_options.dart';
import 'package:radius_employee/servies/notifications_services.dart';

import 'app/app_colors/app_colors.dart';
import 'app/app_theme/app_theme.dart';
import 'app/app_theme/theme_controller.dart';
import 'app/navbar/favourite_tab_screen.dart';
import 'app/navbar/home_tab_screen.dart';
import 'app/navbar/profile_tab_screen.dart';
import 'app/navbar/review_tab_screen.dart';
import 'app/screens/login_screen.dart';
import 'app/screens/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(
    NotificationService.firebaseMessagingBackgroundHandler,
  );

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        initialRoute: '/splash',
        getPages: [
          GetPage(name: '/splash', page: () => SplashScreen()),
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/home', page: () => Navbarscreen()),
        ],
      ),
    );
  }
}

/// 🔥 GLOBAL ACCESS
NavbarscreenState? navbarState;

class Navbarscreen extends StatefulWidget {
  final int initialIndex;

  const Navbarscreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  NavbarscreenState createState() => NavbarscreenState();
}

class NavbarscreenState extends State<Navbarscreen> {
  int _currentIndex = 0;
  Widget? _dynamicScreen;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    /// assign global instance
    navbarState = this;

    _currentIndex = widget.initialIndex;

    _screens = [
      HomeTabScreen(),
      ReviewTabScreen(),
      FavouriteTabScreen(),
      ProfileTabScreen(),
    ];
  }

  /// 🔹 Change tab globally
  void changeTab(int index) {
    if (index < 0 || index >= _screens.length) return;
    setState(() {
      _currentIndex = index;
      _dynamicScreen = null;
    });
  }

  /// 🔹 Open any screen inside navbar
  void openScreen(Widget? screen) {
    setState(() {
      _dynamicScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackScreens = List.from(_screens);
    if (_dynamicScreen != null) {
      stackScreens.insert(0, _dynamicScreen!);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _dynamicScreen != null ? 0 : _currentIndex,
        children: stackScreens,
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.star, 'Review', 1),
            _buildNavItem(Icons.favorite, 'Favourite', 2),
            _buildNavItem(Icons.person, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = _currentIndex == index && _dynamicScreen == null;
    final Color activeColor = AppColors.primary;
    final Color inactiveColor = AppColors.textSecondary;

    return Expanded(
      child: InkWell(
        onTap: () => changeTab(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: isSelected ? activeColor : inactiveColor),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? activeColor : inactiveColor,
                fontWeight:
                isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}