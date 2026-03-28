// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import '../../app_colors/app_colors.dart';
//
// class TicketDetailScreen extends StatefulWidget {
//   final Map<String, String> ticketData;
//
//   const TicketDetailScreen({super.key, required this.ticketData});
//
//   @override
//   State<TicketDetailScreen> createState() => _TicketDetailScreenState();
// }
//
// class _TicketDetailScreenState extends State<TicketDetailScreen> {
//   bool showReply = false;
//   final TextEditingController replyController = TextEditingController();
//
//   // File picker list
//   List<PlatformFile> selectedFiles = [];
//
//   Future<void> pickFiles() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//     );
//
//     if (result != null) {
//       setState(() {
//         selectedFiles.addAll(result.files);
//       });
//     }
//   }
//
//   void sendMessage() {
//     if (replyController.text.trim().isEmpty || selectedFiles.isEmpty) {
//       // Show error if description or files are empty
//       Get.snackbar(
//         'Error',
//         'Please add a description and select at least one file.',
//         backgroundColor: Colors.red.withOpacity(0.9),
//         colorText: Colors.white,
//       );
//       return;
//     }
//
//     // Show success dialog
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         content: SizedBox(
//           height: 120,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.check_circle, size: 50, color: Colors.green),
//               const SizedBox(height: 12),
//               const Text(
//                 "Sent successfully",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//     // Optional: clear after sending
//     setState(() {
//       replyController.clear();
//       selectedFiles.clear();
//       showReply = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         title: Text(widget.ticketData['ticket']!),
//         centerTitle: true,
//         backgroundColor: AppThemeColors.buttonPrimary(context),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(w * 0.05),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _row("Status", widget.ticketData['status']!),
//             _row("Department", widget.ticketData['department']!),
//             _row("Location", widget.ticketData['location']!),
//             _row("Time", widget.ticketData['time']!),
//             _row("Date", widget.ticketData['date']!),
//
//             SizedBox(height: h * 0.02),
//
//             /// 🔹 REPLY BUTTON
//             SizedBox(
//               width: 170,
//               child: ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     showReply = !showReply;
//                   });
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppThemeColors.buttonPrimary(context),
//                   foregroundColor: AppThemeColors.surface(context),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                 ),
//                 child: Text(
//                   "Reply Message",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: AppThemeColors.surface(context),
//                   ),
//                 ),
//               ),
//             ),
//
//             if (showReply) ...[
//               SizedBox(height: h * 0.02),
//
//               /// 🔹 DESCRIPTION BOX (500 CHARACTERS WITH WARNING COLOR)
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: AppThemeColors.surface(context),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: AppThemeColors.border(context),
//                   ),
//                 ),
//                 child: Stack(
//                   children: [
//                     TextField(
//                       controller: replyController,
//                       maxLines: null,
//                       minLines: 4,
//                       keyboardType: TextInputType.multiline,
//                       maxLength: 500,
//                       decoration: const InputDecoration(
//                         hintText: "Type description...",
//                         border: InputBorder.none,
//                         counterText: "", // hide default counter
//                       ),
//                       onChanged: (_) {
//                         setState(() {}); // rebuild to update counter
//                       },
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Builder(builder: (_) {
//                         int remaining = 500 - replyController.text.length;
//                         bool warning = remaining <= 50; // less than 50 left = red
//                         return Text(
//                           "$remaining/500",
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: warning ? Colors.red : AppColors.textSecondary,
//                           ),
//                         );
//                       }),
//                     ),
//                   ],
//                 ),
//               ),
//
//
//               SizedBox(height: h * 0.02),
//
//               /// 🔹 FILE UPLOAD CONTAINER
//               GestureDetector(
//                 onTap: pickFiles,
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(18),
//                   decoration: BoxDecoration(
//                     color: AppThemeColors.surface(context),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: AppThemeColors.border(context),
//                     ),
//                   ),
//                   child: Column(
//                     children: const [
//                       Icon(Icons.cloud_upload_outlined, size: 36),
//                       SizedBox(height: 8),
//                       Text(
//                         "Drag file to upload",
//                         style: TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                       SizedBox(height: 4),
//                       Text("(or click)"),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 12),
//
//               /// 🔹 SHOW SELECTED FILES
//               Column(
//                 children: selectedFiles.map((file) {
//                   return Container(
//                     width: double.infinity,
//                     margin: const EdgeInsets.only(bottom: 8),
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: AppThemeColors.surface(context).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: AppThemeColors.border(context)),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             file.name,
//                             style: const TextStyle(fontWeight: FontWeight.w500),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.close),
//                           onPressed: () {
//                             setState(() {
//                               selectedFiles.remove(file);
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//
//               SizedBox(height: h * 0.02),
//
//               /// 🔹 SEND MESSAGE BUTTON (BOTTOM RIGHT)
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: ElevatedButton.icon(
//                   onPressed: sendMessage,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppThemeColors.buttonPrimary(context),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 12,
//                     ),
//                   ),
//                   icon: Icon(Icons.send, color: AppThemeColors.surface(context)),
//                   label: Text(
//                     "Send Message",
//                     style: TextStyle(color: AppThemeColors.surface(context)),
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _row(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         children: [
//           Text(
//             "$title: ",
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import '../../main.dart';
// import '../app_colors/app_colors.dart';
//
// class TicketDetailScreen extends StatefulWidget {
//   final Map<String, String> ticketData;
//
//   const TicketDetailScreen({super.key, required this.ticketData});
//
//   @override
//   State<TicketDetailScreen> createState() => _TicketDetailScreenState();
// }
//
// class _TicketDetailScreenState extends State<TicketDetailScreen> {
//   bool showReply = false;
//   final TextEditingController replyController = TextEditingController();
//   List<PlatformFile> selectedFiles = [];
//
//   Future<void> pickFiles() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//     );
//
//     if (result != null) {
//       setState(() {
//         selectedFiles.addAll(result.files);
//       });
//     }
//   }
//
//   void sendMessage() {
//     if (replyController.text.trim().isEmpty || selectedFiles.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please add a description and select at least one file.',
//         backgroundColor: Colors.red.withOpacity(0.9),
//         colorText: Colors.white,
//       );
//       return;
//     }
//
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         content: SizedBox(
//           height: 120,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Icon(Icons.check_circle, size: 50, color: Colors.green),
//               SizedBox(height: 12),
//               Text(
//                 "Sent successfully",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//     setState(() {
//       replyController.clear();
//       selectedFiles.clear();
//       showReply = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         title: Text(widget.ticketData['ticket'] ?? '-'),
//         backgroundColor: AppThemeColors.buttonPrimary(context),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             // Close TicketDetailScreen and go back
//             Get.offAll(() => Navbarscreen(initialIndex: 0));
//           },
//         ),
//
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(w * 0.05),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _row("Status", widget.ticketData['status'] ?? '-'),
//             _row("Department", widget.ticketData['department'] ?? '-'),
//             _row("Location", widget.ticketData['location'] ?? '-'),
//             _row("Time", widget.ticketData['time'] ?? '-'),
//             _row("Date", widget.ticketData['date'] ?? '-'),
//
//             SizedBox(height: h * 0.02),
//
//             SizedBox(
//               width: 170,
//               child: ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     showReply = !showReply;
//                   });
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppThemeColors.buttonPrimary(context),
//                   foregroundColor: AppThemeColors.surface(context),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                 ),
//                 child: Text(
//                   "Reply Message",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: AppThemeColors.surface(context),
//                   ),
//                 ),
//               ),
//             ),
//
//             if (showReply) ...[
//               SizedBox(height: h * 0.02),
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: AppThemeColors.surface(context),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: AppThemeColors.border(context)),
//                 ),
//                 child: Stack(
//                   children: [
//                     TextField(
//                       controller: replyController,
//                       maxLines: null,
//                       minLines: 4,
//                       maxLength: 500,
//                       decoration: const InputDecoration(
//                         hintText: "Type description...",
//                         border: InputBorder.none,
//                         counterText: "",
//                       ),
//                       onChanged: (_) => setState(() {}),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Builder(builder: (_) {
//                         int remaining = 500 - replyController.text.length;
//                         bool warning = remaining <= 50;
//                         return Text(
//                           "$remaining/500",
//                           style: TextStyle(
//                               fontSize: 12,
//                               color: warning
//                                   ? Colors.red
//                                   : AppColors.textSecondary),
//                         );
//                       }),
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: h * 0.02),
//
//               GestureDetector(
//                 onTap: pickFiles,
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(18),
//                   decoration: BoxDecoration(
//                     color: AppThemeColors.surface(context),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: AppThemeColors.border(context)),
//                   ),
//                   child: Column(
//                     children: const [
//                       Icon(Icons.cloud_upload_outlined, size: 36),
//                       SizedBox(height: 8),
//                       Text("Drag file to upload",
//                           style: TextStyle(fontWeight: FontWeight.w600)),
//                       SizedBox(height: 4),
//                       Text("(or click)"),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 12),
//
//               Column(
//                 children: selectedFiles.map((file) {
//                   return Container(
//                     width: double.infinity,
//                     margin: const EdgeInsets.only(bottom: 8),
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: AppThemeColors.surface(context).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: AppThemeColors.border(context)),
//                     ),
//                     child: Row(
//                       children: [
//                         Flexible(
//                           child: Text(
//                             file.name,
//                             overflow: TextOverflow.ellipsis,
//                             style:
//                             const TextStyle(fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                         IconButton(
//                           padding: EdgeInsets.zero,
//                           constraints: const BoxConstraints(),
//                           icon: const Icon(Icons.close, size: 20),
//                           onPressed: () {
//                             setState(() {
//                               selectedFiles.remove(file);
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//
//               SizedBox(height: h * 0.02),
//
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: ElevatedButton.icon(
//                   onPressed: sendMessage,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppThemeColors.buttonPrimary(context),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 12),
//                   ),
//                   icon: Icon(Icons.send, color: AppThemeColors.surface(context)),
//                   label: Text("Send Message",
//                       style: TextStyle(color: AppThemeColors.surface(context))),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _row(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         children: [
//           Text("$title: ", style: const TextStyle(fontWeight: FontWeight.bold)),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import '../../main.dart';
// import '../app_colors/app_colors.dart';
//
// class TicketDetailScreen extends StatefulWidget {
//   final Map<String, String> ticketData;
//
//   const TicketDetailScreen({Key? key, required this.ticketData})
//       : super(key: key);
//
//   @override
//   State<TicketDetailScreen> createState() => _TicketDetailScreenState();
// }
//
// class _TicketDetailScreenState extends State<TicketDetailScreen> {
//   bool showReply = false;
//   final TextEditingController replyController = TextEditingController();
//   List<PlatformFile> selectedFiles = [];
//
//   Future<void> pickFiles() async {
//     FilePickerResult? result =
//     await FilePicker.platform.pickFiles(allowMultiple: true);
//
//     if (result != null) {
//       setState(() {
//         selectedFiles.addAll(result.files);
//       });
//     }
//   }
//
//   void sendMessage() {
//     if (replyController.text.trim().isEmpty || selectedFiles.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please add a description and select at least one file.',
//         backgroundColor: Colors.red.withOpacity(0.9),
//         colorText: Colors.white,
//       );
//       return;
//     }
//
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         content: SizedBox(
//           height: 120,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Icon(Icons.check_circle, size: 50, color: Colors.green),
//               SizedBox(height: 12),
//               Text(
//                 "Sent successfully",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//     setState(() {
//       replyController.clear();
//       selectedFiles.clear();
//       showReply = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         title: Text(widget.ticketData['ticket'] ?? '-'),
//         backgroundColor: AppThemeColors.buttonPrimary(context),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             navbarState?.openScreen(null);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(w * 0.05),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _row("Status", widget.ticketData['status']),
//             _row("Department", widget.ticketData['department']),
//             _row("Location", widget.ticketData['location']),
//             _row("Time", widget.ticketData['time']),
//             _row("Date", widget.ticketData['date']),
//
//             SizedBox(height: h * 0.02),
//
//             SizedBox(
//               width: 170,
//               child: ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     showReply = !showReply;
//                   });
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppThemeColors.buttonPrimary(context),
//                   foregroundColor: AppThemeColors.surface(context),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                 ),
//                 child: const Text(
//                   "Reply Message",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//
//             if (showReply) ...[
//               SizedBox(height: h * 0.02),
//
//               /// Reply box
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: AppThemeColors.surface(context),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: AppThemeColors.border(context)),
//                 ),
//                 child: Stack(
//                   children: [
//                     TextField(
//                       controller: replyController,
//                       maxLines: null,
//                       minLines: 4,
//                       maxLength: 500,
//                       decoration: const InputDecoration(
//                         hintText: "Type description...",
//                         border: InputBorder.none,
//                         counterText: "",
//                       ),
//                       onChanged: (_) => setState(() {}),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Text(
//                         "${500 - replyController.text.length}/500",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: (500 - replyController.text.length) <= 50
//                               ? Colors.red
//                               : AppColors.textSecondary,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: h * 0.02),
//
//               /// Upload files
//               GestureDetector(
//                 onTap: pickFiles,
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(18),
//                   decoration: BoxDecoration(
//                     color: AppThemeColors.surface(context),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: AppThemeColors.border(context)),
//                   ),
//                   child: const Column(
//                     children: [
//                       Icon(Icons.cloud_upload_outlined, size: 36),
//                       SizedBox(height: 8),
//                       Text("Drag file to upload",
//                           style: TextStyle(fontWeight: FontWeight.w600)),
//                       SizedBox(height: 4),
//                       Text("(or click)"),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 12),
//
//               /// Selected files list
//               Column(
//                 children: selectedFiles.map((file) {
//                   return Container(
//                     width: double.infinity,
//                     margin: const EdgeInsets.only(bottom: 8),
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color:
//                       AppThemeColors.surface(context).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(10),
//                       border:
//                       Border.all(color: AppThemeColors.border(context)),
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             file.name,
//                             overflow: TextOverflow.ellipsis,
//                             style:
//                             const TextStyle(fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.close, size: 20),
//                           onPressed: () {
//                             setState(() {
//                               selectedFiles.remove(file);
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//
//               SizedBox(height: h * 0.02),
//
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: ElevatedButton.icon(
//                   onPressed: sendMessage,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppThemeColors.buttonPrimary(context),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 12),
//                   ),
//                   icon: Icon(Icons.send,
//                       color: AppThemeColors.surface(context)),
//                   label: Text(
//                     "Send Message",
//                     style:
//                     TextStyle(color: AppThemeColors.surface(context)),
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _row(String title, String? value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         children: [
//           Text("$title: ",
//               style: const TextStyle(fontWeight: FontWeight.bold)),
//           Expanded(child: Text(value ?? '-')),
//         ],
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../app_colors/app_colors.dart';

class TicketDetailScreen extends StatefulWidget {
  final Map<String, dynamic> ticketData;

  const TicketDetailScreen({Key? key, required this.ticketData}) : super(key: key);

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  bool showReply = false;
  final TextEditingController replyController = TextEditingController();
  List<PlatformFile> selectedFiles = [];
  Timer? _timer;
  Duration _currentDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    if (widget.ticketData['startTime'] == null) {
      widget.ticketData['startTime'] = DateTime.now().toIso8601String();
    }
    _startDurationTimer();
  }

  void _startDurationTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      DateTime start = DateTime.parse(widget.ticketData['startTime']);
      DateTime end;
      if (widget.ticketData['status'] == 'Closed' && widget.ticketData['endTime'] != '') {
        end = DateTime.parse(widget.ticketData['endTime']);
        _timer?.cancel();
      } else {
        end = DateTime.now();
      }
      setState(() {
        _currentDuration = end.difference(start);
        widget.ticketData['duration'] = _formatDuration(_currentDuration);
      });
    });
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String h = twoDigits(d.inHours);
    String m = twoDigits(d.inMinutes.remainder(60));
    String s = twoDigits(d.inSeconds.remainder(60));
    return "$h:$m:$s";
  }

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        selectedFiles.addAll(result.files);
      });
    }
  }

  void sendMessage() {
    if (replyController.text.trim().isEmpty || selectedFiles.isEmpty) {
      Get.snackbar(
        'Error',
        'Please add a description and select at least one file.',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.check_circle, size: 50, color: Colors.green),
              SizedBox(height: 12),
              Text(
                "Sent successfully",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );

    setState(() {
      replyController.clear();
      selectedFiles.clear();
      showReply = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.ticketData['ticket'] ?? '-'),
        backgroundColor: AppThemeColors.buttonPrimary(context),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            navbarState?.openScreen(null);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _row("Status", widget.ticketData['status']),
            _row("Department", widget.ticketData['department']),
            _row("Location", widget.ticketData['location']),
            _row("Time", widget.ticketData['time']),
            _row("Date", widget.ticketData['date']),
            _row("Start Time", widget.ticketData['startTime'] != null ? DateTime.parse(widget.ticketData['startTime']).toLocal().toString().substring(0,19) : '-'),
            _row("End Time", widget.ticketData['status']=='Closed' && widget.ticketData['endTime']!='' ? DateTime.parse(widget.ticketData['endTime']).toLocal().toString().substring(0,19) : 'In progress'),
            _row("Duration", widget.ticketData['duration'] ?? _formatDuration(_currentDuration)),

            SizedBox(height: h * 0.02),

            SizedBox(
              width: 170,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showReply = !showReply;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppThemeColors.buttonPrimary(context),
                  foregroundColor: AppThemeColors.surface(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Reply Message",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            if (showReply) ...[
              SizedBox(height: h * 0.02),

              /// Reply box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppThemeColors.surface(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppThemeColors.border(context)),
                ),
                child: Stack(
                  children: [
                    TextField(
                      controller: replyController,
                      maxLines: null,
                      minLines: 4,
                      maxLength: 500,
                      decoration: const InputDecoration(
                        hintText: "Type description...",
                        border: InputBorder.none,
                        counterText: "",
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Text(
                        "${500 - replyController.text.length}/500",
                        style: TextStyle(
                          fontSize: 12,
                          color: (500 - replyController.text.length) <= 50
                              ? Colors.red
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * 0.02),

              /// Upload files
              GestureDetector(
                onTap: pickFiles,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppThemeColors.surface(context),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppThemeColors.border(context)),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.cloud_upload_outlined, size: 36),
                      SizedBox(height: 8),
                      Text("Drag file to upload", style: TextStyle(fontWeight: FontWeight.w600)),
                      SizedBox(height: 4),
                      Text("(or click)"),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// Selected files
              Column(
                children: selectedFiles.map((file) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppThemeColors.surface(context).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppThemeColors.border(context)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            file.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () {
                            setState(() {
                              selectedFiles.remove(file);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: h * 0.02),

              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: sendMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppThemeColors.buttonPrimary(context),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  icon: Icon(Icons.send, color: AppThemeColors.surface(context)),
                  label: Text("Send Message", style: TextStyle(color: AppThemeColors.surface(context))),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _row(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text("$title: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value ?? '-')),
        ],
      ),
    );
  }
}