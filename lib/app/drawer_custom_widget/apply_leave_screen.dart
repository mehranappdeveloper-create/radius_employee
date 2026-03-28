// import 'package:flutter/material.dart';
// import '../../main.dart';
// import '../app_colors/app_colors.dart';
//
// class ApplyLeaveScreen extends StatefulWidget {
//   const ApplyLeaveScreen({super.key});
//
//   @override
//   State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
// }
//
// class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController categoryController = TextEditingController();
//   final TextEditingController dateController = TextEditingController();
//   final TextEditingController durationController = TextEditingController();
//
//   // Error messages
//   String? nameError;
//   String? categoryError;
//   String? dateError;
//   String? durationError;
//
//   List<Map<String, String>> leaveList = [
//     {
//       'name': 'Mehran Hanif',
//       'category': 'Sick Leave',
//       'date': '2026-02-05',
//       'duration': '8',
//       'status': 'Pending'
//     },
//     {
//       'name': 'Jane Smith',
//       'category': 'Casual Leave',
//       'date': '2026-02-06',
//       'duration': '4',
//       'status': 'Approved'
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Apply Leave'),
//         centerTitle: true,
//         backgroundColor: AppColors.primary,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             navbarState?.openScreen(null); // Go back to previous tab
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildTextField('Name', nameController, nameError),
//             const SizedBox(height: 10),
//             buildTextField('Leave Category', categoryController, categoryError),
//             const SizedBox(height: 10),
//             buildDateField('Date', dateController, dateError),
//             const SizedBox(height: 10),
//             buildTextField('Duration (hours)', durationController, durationError),
//             const SizedBox(height: 20),
//
//             /// APPLY BUTTON
//             Center(
//               child: SizedBox(
//                 width: 150,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       nameError = null;
//                       categoryError = null;
//                       dateError = null;
//                       durationError = null;
//
//                       if (nameController.text.isEmpty) {
//                         nameError = 'Name is required';
//                       }
//                       if (categoryController.text.isEmpty) {
//                         categoryError = 'Category is required';
//                       }
//                       if (dateController.text.isEmpty) {
//                         dateError = 'Date is required';
//                       }
//                       if (durationController.text.isEmpty) {
//                         durationError = 'Duration is required';
//                       }
//
//                       if (nameError != null ||
//                           categoryError != null ||
//                           dateError != null ||
//                           durationError != null) {
//                         return;
//                       }
//
//                       leaveList.add({
//                         'name': nameController.text,
//                         'category': categoryController.text,
//                         'date': dateController.text,
//                         'duration': durationController.text,
//                         'status': 'Pending',
//                       });
//
//                       nameController.clear();
//                       categoryController.clear();
//                       dateController.clear();
//                       durationController.clear();
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primary,
//                     foregroundColor: Colors.white,
//                   ),
//                   child: const Text('Apply Now'),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             const Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//
//             /// LEAVE LIST
//             ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: leaveList.length,
//               itemBuilder: (context, index) {
//                 final leave = leaveList[index];
//                 return Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 leave['name'] ?? '',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             PopupMenuButton<String>(
//                               icon: const Icon(Icons.more_vert,
//                                   color: AppColors.primary),
//                               onSelected: (value) {
//                                 if (value == 'view') {
//                                   // Open inside global navbar
//                                   navbarState?.openScreen(
//                                     ViewLeaveScreen(
//                                       leaveData: leave,
//                                     ),
//                                   );
//                                 } else if (value == 'delete') {
//                                   setState(() {
//                                     leaveList.removeAt(index);
//                                   });
//                                 }
//                               },
//                               itemBuilder: (context) => const [
//                                 PopupMenuItem(
//                                   value: 'view',
//                                   child: Row(
//                                     children: [
//                                       Icon(Icons.remove_red_eye,
//                                           color: AppColors.primary),
//                                       SizedBox(width: 8),
//                                       Text('View'),
//                                     ],
//                                   ),
//                                 ),
//                                 PopupMenuItem(
//                                   value: 'delete',
//                                   child: Row(
//                                     children: [
//                                       Icon(Icons.delete, color: Colors.red),
//                                       SizedBox(width: 8),
//                                       Text('Delete'),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 6),
//                         Text('Category: ${leave['category']}'),
//                         Text('Date: ${leave['date']}'),
//                         Text('Duration: ${leave['duration']}h'),
//                         const SizedBox(height: 4),
//                         RichText(
//                           text: TextSpan(
//                             text: 'Status: ',
//                             style: DefaultTextStyle.of(context).style,
//                             children: [
//                               TextSpan(
//                                 text: leave['status'],
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   color: leave['status'] == 'Approved'
//                                       ? AppColors.success
//                                       : leave['status'] == 'Rejected'
//                                       ? AppColors.error
//                                       : Colors.orange,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildTextField(String title, TextEditingController controller,
//       [String? errorText]) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 5),
//         TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             errorText: errorText,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget buildDateField(String title, TextEditingController controller,
//       [String? errorText]) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 5),
//         TextField(
//           controller: controller,
//           readOnly: true,
//           decoration: InputDecoration(
//             errorText: errorText,
//             suffixIcon:
//             const Icon(Icons.calendar_today, color: AppColors.primary),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           onTap: () async {
//             DateTime? picked = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now(),
//               firstDate: DateTime(2000),
//               lastDate: DateTime(2100),
//             );
//             if (picked != null) {
//               controller.text =
//               "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
//
// /// ================= VIEW LEAVE SCREEN =================
//
// class ViewLeaveScreen extends StatelessWidget {
//   final Map<String, String> leaveData;
//
//   const ViewLeaveScreen({super.key, required this.leaveData});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('View Leave'),
//         centerTitle: true,
//         backgroundColor: AppColors.primary,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             navbarState?.openScreen(null); // Go back to ApplyLeaveScreen
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildField('Name', leaveData['name']!),
//             buildField('Category', leaveData['category']!),
//             buildField('Date', leaveData['date']!),
//             buildField('Duration', '${leaveData['duration']}h'),
//             const SizedBox(height: 10),
//             buildField('Status', leaveData['status']!,
//                 color: leaveData['status'] == 'Approved'
//                     ? AppColors.success
//                     : leaveData['status'] == 'Rejected'
//                     ? AppColors.error
//                     : Colors.orange),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildField(String title, String value, {Color? color}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//           const SizedBox(height: 5),
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: color ?? Colors.grey),
//             ),
//             child: Text(
//               value,
//               style: TextStyle(
//                 color: color,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../main.dart';
import '../app_colors/app_colors.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({super.key});

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  // Error messages
  String? reasonError;
  String? categoryError;
  String? dateError;
  String? durationError;

  List<Map<String, String>> leaveList = [
    {
      'reason': 'Feeling Sick',
      'category': 'Technical Department',
      'date': '2026-02-05',
      'duration': '8',
      'status': 'Pending'
    },
    {
      'reason': 'Family Event',
      'category': 'Maintainers Department',
      'date': '2026-02-06',
      'duration': '4',
      'status': 'Approved'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply Leave'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            navbarState?.openScreen(null); // Go back to previous tab
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField('Reason', reasonController, reasonError),
            const SizedBox(height: 10),
            buildTextField('Leave Category', categoryController, categoryError),
            const SizedBox(height: 10),
            buildDateField('Date', dateController, dateError),
            const SizedBox(height: 10),
            buildTextField('Duration (hours)', durationController, durationError),
            const SizedBox(height: 20),

            /// APPLY BUTTON
            Center(
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      reasonError = null;
                      categoryError = null;
                      dateError = null;
                      durationError = null;

                      if (reasonController.text.isEmpty) {
                        reasonError = 'Reason is required';
                      }
                      if (categoryController.text.isEmpty) {
                        categoryError = 'Category is required';
                      }
                      if (dateController.text.isEmpty) {
                        dateError = 'Date is required';
                      }
                      if (durationController.text.isEmpty) {
                        durationError = 'Duration is required';
                      }

                      if (reasonError != null ||
                          categoryError != null ||
                          dateError != null ||
                          durationError != null) {
                        return;
                      }

                      leaveList.add({
                        'reason': reasonController.text,
                        'category': categoryController.text,
                        'date': dateController.text,
                        'duration': durationController.text,
                        'status': 'Pending',
                      });

                      reasonController.clear();
                      categoryController.clear();
                      dateController.clear();
                      durationController.clear();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Apply Now'),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            /// LEAVE LIST
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: leaveList.length,
              itemBuilder: (context, index) {
                final leave = leaveList[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                leave['reason'] ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert,
                                  color: AppColors.primary),
                              onSelected: (value) {
                                if (value == 'view') {
                                  navbarState?.openScreen(
                                    ViewLeaveScreen(
                                      leaveData: leave,
                                    ),
                                  );
                                } else if (value == 'delete') {
                                  setState(() {
                                    leaveList.removeAt(index);
                                  });
                                }
                              },
                              itemBuilder: (context) => const [
                                PopupMenuItem(
                                  value: 'view',
                                  child: Row(
                                    children: [
                                      Icon(Icons.remove_red_eye,
                                          color: AppColors.primary),
                                      SizedBox(width: 8),
                                      Text('View'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('Delete'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text('Category: ${leave['category']}'),
                        Text('Date: ${leave['date']}'),
                        Text('Duration: ${leave['duration']}h'),
                        const SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                            text: 'Status: ',
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: leave['status'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: leave['status'] == 'Approved'
                                      ? AppColors.success
                                      : leave['status'] == 'Rejected'
                                      ? AppColors.error
                                      : Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String title, TextEditingController controller,
      [String? errorText]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            errorText: errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDateField(String title, TextEditingController controller,
      [String? errorText]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            errorText: errorText,
            suffixIcon:
            const Icon(Icons.calendar_today, color: AppColors.primary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              controller.text =
              "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
            }
          },
        ),
      ],
    );
  }
}

/// ================= VIEW LEAVE SCREEN =================

class ViewLeaveScreen extends StatelessWidget {
  final Map<String, String> leaveData;

  const ViewLeaveScreen({super.key, required this.leaveData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Leave'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            navbarState?.openScreen(null); // Go back to ApplyLeaveScreen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildField('Reason', leaveData['reason']!),
            buildField('Category', leaveData['category']!),
            buildField('Date', leaveData['date']!),
            buildField('Duration', '${leaveData['duration']}h'),
            const SizedBox(height: 10),
            buildField('Status', leaveData['status']!,
                color: leaveData['status'] == 'Approved'
                    ? AppColors.success
                    : leaveData['status'] == 'Rejected'
                    ? AppColors.error
                    : Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget buildField(String title, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color ?? Colors.grey),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}