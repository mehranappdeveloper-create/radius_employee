// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:radius_employee/app/drawer_custom_widget/apply_leave_screen.dart';
// import 'package:radius_employee/app/drawer_custom_widget/attendance_screen.dart';
// import '../../main.dart';
// import '../app_colors/app_colors.dart';
// import '../controllers/auth_controller.dart';
// import '../screens/ticket_detail_screen.dart';
//
// class HomeTabScreen extends StatefulWidget {
//   @override
//   _HomeTabScreenState createState() => _HomeTabScreenState();
// }
//
// class _HomeTabScreenState extends State<HomeTabScreen> {
//   final auth = Get.find<AuthController>();
//
//   List<Map<String, dynamic>> items = [
//     {
//       'ticket': 'TCK-1001',
//       'status': 'Receive',
//       'time': '10:30 AM',
//       'date': '31 Jan 2026',
//       'department': 'Technical Dept',
//       'location': 'Karachi',
//       'startTime': DateTime.now().toIso8601String(),
//       'endTime': '',
//       'duration': '',
//     },
//     {
//       'ticket': 'TCK-1002',
//       'status': 'In Process',
//       'time': '11:00 AM',
//       'date': '30 Jan 2026',
//       'department': 'Technical Dept',
//       'location': 'Lahore',
//       'startTime': DateTime.now().toIso8601String(),
//       'endTime': '',
//       'duration': '',
//     },
//     {
//       'ticket': 'TCK-1003',
//       'status': 'Closed',
//       'time': '01:00 PM',
//       'date': '29 Jan 2026',
//       'department': 'Technical Dept',
//       'location': 'Islamabad',
//       'startTime': DateTime.now().subtract(Duration(hours: 2)).toIso8601String(),
//       'endTime': DateTime.now().toIso8601String(),
//       'duration': '',
//     },
//     {
//       'ticket': 'TCK-1004',
//       'status': 'Approved',
//       'time': '02:00 PM',
//       'date': '31 Jan 2026',
//       'department': 'Finance Dept',
//       'location': 'Karachi',
//       'startTime': DateTime.now().toIso8601String(),
//       'endTime': '',
//       'duration': '',
//     },
//     {
//       'ticket': 'TCK-1005',
//       'status': 'Receive',
//       'time': '03:00 PM',
//       'date': '31 Jan 2026',
//       'department': 'Support Dept',
//       'location': 'Lahore',
//       'startTime': DateTime.now().toIso8601String(),
//       'endTime': '',
//       'duration': '',
//     },
//   ];
//
//   final List<String> statusOptions = ['Receive', 'In Process', 'Approved', 'Closed'];
//   String selectedStatusButton = 'All';
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(Duration(seconds: 1), (_) {
//       setState(() {
//         for (var item in items) {
//           if (item['status'] != 'Closed' && item['startTime'] != null) {
//             DateTime start = DateTime.parse(item['startTime']);
//             item['duration'] = _formatDuration(DateTime.now().difference(start));
//           }
//         }
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   Color _statusColor(String status) {
//     switch (status) {
//       case 'Receive':
//         return Colors.blue;
//       case 'In Process':
//         return Colors.orange;
//       case 'Approved':
//         return Colors.green;
//       case 'Closed':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   String _formatDuration(Duration d) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     String h = twoDigits(d.inHours);
//     String m = twoDigits(d.inMinutes.remainder(60));
//     String s = twoDigits(d.inSeconds.remainder(60));
//     return "$h:$m:$s";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//
//     List<Map<String, dynamic>> filteredItems = items.where((item) {
//       if (selectedStatusButton == 'All') return true;
//       return item['status'] == selectedStatusButton;
//     }).toList();
//
//     return Scaffold(
//       backgroundColor: AppColors.background,
//
//       /// LEFT SLIDER / DRAWER
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             Container(
//               color: AppThemeColors.buttonPrimary(context),
//               padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 40),
//               alignment: Alignment.bottomCenter,
//               child: Text(
//                 'Menu',
//                 style: TextStyle(
//                   color: AppThemeColors.surface(context),
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             SizedBox(height: 5),
//             ListTile(
//               leading: Icon(Icons.time_to_leave, color: AppThemeColors.textPrimary(context)),
//               title: Text('Apply Leave'),
//               onTap: () {
//                 // Open ApplyLeaveScreen dynamically while keeping navbar visible
//                 navbarState?.openScreen(const ApplyLeaveScreen());
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.access_time, color: AppThemeColors.textPrimary(context)),
//               title: Text('Attendance'),
//               onTap: () {
//                 // Open ApplyLeaveScreen dynamically while keeping navbar visible
//                 navbarState?.openScreen(const AttendanceScreen());
//               },
//             ),
//           ],
//         ),
//       ),
//
//       appBar: AppBar(
//         backgroundColor: AppThemeColors.buttonPrimary(context),
//         centerTitle: true,
//         title: Text(
//           "Home Services",
//           style: TextStyle(
//             color: AppThemeColors.surface(context),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//
//         /// HAMBURGER MENU BUTTON
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: Icon(Icons.menu, color: AppThemeColors.surface(context)),
//             onPressed: () => Scaffold.of(context).openDrawer(),
//           ),
//         ),
//
//         actions: [
//           Icon(Icons.notifications, color: AppThemeColors.surface(context)),
//           SizedBox(width: w * 0.04),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(w * 0.04),
//         child: Column(
//           children: [
//             /// GRID CARDS
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildGridCard('Receive', items.where((e) => e['status'] == 'Receive').length.toString(), w, h),
//                 _buildGridCard('In Process', items.where((e) => e['status'] == 'In Process').length.toString(), w, h),
//                 _buildGridCard('Approved', items.where((e) => e['status'] == 'Approved').length.toString(), w, h),
//               ],
//             ),
//             SizedBox(height: h * 0.03),
//
//             /// BUTTON ROW
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   _buildStatusTextButton('All'),
//                   const SizedBox(width: 10),
//
//                   _buildStatusTextButton('Receive'),
//                   const SizedBox(width: 10),
//
//                   _buildStatusTextButton('In Process'),
//                   const SizedBox(width: 10),
//
//                   _buildStatusTextButton('Approved'),
//                 ],
//               ),
//             ),
//
//             SizedBox(height: h * 0.03),
//
//             /// TICKET LIST
//             Column(
//               children: filteredItems.map((item) {
//                 return Container(
//                   margin: EdgeInsets.only(bottom: h * 0.02),
//                   padding: EdgeInsets.all(w * 0.03),
//                   decoration: BoxDecoration(
//                     color: AppThemeColors.surface(context),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           /// LEFT ICON / PICTURE WITH TIME/DATE AT BOTTOM
//                           Container(
//                             width: w * 0.2,
//                             height: w * 0.3,
//                             decoration: BoxDecoration(
//                               color: Colors.grey[200],
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(color: AppThemeColors.border(context)),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 /// Top half: Icon / Picture
//                                 Expanded(
//                                   flex: 1,
//                                   child: Center(
//                                     child: Icon(Icons.person, size: w * 0.12, color: AppThemeColors.icon(context)),
//                                   ),
//                                 ),
//
//                                 /// Bottom half: Time & Date with background color
//                                 Container(
//                                   width: double.infinity,
//                                   color: AppThemeColors.buttonPrimary(context).withOpacity(0.1),
//                                   padding: EdgeInsets.symmetric(vertical: 6),
//                                   child: Text(
//                                     "${item['time']} \n ${item['date']}",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontSize: w * 0.025,
//                                       color: AppThemeColors.textSecondary(context),
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           SizedBox(width: w * 0.04),
//
//                           /// RIGHT INFO
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 /// TICKET + STATUS BADGE
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         navbarState?.openScreen(
//                                           TicketDetailScreen(ticketData: item),
//                                         );
//                                       },
//                                       child: Text(
//                                         item['ticket']!,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: AppThemeColors.buttonPrimary(context),
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.004),
//                                       decoration: BoxDecoration(
//                                         color: _statusColor(item['status']!).withOpacity(0.15),
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       child: Text(
//                                         item['status']!,
//                                         style: TextStyle(
//                                           color: _statusColor(item['status']!),
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: w * 0.03,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: h * 0.015),
//
//                                 /// DEPARTMENT + LOCATION + DROPDOWN
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     /// LEFT: Department and Location stacked vertically
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         /// Department
//                                         Row(
//                                           children: [
//                                             Icon(Icons.apartment, size: w * 0.04, color: AppThemeColors.icon(context)),
//                                             SizedBox(width: w * 0.01),
//                                             Text(
//                                               item['department']!,
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 color: AppThemeColors.textSecondary(context),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(height: h * 0.005),
//
//                                         /// Location
//                                         Row(
//                                           children: [
//                                             Icon(Icons.location_on, size: w * 0.04, color: AppThemeColors.icon(context)),
//                                             SizedBox(width: 4),
//                                             Text(
//                                               item['location']!,
//                                               style: TextStyle(
//                                                 color: AppThemeColors.textSecondary(context),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//
//                                     /// RIGHT: Status Dropdown
//                                     Container(
//                                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                                       decoration: BoxDecoration(
//                                         color: AppThemeColors.surface(context),
//                                         borderRadius: BorderRadius.circular(6),
//                                         border: Border.all(color: AppThemeColors.border(context)),
//                                       ),
//                                       child: DropdownButton<String>(
//                                         value: item['status'],
//                                         underline: SizedBox(),
//                                         isDense: true,
//                                         iconSize: 20,
//                                         style: TextStyle(
//                                           fontSize: w * 0.03,
//                                           color: AppThemeColors.textPrimary(context),
//                                         ),
//                                         items: statusOptions
//                                             .map((status) => DropdownMenuItem(
//                                           value: status,
//                                           child: Text(status),
//                                         ))
//                                             .toList(),
//                                         onChanged: (val) {
//                                           if (val != null) {
//                                             setState(() {
//                                               item['status'] = val;
//                                               if (val == 'Closed') {
//                                                 item['endTime'] = DateTime.now().toIso8601String();
//                                               }
//                                             });
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//
//                                 SizedBox(height: h * 0.008),
//
//                                 /// START, END, DURATION with icons
//                                 Row(
//                                   children: [
//                                     Icon(Icons.play_arrow, size: w * 0.04, color: Colors.green), // Start icon
//                                     SizedBox(width: 4),
//                                     Text(
//                                       item['startTime'] != null
//                                           ? DateTime.parse(item['startTime']).toLocal().toString().substring(0,19)
//                                           : '-',
//                                       style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: h * 0.005),
//                                 Row(
//                                   children: [
//                                     Icon(Icons.stop, size: w * 0.04, color: Colors.red), // End icon
//                                     SizedBox(width: 4),
//                                     Text(
//                                       item['status']=='Closed' && item['endTime'] != ''
//                                           ? DateTime.parse(item['endTime']).toLocal().toString().substring(0,19)
//                                           : 'In progress',
//                                       style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: h * 0.005),
//                                 Row(
//                                   children: [
//                                     Icon(Icons.timer, size: w * 0.04, color: Colors.orange), // Duration icon
//                                     SizedBox(width: 4),
//                                     Text(
//                                       item['duration'] ?? '00:00:00',
//                                       style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildGridCard(String title, String count, double w, double h) {
//     return Container(
//       width: w * 0.28,
//       padding: EdgeInsets.symmetric(vertical: h * 0.02),
//       decoration: BoxDecoration(
//         color: AppThemeColors.surface(context),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           Text(count, style: TextStyle(fontSize: w * 0.06, fontWeight: FontWeight.bold)),
//           Text(title, style: TextStyle(fontSize: w * 0.035, color: AppThemeColors.textSecondary(context))),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatusTextButton(String status) {
//     final bool isSelected = selectedStatusButton == status;
//     return TextButton(
//       onPressed: () {
//         setState(() {
//           selectedStatusButton = status;
//         });
//       },
//       style: TextButton.styleFrom(
//         backgroundColor: isSelected ? AppThemeColors.buttonPrimary(context) : Colors.grey[300],
//         foregroundColor: isSelected ? AppThemeColors.surface(context) : Colors.black,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//       ),
//       child: Text(status, style: TextStyle(fontWeight: FontWeight.bold)),
//     );
//   }
// }
//
//

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:radius_employee/app/drawer_custom_widget/apply_leave_screen.dart';
// import 'package:radius_employee/app/drawer_custom_widget/attendance_screen.dart';
// import 'package:radius_employee/app/navbar/review_tab_screen.dart';
// import '../../main.dart';
// import '../app_colors/app_colors.dart';
// import '../controllers/auth_controller.dart';
// import '../screens/ticket_detail_screen.dart';
//
// class HomeTabScreen extends StatefulWidget {
//   @override
//   _HomeTabScreenState createState() => _HomeTabScreenState();
// }
//
// class _HomeTabScreenState extends State<HomeTabScreen> {
//   final auth = Get.find<AuthController>();
//
//   List<Map<String, dynamic>> items = [
//     {
//       'ticket': 'TCK-1001',
//       'status': 'Receive',
//       'time': '10:30 AM',
//       'date': '31 Jan 2026',
//       'department': 'Technical Dept',
//       'location': 'Karachi',
//       'startTime': DateTime.now().toIso8601String(),
//       'endTime': '',
//       'duration': '',
//     },
//     {
//       'ticket': 'TCK-1002',
//       'status': 'In Process',
//       'time': '11:00 AM',
//       'date': '30 Jan 2026',
//       'department': 'Technical Dept',
//       'location': 'Lahore',
//       'startTime': DateTime.now().toIso8601String(),
//       'endTime': '',
//       'duration': '',
//     },
//     {
//       'ticket': 'TCK-1003',
//       'status': 'Closed',
//       'time': '01:00 PM',
//       'date': '29 Jan 2026',
//       'department': 'Technical Dept',
//       'location': 'Islamabad',
//       'startTime': DateTime.now().subtract(Duration(hours: 2)).toIso8601String(),
//       'endTime': DateTime.now().toIso8601String(),
//       'duration': '',
//     },
//     {
//       'ticket': 'TCK-1004',
//       'status': 'Approved',
//       'time': '02:00 PM',
//       'date': '31 Jan 2026',
//       'department': 'Finance Dept',
//       'location': 'Karachi',
//       'startTime': DateTime.now().toIso8601String(),
//       'endTime': '',
//       'duration': '',
//     },
//     {
//       'ticket': 'TCK-1005',
//       'status': 'Receive',
//       'time': '03:00 PM',
//       'date': '31 Jan 2026',
//       'department': 'Support Dept',
//       'location': 'Lahore',
//       'startTime': DateTime.now().toIso8601String(),
//       'endTime': '',
//       'duration': '',
//     },
//   ];
//
//   final List<String> statusOptions = ['Receive', 'In Process', 'Approved', 'Closed'];
//   String selectedStatusButton = 'All';
//   Timer? _timer;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(Duration(seconds: 1), (_) {
//       setState(() {
//         for (var item in items) {
//           if (item['status'] != 'Closed' && item['startTime'] != null) {
//             DateTime start = DateTime.parse(item['startTime']);
//             item['duration'] = _formatDuration(DateTime.now().difference(start));
//           }
//         }
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   Color _statusColor(String status) {
//     switch (status) {
//       case 'Receive':
//         return Colors.blue;
//       case 'In Process':
//         return Colors.orange;
//       case 'Approved':
//         return Colors.green;
//       case 'Closed':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   String _formatDuration(Duration d) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     String h = twoDigits(d.inHours);
//     String m = twoDigits(d.inMinutes.remainder(60));
//     String s = twoDigits(d.inSeconds.remainder(60));
//     return "$h:$m:$s";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//
//     List<Map<String, dynamic>> filteredItems = items.where((item) {
//       if (selectedStatusButton == 'All') return true;
//       return item['status'] == selectedStatusButton;
//     }).toList();
//
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             Container(
//               color: AppThemeColors.buttonPrimary(context),
//               padding: const EdgeInsets.symmetric(vertical: 40),
//               alignment: Alignment.center,
//               child: CircleAvatar(
//                 radius: 50,
//                 backgroundImage: AssetImage('assets/images/profile.jpg'),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Card(
//               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: ListTile(
//                 leading: Icon(Icons.time_to_leave, color: AppThemeColors.buttonPrimary(context)),
//                 title: Text('Apply Leave'),
//                 onTap: () {
//                   navbarState?.openScreen(const ApplyLeaveScreen());
//                 },
//               ),
//             ),
//             Card(
//               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: ListTile(
//                 leading: Icon(Icons.access_time, color: AppThemeColors.buttonPrimary(context)),
//                 title: Text('Attendance'),
//                 onTap: () {
//                   navbarState?.openScreen(const AttendanceScreen());
//                 },
//               ),
//             ),
//             Card(
//               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: ListTile(
//                 leading: Icon(Icons.logout, color: AppThemeColors.error(context)),
//                 title: Text('Sign Out'),
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: const Text('Confirm Sign Out'),
//                       content: const Text('Are you sure you want to log out?'),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Navigator.of(context).pop(),
//                           child: const Text('No'),
//                         ),
//                         TextButton(
//                           onPressed: () async {
//                             Navigator.of(context).pop(); // close dialog first
//                             await auth.logout(); // async logout
//                             // login screen automatically open hoga
//                           },
//                           child: const Text('Yes'),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         backgroundColor: AppThemeColors.buttonPrimary(context),
//         centerTitle: true,
//         title: Text(
//           "Home Services",
//           style: TextStyle(
//             color: AppThemeColors.surface(context),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: Icon(Icons.menu, color: AppThemeColors.surface(context)),
//             onPressed: () => Scaffold.of(context).openDrawer(),
//           ),
//         ),
//         actions: [
//           Icon(Icons.notifications, color: AppThemeColors.surface(context)),
//           SizedBox(width: w * 0.04),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(w * 0.04),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildGridCard('Receive', items.where((e) => e['status'] == 'Receive').length.toString(), w, h),
//                 _buildGridCard('In Process', items.where((e) => e['status'] == 'In Process').length.toString(), w, h),
//                 _buildGridCard('Approved', items.where((e) => e['status'] == 'Approved').length.toString(), w, h),
//               ],
//             ),
//             SizedBox(height: h * 0.02),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Start pressed')));
//                   },
//                   icon: Icon(Icons.play_arrow),
//                   label: Text('Start'),
//                   style: ElevatedButton.styleFrom(backgroundColor: AppColors.success,foregroundColor: AppColors.surface),
//                 ),
//                 ElevatedButton.icon(
//                   onPressed: _showCloseDialog,
//                   icon: Icon(Icons.stop),
//                   label: Text('Close'),
//                   style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,foregroundColor: AppColors.surface),
//                 ),
//               ],
//             ),
//             SizedBox(height: h * 0.03),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   _buildStatusTextButton('All'),
//                   const SizedBox(width: 10),
//                   _buildStatusTextButton('Receive'),
//                   const SizedBox(width: 10),
//                   _buildStatusTextButton('In Process'),
//                   const SizedBox(width: 10),
//                   _buildStatusTextButton('Approved'),
//                 ],
//               ),
//             ),
//             SizedBox(height: h * 0.03),
//             Column(
//               children: filteredItems.map((item) {
//                 return Container(
//                   margin: EdgeInsets.only(bottom: h * 0.02),
//                   padding: EdgeInsets.all(w * 0.03),
//                   decoration: BoxDecoration(
//                     color: AppThemeColors.surface(context),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: w * 0.2,
//                             height: w * 0.3,
//                             decoration: BoxDecoration(
//                               color: Colors.grey[200],
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(color: AppThemeColors.border(context)),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   flex: 1,
//                                   child: Center(
//                                     child: Icon(Icons.person, size: w * 0.12, color: AppThemeColors.icon(context)),
//                                   ),
//                                 ),
//                                 Container(
//                                   width: double.infinity,
//                                   color: AppThemeColors.buttonPrimary(context).withOpacity(0.1),
//                                   padding: EdgeInsets.symmetric(vertical: 6),
//                                   child: Text(
//                                     "${item['time']} \n ${item['date']}",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontSize: w * 0.025,
//                                       color: AppThemeColors.textSecondary(context),
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: w * 0.04),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         navbarState?.openScreen(TicketDetailScreen(ticketData: item));
//                                       },
//                                       child: Text(
//                                         item['ticket']!,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: AppThemeColors.buttonPrimary(context),
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.004),
//                                       decoration: BoxDecoration(
//                                         color: _statusColor(item['status']!).withOpacity(0.15),
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       child: Text(
//                                         item['status']!,
//                                         style: TextStyle(
//                                           color: _statusColor(item['status']!),
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: w * 0.03,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: h * 0.015),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Icon(Icons.apartment, size: w * 0.04, color: AppThemeColors.icon(context)),
//                                             SizedBox(width: w * 0.01),
//                                             Text(
//                                               item['department']!,
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 color: AppThemeColors.textSecondary(context),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(height: h * 0.005),
//                                         Row(
//                                           children: [
//                                             Icon(Icons.location_on, size: w * 0.04, color: AppThemeColors.icon(context)),
//                                             SizedBox(width: 4),
//                                             Text(
//                                               item['location']!,
//                                               style: TextStyle(color: AppThemeColors.textSecondary(context)),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                                       decoration: BoxDecoration(
//                                         color: AppThemeColors.surface(context),
//                                         borderRadius: BorderRadius.circular(6),
//                                         border: Border.all(color: AppThemeColors.border(context)),
//                                       ),
//                                       child: DropdownButton<String>(
//                                         value: item['status'],
//                                         underline: SizedBox(),
//                                         isDense: true,
//                                         iconSize: 20,
//                                         style: TextStyle(
//                                           fontSize: w * 0.03,
//                                           color: AppThemeColors.textPrimary(context),
//                                         ),
//                                         items: statusOptions.map((status) => DropdownMenuItem(
//                                           value: status,
//                                           child: Text(status),
//                                         )).toList(),
//                                         onChanged: (val) {
//                                           if (val != null) {
//                                             setState(() {
//                                               item['status'] = val;
//                                               if (val == 'Closed') item['endTime'] = DateTime.now().toIso8601String();
//                                             });
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//
//                                 // ⭐⭐⭐ ADDED VIEW BUTTON ONLY HERE ⭐⭐⭐
//                                 SizedBox(height: h * 0.01),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         navbarState?.openScreen(TicketDetailScreen(ticketData: item));
//                                       },
//                                       child: Row(
//                                         children: const [
//                                           Icon(Icons.visibility, size: 18),
//                                           SizedBox(width: 4),
//                                           Text('View'),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
// // ⭐⭐⭐ END ADD ⭐⭐⭐
//
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildGridCard(String title, String count, double w, double h) {
//     return Container(
//       width: w * 0.28,
//       padding: EdgeInsets.symmetric(vertical: h * 0.02),
//       decoration: BoxDecoration(
//         color: AppThemeColors.surface(context),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           Text(count, style: TextStyle(fontSize: w * 0.06, fontWeight: FontWeight.bold)),
//           Text(title, style: TextStyle(fontSize: w * 0.035, color: AppThemeColors.textSecondary(context))),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatusTextButton(String status) {
//     final bool isSelected = selectedStatusButton == status;
//     return TextButton(
//       onPressed: () {
//         setState(() {
//           selectedStatusButton = status;
//         });
//       },
//       style: TextButton.styleFrom(
//         backgroundColor: isSelected ? AppThemeColors.buttonPrimary(context) : Colors.grey[300],
//         foregroundColor: isSelected ? AppThemeColors.surface(context) : Colors.black,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//       ),
//       child: Text(status, style: TextStyle(fontWeight: FontWeight.bold)),
//     );
//   }
//
//   void _showCloseDialog() {
//     final otpController = TextEditingController();
//     String? errorText;
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: const Text('Enter OTP'),
//               content: TextField(
//                 controller: otpController,
//                 keyboardType: TextInputType.number,
//                 maxLength: 6,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.digitsOnly,
//                 ],
//                 decoration: InputDecoration(
//                   hintText: '6-digit PIN',
//                   errorText: errorText, // 👈 red error below
//                   counterText: '',
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: const Text('Cancel'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     if (otpController.text.length != 6) {
//                       setState(() {
//                         errorText = '6-digit PIN required';
//                       });
//                     } else {
//                       setState(() => errorText = null);
//                       Navigator.of(context).pop();
//                       _showReviewDialog();
//                     }
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//
//   void _showReviewDialog() {
//     double rating = 0;
//     final TextEditingController titleController = TextEditingController();
//     final TextEditingController descController = TextEditingController();
//
//     String? titleError;
//     String? descError;
//     String? ratingError;
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: const Text('Add Review'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   /// ⭐ Rating
//                   RatingBar.builder(
//                     initialRating: rating,
//                     minRating: 1,
//                     direction: Axis.horizontal,
//                     allowHalfRating: false,
//                     itemCount: 5,
//                     itemBuilder: (context, _) =>
//                     const Icon(Icons.star, color: Colors.amber),
//                     onRatingUpdate: (value) {
//                       setState(() {
//                         rating = value;
//                         ratingError = null;
//                       });
//                     },
//                   ),
//
//                   if (ratingError != null)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 4),
//                       child: Text(
//                         ratingError!,
//                         style: const TextStyle(color: Colors.red, fontSize: 12),
//                       ),
//                     ),
//
//                   const SizedBox(height: 8),
//
//                   /// 📝 Title
//                   TextField(
//                     controller: titleController,
//                     decoration: InputDecoration(
//                       labelText: 'Title',
//                       errorText: titleError,
//                     ),
//                   ),
//
//                   /// 📝 Description
//                   TextField(
//                     controller: descController,
//                     decoration: InputDecoration(
//                       labelText: 'Description',
//                       errorText: descError,
//                     ),
//                   ),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: const Text('Cancel'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     setState(() {
//                       titleError = titleController.text.trim().isEmpty
//                           ? 'Title required'
//                           : null;
//
//                       descError = descController.text.trim().isEmpty
//                           ? 'Description required'
//                           : null;
//
//                       ratingError =
//                       rating == 0 ? 'Rating required' : null;
//                     });
//
//                     if (titleError != null ||
//                         descError != null ||
//                         ratingError != null) {
//                       return;
//                     }
//
//             /// ✅ CLOSE REVIEW DIALOG
//             Navigator.of(context).pop();
//
//                     /// 🔥 ADD REVIEW TO LIST
//                     reviews.insert(0, {
//                       'name': 'You',
//                       'comment': descController.text.trim(),
//                       'rating': rating.toInt(),
//                       'avatar':
//                       'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
//                     });
//
//                     setState(() {});
//
//                     /// ✅ SUCCESS DIALOG (WAPIS ADD)
//             showDialog(
//             context: context,
//             barrierDismissible: true,
//             builder: (_) {
//             return AlertDialog(
//             backgroundColor: AppColors.surface,
//             shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//             ),
//             content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//             Icon(Icons.check_circle,
//             color: Colors.green, size: 70),
//             SizedBox(height: 12),
//             Text(
//             'Review sent successfully',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//             color: Colors.green, fontSize: 16),
//             ),
//             ],
//             ),
//             );
//             },
//             );
//
//             /// ✅ AUTO CLOSE AFTER 1 SECOND
//             Future.delayed(const Duration(seconds: 1), () {
//             if (Navigator.canPop(context)) {
//             Navigator.of(context).pop();
//             }
//             });
//             },
//             child: const Text('Send'),
//             ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//   }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:radius_employee/app/drawer_custom_widget/apply_leave_screen.dart';
import 'package:radius_employee/app/drawer_custom_widget/attendance_screen.dart';
import 'package:radius_employee/app/navbar/review_tab_screen.dart';
import '../../main.dart';
import '../app_colors/app_colors.dart';
import '../screens/login_screen.dart';
import '../screens/ticket_detail_screen.dart';

class HomeTabScreen extends StatefulWidget {
  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {

  List<Map<String, dynamic>> items = [
    {
      'ticket': 'TCK-1001',
      'status': 'Receive',
      'time': '10:30 AM',
      'date': '31 Jan 2026',
      'department': 'Technical Dept',
      'location': 'Karachi',
      'startTime': null,
      'endTime': null,
      'duration': '',
    },
    {
      'ticket': 'TCK-1002',
      'status': 'In Process',
      'time': '11:00 AM',
      'date': '30 Jan 2026',
      'department': 'Technical Dept',
      'location': 'Lahore',
      'startTime': null,
      'endTime': null,
      'duration': '',
    },
    {
      'ticket': 'TCK-1003',
      'status': 'Closed',
      'time': '01:00 PM',
      'date': '29 Jan 2026',
      'department': 'Technical Dept',
      'location': 'Islamabad',
      'startTime': DateTime
          .now()
          .subtract(Duration(hours: 2))
          .toIso8601String(),
      'endTime': DateTime.now().toIso8601String(),
      'duration': '',
    },
  ];

  final List<String> statusOptions = [
    'Receive',
    'In Process',
    'Approved',
    'Closed'
  ];
  String selectedStatusButton = 'All';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Timer to update duration for all running tickets
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        for (var item in items) {
          if (item['status'] != 'Closed' && item['startTime'] != null) {
            DateTime start = DateTime.parse(item['startTime']);
            item['duration'] =
                _formatDuration(DateTime.now().difference(start));
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Receive':
        return Colors.blue;
      case 'In Process':
        return Colors.orange;
      case 'Approved':
        return Colors.green;
      case 'Closed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String h = twoDigits(d.inHours);
    String m = twoDigits(d.inMinutes.remainder(60));
    String s = twoDigits(d.inSeconds.remainder(60));
    return "$h:$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery
        .of(context)
        .size
        .height;
    final w = MediaQuery
        .of(context)
        .size
        .width;

    List<Map<String, dynamic>> filteredItems = items.where((item) {
      if (selectedStatusButton == 'All') return true;
      return item['status'] == selectedStatusButton;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: AppThemeColors.buttonPrimary(context),
              padding: const EdgeInsets.symmetric(vertical: 40),
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: Icon(Icons.time_to_leave,
                    color: AppThemeColors.buttonPrimary(context)),
                title: Text('Apply Leave'),
                onTap: () {
                  navbarState?.openScreen(const ApplyLeaveScreen());
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: Icon(Icons.access_time,
                    color: AppThemeColors.buttonPrimary(context)),
                title: Text('Attendance'),
                onTap: () {
                  navbarState?.openScreen(const AttendanceScreen());
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: Icon(Icons.logout, color: AppThemeColors.error(context)),
                title: Text('Sign Out'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirm Sign Out'),
                      content: const Text('Are you sure you want to log out?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            // ✅ Clear login flag
                            final box = GetStorage();
                            box.write('isLoggedIn', false);

                            // Navigate to login screen and remove all previous routes
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                                  (route) => false,
                            );
                          },
                          child: const Text('Yes'),
                        ),
                          ],
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppThemeColors.buttonPrimary(context),
        centerTitle: true,
        title: Text(
          "Home Services",
          style: TextStyle(
            color: AppThemeColors.surface(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.menu, color: AppThemeColors.surface(context)),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        actions: [
          Icon(Icons.notifications, color: AppThemeColors.surface(context)),
          SizedBox(width: w * 0.04),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildGridCard('Receive', items
                    .where((e) => e['status'] == 'Receive')
                    .length
                    .toString(), w, h),
                _buildGridCard('In Process', items
                    .where((e) => e['status'] == 'In Process')
                    .length
                    .toString(), w, h),
                _buildGridCard('Approved', items
                    .where((e) => e['status'] == 'Approved')
                    .length
                    .toString(), w, h),
              ],
            ),
            SizedBox(height: h * 0.02),

            // ✅ Start & Close Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      // Start all Receive tickets
                      for (var item in items) {
                        if (item['status'] == 'Receive' &&
                            item['startTime'] == null) {
                          item['startTime'] = DateTime.now().toIso8601String();
                          item['duration'] = '00:00:00';
                        }
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Started all Receive tickets')));
                  },
                  icon: Icon(Icons.play_arrow),
                  label: Text('Start'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: AppColors.surface,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showCloseDialog,
                  icon: Icon(Icons.stop),
                  label: Text('Close'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.surface,
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.03),

            // Status filter buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildStatusTextButton('All'),
                  const SizedBox(width: 10),
                  _buildStatusTextButton('Receive'),
                  const SizedBox(width: 10),
                  _buildStatusTextButton('In Process'),
                  const SizedBox(width: 10),
                  _buildStatusTextButton('Approved'),
                ],
              ),
            ),
            SizedBox(height: h * 0.03),

            // Tickets list
            Column(
              children: filteredItems.map((item) {
                return Container(
                  margin: EdgeInsets.only(bottom: h * 0.02),
                  padding: EdgeInsets.all(w * 0.03),
                  decoration: BoxDecoration(
                    color: AppThemeColors.surface(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Picture & Date container
                      Container(
                        width: w * 0.2,
                        height: w * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppThemeColors.border(context)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Icon(Icons.person, size: w * 0.12,
                                    color: AppThemeColors.icon(context)),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              color: AppThemeColors
                                  .buttonPrimary(context)
                                  .withOpacity(0.1),
                              padding: EdgeInsets.symmetric(vertical: 6),
                              child: Center(
                                child: Text(
                                  "${item['time']} \n ${item['date']}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: w * 0.025,
                                    color: AppThemeColors.textSecondary(
                                        context),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: w * 0.04),

                      // Right info column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Ticket title & Status
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    navbarState?.openScreen(
                                        TicketDetailScreen(ticketData: item));
                                  },
                                  child: Text(
                                    item['ticket']!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppThemeColors.buttonPrimary(
                                          context),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.03,
                                      vertical: h * 0.004),
                                  decoration: BoxDecoration(
                                    color: _statusColor(item['status']!)
                                        .withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    item['status']!,
                                    style: TextStyle(
                                      color: _statusColor(item['status']!),
                                      fontWeight: FontWeight.w600,
                                      fontSize: w * 0.03,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: h * 0.015),

                            // Department & Location with Dropdown on right
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left: Department & Location
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.apartment, size: w * 0.04,
                                            color: AppThemeColors.icon(
                                                context)),
                                        SizedBox(width: w * 0.01),
                                        Text(
                                          item['department']!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppThemeColors.textSecondary(
                                                context),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: h * 0.005),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on, size: w * 0.04,
                                            color: AppThemeColors.icon(
                                                context)),
                                        SizedBox(width: 4),
                                        Text(
                                          item['location']!,
                                          style: TextStyle(color: AppThemeColors
                                              .textSecondary(context)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Right: Dropdown for status
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppThemeColors.surface(context),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: AppThemeColors.border(context)),
                                  ),
                                  child: DropdownButton<String>(
                                    value: item['status'],
                                    underline: SizedBox(),
                                    isDense: true,
                                    iconSize: 20,
                                    style: TextStyle(
                                      fontSize: w * 0.03,
                                      color: AppThemeColors.textPrimary(
                                          context),
                                    ),
                                    items: statusOptions
                                        .map((status) =>
                                        DropdownMenuItem(
                                          value: status,
                                          child: Text(status),
                                        ))
                                        .toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() {
                                          item['status'] = val;
                                          if (val == 'Closed') item['endTime'] =
                                              DateTime.now().toIso8601String();
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),

                            // Duration & StartTime with View button
                            if (item['startTime'] != null) SizedBox(
                                height: h * 0.01),
                            if (item['startTime'] != null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Left: Duration & Start Time
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.timer, size: w * 0.04,
                                              color: Colors.blue),
                                          SizedBox(width: 4),
                                          Text(item['duration'],
                                              style: TextStyle(
                                                  fontSize: w * 0.03)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.access_time_filled,
                                            // clock icon
                                            size: 16, // adjust size as needed
                                            color: Colors
                                                .green, // optional color
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "${TimeOfDay.fromDateTime(
                                                DateTime
                                                    .parse(
                                                    item['startTime'])
                                                    .toLocal()).format(
                                                context)}",
                                            style: TextStyle(
                                                fontSize: w * 0.025),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),

                                  // Right: View button
                                  InkWell(
                                    onTap: () {
                                      navbarState?.openScreen(
                                          TicketDetailScreen(ticketData: item));
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(Icons.visibility, size: 18),
                                        SizedBox(width: 4),
                                        Text('View'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )


          ],
        ),
      ),
    );
  }

  Widget _buildGridCard(String title, String count, double w, double h) {
    return Container(
      width: w * 0.28,
      padding: EdgeInsets.symmetric(vertical: h * 0.02),
      decoration: BoxDecoration(
        color: AppThemeColors.surface(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(count, style: TextStyle(
              fontSize: w * 0.06, fontWeight: FontWeight.bold)),
          Text(title, style: TextStyle(fontSize: w * 0.035,
              color: AppThemeColors.textSecondary(context))),
        ],
      ),
    );
  }

  Widget _buildStatusTextButton(String status) {
    final bool isSelected = selectedStatusButton == status;
    return TextButton(
      onPressed: () {
        setState(() {
          selectedStatusButton = status;
        });
      },
      style: TextButton.styleFrom(
        backgroundColor: isSelected
            ? AppThemeColors.buttonPrimary(context)
            : Colors.grey[300],
        foregroundColor: isSelected ? AppThemeColors.surface(context) : Colors
            .black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      ),
      child: Text(status, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  void _showCloseDialog() {
    final otpController = TextEditingController();
    String? errorText;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Enter OTP'),
              content: TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: '6-digit PIN',
                  errorText: errorText,
                  counterText: '',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (otpController.text.length != 6) {
                      setState(() => errorText = '6-digit PIN required');
                    } else {
                      setState(() => errorText = null);
                      Navigator.of(context).pop();
                      _showReviewDialog();
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // List to hold saved reviews
  List<Map<String, dynamic>> savedReviews = [];

// Function to save reviews
  void saveReview(Map<String, dynamic> review) {
    // Save review to local list (you can replace this with DB or API later)
    savedReviews.add(review);
  }

// Show Add Review Dialog
  void _showReviewDialog() {
    double rating = 0;
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    String? titleError, descError, ratingError;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Review'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (value) {
                      setState(() {
                        rating = value;
                        ratingError = null;
                      });
                    },
                  ),
                  if (ratingError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(ratingError!,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 12)),
                    ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        labelText: 'Title', errorText: titleError),
                  ),
                  TextField(
                    controller: descController,
                    decoration: InputDecoration(
                        labelText: 'Description', errorText: descError),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel')),
                TextButton(
                  onPressed: () {
                    setState(() {
                      titleError = titleController.text
                          .trim()
                          .isEmpty
                          ? 'Title required'
                          : null;
                      descError = descController.text
                          .trim()
                          .isEmpty
                          ? 'Description required'
                          : null;
                      ratingError = rating == 0 ? 'Rating required' : null;
                    });

                    if (titleError != null ||
                        descError != null ||
                        ratingError != null) return;

                    Navigator.of(context).pop();

                    // Create the new review map
                    final newReview = {
                      'name': 'You',
                      'title': titleController.text.trim(),
                      'comment': descController.text.trim(),
                      'rating': rating.toInt(),
                      'avatar':
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                    };

                    // Show on screen immediately
                    reviews.insert(0, newReview);
                    setState(() {});

                    // Save review persistently
                    saveReview(newReview);

                    // Show success dialog
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) {
                        return AlertDialog(
                          backgroundColor: AppColors.surface,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.check_circle,
                                  color: Colors.green, size: 70),
                              SizedBox(height: 12),
                              Text('Review sent successfully',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 16)),
                            ],
                          ),
                        );
                      },
                    );

                    Future.delayed(const Duration(seconds: 1), () {
                      if (Navigator.canPop(context)) Navigator
                          .of(context)
                          .pop();
                    });
                  },
                  child: const Text('Send'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}