// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../main.dart';
// import '../app_colors/app_colors.dart';
// import '../controllers/auth_controller.dart';
// import 'forgot_password_screen.dart';
// import 'package:get_storage/get_storage.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final emailC = TextEditingController();
//   final passC = TextEditingController();
//   final auth = Get.find<AuthController>();
//   bool _obscurePassword = true;
//   bool _isButtonEnabled = false;
//
//   final box = GetStorage(); // GetStorage instance for auth state
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Set saved email once
//     emailC.text = auth.getSavedEmail();
//
//     // Add listener to validate fields
//     emailC.addListener(_validateFields);
//     passC.addListener(_validateFields);
//
//     // Check if user is already logged in
//     Future.microtask(() {
//       bool loggedIn = box.read('isLoggedIn') ?? false;
//       if (loggedIn) {
//         Get.offAll(() => Navbarscreen());
//       }
//     });
//   }
//
//   void _validateFields() {
//     setState(() {
//       _isButtonEnabled =
//           emailC.text.isNotEmpty && passC.text.isNotEmpty;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: AppThemeColors.background(context),
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "Login",
//           style: TextStyle(
//             color: AppThemeColors.surface(context),
//             fontSize: w * 0.05,
//           ),
//         ),
//         backgroundColor: AppThemeColors.buttonPrimary(context),
//         iconTheme: IconThemeData(color: AppThemeColors.textPrimary(context)),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: w * 0.06,
//                 vertical: h * 0.02,
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: h * 0.02),
//
//                   // Logo
//                   Image.asset(
//                     'assets/images/0b4b007bb0987cb8c9843fa4f724c4af_fgraphic-removebg-preview.png',
//                     width: w * 0.8,
//                     height: h * 0.25,
//                     fit: BoxFit.contain,
//                   ),
//
//                   SizedBox(height: h * 0.04),
//
//                   // Email Field
//                   TextField(
//                     controller: emailC,
//                     decoration: InputDecoration(
//                       labelText: "Email",
//                       labelStyle: TextStyle(
//                         color: AppThemeColors.textSecondary(context),
//                         fontSize: w * 0.04,
//                       ),
//                       prefixIcon: Icon(
//                         Icons.email,
//                         color: AppThemeColors.icon(context),
//                       ),
//                       filled: true,
//                       fillColor: AppThemeColors.surface(context),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(w * 0.08),
//                         borderSide: BorderSide(
//                           color: AppThemeColors.border(context),
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(w * 0.08),
//                         borderSide: BorderSide(
//                           color: AppThemeColors.textPrimary(context),
//                         ),
//                       ),
//                     ),
//                     style: TextStyle(
//                       color: AppThemeColors.textPrimary(context),
//                       fontSize: w * 0.045,
//                     ),
//                   ),
//
//                   SizedBox(height: h * 0.025),
//
//                   // Password Field
//                   TextField(
//                     controller: passC,
//                     obscureText: _obscurePassword,
//                     decoration: InputDecoration(
//                       labelText: "Password",
//                       labelStyle: TextStyle(
//                         color: AppThemeColors.textSecondary(context),
//                         fontSize: w * 0.04,
//                       ),
//                       prefixIcon: Icon(
//                         Icons.lock,
//                         color: AppThemeColors.icon(context),
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscurePassword
//                               ? Icons.visibility_off
//                               : Icons.visibility,
//                           color: AppThemeColors.icon(context),
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscurePassword = !_obscurePassword;
//                           });
//                         },
//                       ),
//                       filled: true,
//                       fillColor: AppThemeColors.surface(context),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(w * 0.08),
//                         borderSide: BorderSide(
//                           color: AppThemeColors.border(context),
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(w * 0.08),
//                         borderSide: BorderSide(
//                           color: AppThemeColors.textPrimary(context),
//                         ),
//                       ),
//                     ),
//                     style: TextStyle(
//                       color: AppThemeColors.textPrimary(context),
//                       fontSize: w * 0.045,
//                     ),
//                   ),
//
//                   SizedBox(height: h * 0.035),
//
//                   SizedBox(
//                     width: double.infinity,
//                     height: h * 0.065,
//                     child: ElevatedButton(
//                       onPressed: _isButtonEnabled
//                           ? () async {
//                         // login logic
//                         await auth.login(
//                           emailC.text,
//                           passC.text,
//                         );
//
//                         // save login state
//                         box.write('isLoggedIn', true);
//
//                         Get.rawSnackbar(
//                           message: "Login Successful",
//                           icon: const Icon(Icons.check_circle, color: Colors.white),
//                           backgroundColor: Colors.green,
//                           snackPosition: SnackPosition.TOP,
//                           duration: const Duration(seconds: 1),
//                           margin: const EdgeInsets.all(10),
//                           borderRadius: 8,
//                         );
//                         Future.delayed(const Duration(seconds: 2), () {
//                           Get.offAll(() => Navbarscreen());
//                         });
//                       }
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: _isButtonEnabled
//                             ? AppThemeColors.buttonPrimary(context)
//                             : AppThemeColors.border(context),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(w * 0.08),
//                         ),
//                       ),
//                       child: Text(
//                         "Login",
//                         style: TextStyle(
//                           color: AppThemeColors.buttonText(context),
//                           fontSize: w * 0.045,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: h * 0.015),
//
//                   // Forgot Password
//                   TextButton(
//                     onPressed: () {
//                       Get.to(() => ForgotPasswordScreen());
//                     },
//                     child: Text(
//                       "Forgot Password?",
//                       style: TextStyle(
//                         color: AppThemeColors.textPrimary(context),
//                         fontSize: w * 0.04,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../main.dart';
import '../app_colors/app_colors.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  bool _obscurePassword = true;
  bool _isButtonEnabled = false;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    emailC.addListener(_validateFields);
    passC.addListener(_validateFields);

    // Redirect to Navbarscreen only if already logged in
    Future.microtask(() {
      bool loggedIn = box.read('isLoggedIn') ?? false;
      if (loggedIn) {
        Get.offAll(() => Navbarscreen());
      }
    });
  }

  void _validateFields() {
    setState(() {
      _isButtonEnabled = emailC.text.isNotEmpty && passC.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppThemeColors.background(context),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Login",
          style: TextStyle(
            color: AppThemeColors.surface(context),
            fontSize: w * 0.05,
          ),
        ),
        backgroundColor: AppThemeColors.buttonPrimary(context),
        iconTheme: IconThemeData(color: AppThemeColors.textPrimary(context)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.06,
                vertical: h * 0.02,
              ),
              child: Column(
                children: [
                  SizedBox(height: h * 0.02),
                  Image.asset(
                    'assets/images/login_icon-removebg-preview.png',
                    width: w * 0.8,
                    height: h * 0.25,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: h * 0.04),
                  TextField(
                    controller: emailC,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: AppThemeColors.textSecondary(context),
                        fontSize: w * 0.04,
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: AppThemeColors.icon(context),
                      ),
                      filled: true,
                      fillColor: AppThemeColors.surface(context),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.08),
                        borderSide: BorderSide(
                          color: AppThemeColors.border(context),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.08),
                        borderSide: BorderSide(
                          color: AppThemeColors.buttonPrimary(context),
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: AppThemeColors.textPrimary(context),
                      fontSize: w * 0.045,
                    ),
                  ),
                  SizedBox(height: h * 0.025),
                  TextField(
                    controller: passC,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: AppThemeColors.textSecondary(context),
                        fontSize: w * 0.04,
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: AppThemeColors.icon(context),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppThemeColors.icon(context),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: AppThemeColors.surface(context),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.08),
                        borderSide: BorderSide(
                          color: AppThemeColors.border(context),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.08),
                        borderSide: BorderSide(
                          color: AppThemeColors.buttonPrimary(context),
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: AppThemeColors.textPrimary(context),
                      fontSize: w * 0.045,
                    ),
                  ),
                  SizedBox(height: h * 0.035),
                  SizedBox(
                    width: double.infinity,
                    height: h * 0.065,
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled
                          ? () {
                        // ✅ Set login flag
                        box.write('isLoggedIn', true);
                        Get.rawSnackbar(
                          message: "Login Successful",
                          icon: const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.green,
                          snackPosition: SnackPosition.TOP,
                          duration: const Duration(seconds: 1),
                          margin: const EdgeInsets.all(10),
                          borderRadius: 8,
                        );
                        Future.delayed(const Duration(seconds: 1), () {
                          Get.offAll(() => Navbarscreen());
                        });
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isButtonEnabled
                            ? AppThemeColors.buttonPrimary(context)
                            : AppThemeColors.border(context),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(w * 0.08),
                        ),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: AppThemeColors.buttonText(context),
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.015),
                  TextButton(
                    onPressed: () {
                      Get.to(() => ForgotPasswordScreen());
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: AppThemeColors.textPrimary(context),
                        fontSize: w * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}