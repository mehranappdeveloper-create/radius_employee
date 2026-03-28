// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../app_colors/app_colors.dart';
// import '../controllers/auth_controller.dart';
// import 'login_screen.dart' hide AuthController;
//
// class ForgotPasswordScreen extends StatefulWidget {
//   @override
//   _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
// }
//
// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final passC = TextEditingController();
//   final auth = Get.find<AuthController>();
//   bool _obscurePassword = true;
//   bool _showError = false; // error message flag
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: AppThemeColors.background(context),
//       appBar: AppBar(
//         title: Text(
//           "Reset Password",
//           style: TextStyle(
//             color: AppThemeColors.surface(context),
//             fontSize: w * 0.05,
//           ),
//         ),
//         backgroundColor: AppThemeColors.buttonPrimary(context),
//         iconTheme: IconThemeData(
//           color: AppThemeColors.surface(context),
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: false, // back button remove
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: w * 0.06,
//               vertical: h * 0.03,
//             ),
//             child: Column(
//               children: [
//                 SizedBox(height: h * 0.05),
//
//                 // Password Field
//                 TextField(
//                   controller: passC,
//                   obscureText: _obscurePassword,
//                   decoration: InputDecoration(
//                     labelText: "New Password",
//                     labelStyle: TextStyle(
//                       color: AppThemeColors.textSecondary(context),
//                       fontSize: w * 0.04,
//                     ),
//                     filled: true,
//                     fillColor: AppThemeColors.surface(context),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(w * 0.04),
//                       borderSide: BorderSide(
//                         color: AppThemeColors.border(context),
//                         width: 1.5,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(w * 0.04),
//                       borderSide: BorderSide(
//                         color: AppThemeColors.buttonPrimary(context),
//                         width: 2.0,
//                       ),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                         color: AppThemeColors.icon(context),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                     ),
//                   ),
//                   style: TextStyle(
//                     color: AppThemeColors.textPrimary(context),
//                     fontSize: w * 0.045,
//                   ),
//                 ),
//
//                 // Error message
//                 if (_showError)
//                   Padding(
//                     padding: EdgeInsets.only(top: 5, left: 8),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "* Required field",
//                         style: TextStyle(
//                           color: Colors.red,
//                           fontSize: w * 0.035,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                 SizedBox(height: h * 0.04),
//
//                 // Change Password Button
//                 SizedBox(
//                   width: w * 0.75,
//                   height: h * 0.065,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       if (passC.text.isEmpty) {
//                         setState(() {
//                           _showError = true; // show error
//                         });
//                         return; // do not proceed
//                       }
//                       setState(() {
//                         _showError = false;
//                       });
//
//                       await auth.resetPassword(passC.text);
//
//                       Get.rawSnackbar(
//                         message: "Password changed successfully",
//                         icon: const Icon(Icons.check_circle, color: Colors.white),
//                         backgroundColor: Colors.green,
//                         snackPosition: SnackPosition.TOP,
//                         duration: const Duration(seconds: 1),
//                         margin: const EdgeInsets.all(10),
//                         borderRadius: 8,
//                       );
//
//                       Future.delayed(const Duration(seconds: 2), () {
//                         Get.offAll(() => LoginScreen());
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppThemeColors.buttonPrimary(context),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(w * 0.03),
//                       ),
//                       elevation: 4,
//                     ),
//                     child: Text(
//                       "Change Password",
//                       style: TextStyle(
//                         color: AppThemeColors.buttonText(context),
//                         fontSize: w * 0.045,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
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

