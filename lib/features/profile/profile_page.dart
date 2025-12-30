import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/printer/data/models/printer_model.dart';
import 'package:pos/features/printer/data/printer_service.dart';
import 'package:pos/features/printer/ui/widgets/printer_selection_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PrinterModel? selectedPrinter;

  @override
  void initState() {
    super.initState();
    _loadSelectedPrinter();
  }

  Future<void> _loadSelectedPrinter() async {
    final printer = await PrinterService.getSelectedPrinter();
    setState(() {
      selectedPrinter = printer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Section
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: ColorsManager.lightBlue,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32.sp,
                    backgroundColor: ColorsManager.mainBlue,
                    child: Icon(Icons.person, size: 32.sp, color: Colors.white),
                  ),
                  horizontalSpace(16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Abdelrahman Shaban',
                          style: TextStyles.font18DarkBlueBold,
                        ),
                        verticalSpace(4.h),
                        Text(
                          'abood.do@example.com',
                          style: TextStyles.font14GrayRegular,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(24.h),
            // Settings Section
            Text('Settings', style: TextStyles.font18DarkBlueBold),
            verticalSpace(12.h),
            _buildSettingItem(
              context,
              icon: Icons.lock_outline,
              title: 'Change Password',
              subtitle: 'Update your password',
              onTap: () => _showChangePasswordDialog(context),
            ),
            verticalSpace(12.h),

            _buildSettingItem(
              context,
              icon: Icons.devices,
              title: 'Link Terminal',
              subtitle: 'Connect payment terminal',
              onTap: () => _showLinkTerminalDialog(context),
            ),
            verticalSpace(12.h),

            _buildSettingItem(
              context,
              icon: Icons.print,
              title: 'Link Printer',
              subtitle: selectedPrinter != null
                  ? '${selectedPrinter!.name} (${selectedPrinter!.ip})'
                  : 'Connect receipt printer',
              onTap: () => _showLinkPrinterDialog(context),
            ),
            verticalSpace(24.h),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showLogoutDialog(context),
                icon: const Icon(Icons.logout),
                label: Text('Logout', style: TextStyles.font14DarkBlueMedium),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  side: const BorderSide(color: ColorsManager.red),
                  foregroundColor: ColorsManager.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorsManager.white,
          border: Border.all(color: ColorsManager.lighterGray),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: ColorsManager.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, size: 24.sp, color: ColorsManager.mainBlue),
            ),
            horizontalSpace(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyles.font14DarkBlueMedium),
                  verticalSpace(4.h),
                  Text(subtitle, style: TextStyles.font12GrayRegular),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: ColorsManager.gray,
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Text('Change Password', style: TextStyles.font18DarkBlueBold),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
                labelStyle: TextStyles.font14GrayRegular,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            verticalSpace(12.h),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                labelStyle: TextStyles.font14GrayRegular,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            verticalSpace(12.h),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: TextStyles.font14GrayRegular,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyles.font14GrayRegular),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle password change
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password changed successfully')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text('Update', style: TextStyles.font14WhiteSemiBold),
          ),
        ],
      ),
    );
  }

  void _showLinkTerminalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Text('Link Terminal', style: TextStyles.font18DarkBlueBold),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.devices, size: 64.sp, color: ColorsManager.mainBlue),
            verticalSpace(16.h),
            Text(
              'Search for available payment terminals',
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
            verticalSpace(16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Searching for terminals...')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.mainBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Scan Devices',
                  style: TextStyles.font14WhiteSemiBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLinkPrinterDialog(BuildContext context) async {
    final result = await showDialog<PrinterModel>(
      context: context,
      builder: (context) =>
          PrinterSelectionDialog(currentPrinter: selectedPrinter),
    );

    if (result != null) {
      await PrinterService.saveSelectedPrinter(result);
      setState(() {
        selectedPrinter = result;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Printer "${result.name}" linked successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Text('Logout', style: TextStyles.font18DarkBlueBold),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyles.font14GrayRegular,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyles.font14GrayRegular),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle logout - navigate to login screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text('Logout', style: TextStyles.font14WhiteSemiBold),
          ),
        ],
      ),
    );
  }
}
