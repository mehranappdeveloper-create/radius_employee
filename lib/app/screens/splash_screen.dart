// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../main.dart';
// import '../controllers/auth_controller.dart';
// import 'login_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
//     );
//
//     _controller.forward();
//
//     Future.delayed(const Duration(seconds: 3), () {
//       final auth = Get.find<AuthController>();
//
//       if (auth.isLoggedIn) {
//         Get.off(() => Navbarscreen());
//       } else {
//         Get.off(() => LoginScreen());
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Center(
//           child: ScaleTransition(
//             scale: _scaleAnimation,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "RADIUS",
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontSize: w * 0.10,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 4,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "EMPLOYEE",
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontSize: w * 0.10,
//                     fontWeight: FontWeight.w500,
//                     letterSpacing: 4,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();

    // Navigate to LoginScreen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => LoginScreen());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              'assets/images/login_icon-removebg-preview.png',
              width: w * 0.5,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}