import '../app_colors/app_colors.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final oldPassC = TextEditingController();
  final newPassC = TextEditingController();
  final confirmPassC = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  String? oldPassError;
  String? newPassError;
  String? confirmPassError;

  // For demo purposes, assume old password is "123456"
  final String currentPassword = "123456";

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    InputDecoration _buildDecoration(
        String label, bool obscure, VoidCallback toggle) {
      return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: AppThemeColors.textSecondary(context),
          fontSize: w * 0.04,
        ),
        filled: true,
        fillColor: AppThemeColors.surface(context),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.04),
          borderSide:
          BorderSide(color: AppThemeColors.border(context), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.04),
          borderSide:
          BorderSide(color: AppThemeColors.buttonPrimary(context), width: 2.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: AppThemeColors.icon(context),
          ),
          onPressed: toggle,
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppThemeColors.background(context),
      appBar: AppBar(
        title: Text(
          "Reset Password",
          style: TextStyle(
            color: AppThemeColors.surface(context),
            fontSize: w * 0.05,
          ),
        ),
        backgroundColor: AppThemeColors.buttonPrimary(context),
        iconTheme: IconThemeData(color: AppThemeColors.surface(context)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.03),
            child: Column(
              children: [
                SizedBox(height: h * 0.05),

                // Old Password TextField
                TextField(
                  controller: oldPassC,
                  obscureText: _obscureOld,
                  decoration: _buildDecoration("Old Password", _obscureOld, () {
                    setState(() => _obscureOld = !_obscureOld);
                  }).copyWith(errorText: oldPassError),
                  style: TextStyle(
                    color: AppThemeColors.textPrimary(context),
                    fontSize: w * 0.045,
                  ),
                ),
                SizedBox(height: h * 0.025),

                // New Password TextField
                TextField(
                  controller: newPassC,
                  obscureText: _obscureNew,
                  decoration: _buildDecoration("New Password", _obscureNew, () {
                    setState(() => _obscureNew = !_obscureNew);
                  }).copyWith(errorText: newPassError),
                  style: TextStyle(
                    color: AppThemeColors.textPrimary(context),
                    fontSize: w * 0.045,
                  ),
                ),
                SizedBox(height: h * 0.025),

                // Confirm Password TextField
                TextField(
                  controller: confirmPassC,
                  obscureText: _obscureConfirm,
                  decoration: _buildDecoration("Confirm Password", _obscureConfirm, () {
                    setState(() => _obscureConfirm = !_obscureConfirm);
                  }).copyWith(errorText: confirmPassError),
                  style: TextStyle(
                    color: AppThemeColors.textPrimary(context),
                    fontSize: w * 0.045,
                  ),
                ),
                SizedBox(height: h * 0.04),

                // Change Password Button
                SizedBox(
                  width: w * 0.75,
                  height: h * 0.065,
                  child: ElevatedButton(
                    onPressed: () {
                      // Reset errors
                      setState(() {
                        oldPassError = null;
                        newPassError = null;
                        confirmPassError = null;
                      });

                      bool hasError = false;

                      // Validate old password
                      if (oldPassC.text.isEmpty) {
                        oldPassError = "* Old password required";
                        hasError = true;
                      } else if (oldPassC.text != currentPassword) {
                        oldPassError = "* Invalid old password";
                        hasError = true;
                      }

                      // Validate new password
                      if (newPassC.text.isEmpty) {
                        newPassError = "* New password required";
                        hasError = true;
                      }

                      // Validate confirm password
                      if (confirmPassC.text.isEmpty) {
                        confirmPassError = "* Confirm password required";
                        hasError = true;
                      } else if (confirmPassC.text != newPassC.text) {
                        confirmPassError = "* Passwords do not match";
                        hasError = true;
                      }

                      if (hasError) {
                        setState(() {});
                        return;
                      }

                      // Password changed successfully
                      Get.rawSnackbar(
                        message: "Password changed successfully",
                        icon: const Icon(Icons.check_circle, color: Colors.white),
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 1),
                        margin: const EdgeInsets.all(10),
                        borderRadius: 8,
                      );

                      Future.delayed(const Duration(seconds: 2), () {
                        Get.offAll(() => LoginScreen());
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppThemeColors.buttonPrimary(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(w * 0.03),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      "Change Password",
                      style: TextStyle(
                        color: AppThemeColors.buttonText(context),
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}