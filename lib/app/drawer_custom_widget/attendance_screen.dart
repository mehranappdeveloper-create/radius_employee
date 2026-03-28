import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import '../../main.dart';
import '../app_colors/app_colors.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String selectedDepartment = 'Select Employee';
  bool showData = false;

  DateTime? checkInTime;
  DateTime? checkOutTime;
  Duration? workedHours;

  final List<String> departments = [
    'Select Employee',
    'HR Department',
    'IT Department',
    'Accounts',
    'Marketing',
  ];

  /// Format Time
  String formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')}:"
        "${time.second.toString().padLeft(2, '0')}";
  }

  /// Format Date
  String formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }

  /// Format duration with hours + minutes + decimal hour
  String formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes % 60;
    final decimalHours = d.inMinutes / 60.0;
    return "$hours h $minutes m (${decimalHours.toStringAsFixed(2)} h)";
  }

  /// Dropdown open flag
  bool dropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Attendance'),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              navbarState?.openScreen(null);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Employee Title
              Center(
                child: Text(
                  'Employee',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// Dropdown + GO Button
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomDropdown(
                      items: departments,
                      selected: selectedDepartment,
                      onSelect: (val) {
                        setState(() {
                          selectedDepartment = val;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.surface,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                    ),
                    onPressed: selectedDepartment == 'Select Employee'
                        ? null
                        : () {
                      setState(() {
                        showData = true;
                        checkInTime = null;
                        checkOutTime = null;
                        workedHours = null;
                      });
                    },
                    child: const Text('GO'),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              /// ================= TABLE UI =================
              if (showData)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      /// TABLE HEADER
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: const [
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  'Type',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  'Date',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  'Time',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  'Action',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      /// CHECK IN ROW
                      _tableRow(
                        title: 'Check In',
                        date:
                        checkInTime != null ? formatDate(checkInTime!) : '--',
                        time:
                        checkInTime != null ? formatTime(checkInTime!) : '--',
                        buttonText: 'IN',
                        buttonEnabled: checkInTime == null,
                        onPressed: () {
                          setState(() {
                            checkInTime = DateTime.now();
                          });
                        },
                      ),
                      const SizedBox(height: 8),

                      /// CHECK OUT ROW
                      _tableRow(
                        title: 'Check Out',
                        date: checkOutTime != null
                            ? formatDate(checkOutTime!)
                            : '--',
                        time: checkOutTime != null
                            ? formatTime(checkOutTime!)
                            : '--',
                        buttonText: 'OUT',
                        buttonEnabled:
                        checkInTime != null && checkOutTime == null,
                        onPressed: () {
                          setState(() {
                            checkOutTime = DateTime.now();
                            workedHours =
                                checkOutTime!.difference(checkInTime!);
                          });
                        },
                      ),
                      const Divider(height: 30),

                      /// HOURS COUNT
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Hours Count',
                            style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              workedHours != null
                                  ? formatDuration(workedHours!)
                                  : '--',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= TABLE ROW WIDGET =================
  Widget _tableRow({
    required String title,
    required String date,
    required String time,
    required String buttonText,
    required bool buttonEnabled,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /// TYPE
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          /// DATE
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                date,
                style: const TextStyle(fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          /// TIME
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                time,
                style: const TextStyle(fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          /// BUTTON
          Expanded(
            flex: 2,
            child: Center(
              child: SizedBox(
                height: 36,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: ElevatedButton(
                    onPressed: buttonEnabled ? onPressed : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.surface,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                    ),
                    child: Text(buttonText),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= CUSTOM DROPDOWN USING PORTAL =================
class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String selected;
  final Function(String) onSelect;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.selected,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool open = false;

  @override
  Widget build(BuildContext context) {
    return PortalTarget(
      visible: open,
      anchor: const Aligned(
        follower: Alignment.topLeft,
        target: Alignment.bottomLeft,
      ),
      portalFollower: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        color: AppColors.surface, // dropdown background color
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.items.map((item) {
                return InkWell(
                  onTap: () {
                    widget.onSelect(item);
                    setState(() => open = false);
                  },
                  child: Container(
                    width: double.infinity, // dropdown same width as button
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () => setState(() => open = !open),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surface, // button background color
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.selected, // selected text show
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                  ),
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}
