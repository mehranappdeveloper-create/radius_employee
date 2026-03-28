// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../app_colors/app_colors.dart';
//
// class ProfileTabScreen extends StatefulWidget {
//   const ProfileTabScreen({super.key});
//
//   @override
//   _ProfileTabScreenState createState() => _ProfileTabScreenState();
// }
//
// class _ProfileTabScreenState extends State<ProfileTabScreen> {
//   File? _profileImage;
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//
//   String _selectedLanguage = 'English (United States)';
//   final List<String> _languages = [
//     'English (United States)',
//     'Spanish',
//     'French',
//     'German',
//     'Chinese',
//     'Japanese',
//     'Arabic',
//     'Hindi',
//   ];
//
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _pickImage() async {
//     final XFile? pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _profileImage = File(pickedFile.path);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       // Important: make taps pass through
//       behavior: HitTestBehavior.translucent,
//       onTap: () {
//         FocusScope.of(context).unfocus(); // keyboard hide
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.background,
//         appBar: AppBar(
//           backgroundColor: AppColors.primary,
//           elevation: 0,
//           centerTitle: true,
//           title: Text(
//             'Profile',
//             style: TextStyle(
//               color: AppColors.surface,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(25),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               // ---- PROFILE IMAGE ----
//               Center(
//                 child: Stack(
//                   children: [
//                     CircleAvatar(
//                       radius: 70,
//                       backgroundColor: AppColors.surface,
//                       backgroundImage:
//                       _profileImage != null ? FileImage(_profileImage!) : null,
//                       child: _profileImage == null
//                           ? Icon(Icons.person,
//                           size: 60, color: AppColors.textPrimary)
//                           : null,
//                     ),
//                     Positioned(
//                       bottom: 5,
//                       right: 5,
//                       child: InkWell(
//                         onTap: _pickImage,
//                         child: CircleAvatar(
//                           radius: 15,
//                           backgroundColor: AppColors.primary,
//                           child: Icon(Icons.edit, color: Colors.white,
//                               size: 14),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               // Full Name Field
//               Text(
//                 'Full Name',
//                 style: TextStyle(
//                     color: AppColors.textPrimary, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: AppColors.surface,
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: BorderSide(
//                         color: AppColors.surface, width: 1.5),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: BorderSide(color: AppColors.primary, width: 2),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               // Phone Field
//               Text(
//                 'Phone',
//                 style: TextStyle(
//                     color: AppColors.textPrimary, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: AppColors.surface,
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: BorderSide(
//                         color: AppColors.surface, width: 1.5),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: BorderSide(color: AppColors.primary, width: 2),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               // Language Dropdown
//               Text(
//                 'Language',
//                 style: TextStyle(
//                     color: AppColors.textPrimary, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               InputDecorator(
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: AppColors.surface,
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: BorderSide(
//                         color: AppColors.surface, width: 1.5),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: BorderSide(color: AppColors.primary, width: 2),
//                   ),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<String>(
//                     value: _selectedLanguage,
//                     isExpanded: true,
//                     items: _languages.map((lang) {
//                       return DropdownMenuItem(
//                         value: lang,
//                         child: Text(lang),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedLanguage = value!;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 30),
//
//               // 🔥 SIGN OUT BUTTON
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     final box = GetStorage();
//                     await box.erase(); // clears all stored login/auth flags
//
//                     Get.offAllNamed('/login'); // safely redirect
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: const Text(
//                     'Sign Out',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../app_colors/app_colors.dart';

class ProfileTabScreen extends StatefulWidget {
  const ProfileTabScreen({super.key});

  @override
  _ProfileTabScreenState createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // ---- PROFILE DATA ----
  final String name = "Mehran";
  final String fatherName = "Muhammad Hanif";
  final String gender = "Male";
  final String phone = "0344-9623516";
  final String address = "Lahore, Pakistan";

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // ---- REUSABLE PROFILE CARD ----
  Widget profileCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            color: AppColors.surface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // ---- PROFILE IMAGE ----
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: AppColors.surface,
                    backgroundImage:
                    _profileImage != null ? FileImage(_profileImage!) : null,
                    child: _profileImage == null
                        ? Icon(Icons.person,
                        size: 60, color: AppColors.textPrimary)
                        : null,
                  ),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: InkWell(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.primary,
                        child: const Icon(
                          Icons.edit,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ---- PROFILE CARDS ----
            profileCard(
              icon: Icons.person,
              title: "Name",
              value: name,
            ),
            profileCard(
              icon: Icons.family_restroom,
              title: "Father Name",
              value: fatherName,
            ),
            profileCard(
              icon: Icons.male,
              title: "Gender",
              value: gender,
            ),
            profileCard(
              icon: Icons.call,
              title: "Cell No",
              value: phone,
            ),
            profileCard(
              icon: Icons.location_on,
              title: "Address",
              value: address,
            ),
          ],
        ),
      ),
    );
  }
}