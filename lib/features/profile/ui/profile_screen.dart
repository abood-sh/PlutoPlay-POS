import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/extension.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/routing/routers.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/printer/data/models/printer_model.dart';
import 'package:pos/features/printer/ui/widgets/printer_selection_dialog.dart';
import 'package:pos/features/profile/data/models/profile_response.dart';
import 'package:pos/features/profile/logic/cubit/profile_cubit.dart';
import 'package:pos/features/profile/logic/cubit/profile_state.dart';
import 'package:pos/features/profile/ui/widgets/dialogs/change_password_dialog.dart';
import 'package:pos/features/profile/ui/widgets/dialogs/link_terminal_dialog.dart';
import 'package:pos/features/profile/ui/widgets/dialogs/logout_dialog.dart';
import 'package:pos/features/profile/ui/widgets/logout_button.dart';
import 'package:pos/features/profile/ui/widgets/performance_section.dart';
import 'package:pos/features/profile/ui/widgets/profile_header.dart';
import 'package:pos/features/profile/ui/widgets/setting_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) => current is ProfileLogoutSuccess,
      listener: (context, state) {
        // Navigate to login after logout completes
        context.pushNamedAndRemoveUntil(Routers.loginScreen);
      },
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (profileData, selectedPrinter) => _buildProfileContent(
                context,
                profileData,
                selectedPrinter,
                isLoggingOut: false,
              ),
              error: (error) => _buildErrorState(context, error.message),
              loggingOut: () {
                // Get cached data from cubit to show UI while logging out
                final cubit = context.read<ProfileCubit>();
                return _buildProfileContent(
                  context,
                  cubit.cachedProfileData,
                  cubit.cachedPrinter,
                  isLoggingOut: true,
                );
              },
              logoutSuccess: () =>
                  const Center(child: CircularProgressIndicator()),
              printerUpdated: (printer) {
                final cubit = context.read<ProfileCubit>();
                return _buildProfileContent(
                  context,
                  cubit.cachedProfileData,
                  printer,
                  isLoggingOut: false,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String? message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64.w, color: ColorsManager.red),
          verticalSpace(16.h),
          Text(
            message ?? 'Failed to load profile',
            style: TextStyles.font14GrayRegular,
          ),
          verticalSpace(16.h),
          ElevatedButton(
            onPressed: () => context.read<ProfileCubit>().getProfile(),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
            ),
            child: Text('Retry', style: TextStyles.font14WhiteSemiBold),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(
    BuildContext context,
    ProfileData? profileData,
    PrinterModel? selectedPrinter, {
    required bool isLoggingOut,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User Info Section
        ProfileHeader(
          salesman: profileData?.salesman,
          store: profileData?.store,
        ),
        verticalSpace(24.h),

        // Performance Section
        if (profileData?.performance != null) ...[
          PerformanceSection(performance: profileData!.performance!),
          verticalSpace(24.h),
        ],

        // Settings Section
        Text('Settings', style: TextStyles.font18DarkBlueBold),
        verticalSpace(12.h),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SettingItem(
                  icon: Icons.print,
                  title: 'Link Printer',
                  subtitle: selectedPrinter != null
                      ? '${selectedPrinter.name} (${selectedPrinter.ip})'
                      : 'Connect receipt printer',
                  onTap: () => _showLinkPrinterDialog(context, selectedPrinter),
                ),
                verticalSpace(24.h),

                // Logout Button
                LogoutButton(
                  isLoading: isLoggingOut,
                  onPressed: () => _handleLogout(context),
                ),
                verticalSpace(16.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showLinkPrinterDialog(
    BuildContext context,
    PrinterModel? currentPrinter,
  ) async {
    final result = await showDialog<PrinterModel>(
      context: context,
      builder: (dialogContext) =>
          PrinterSelectionDialog(currentPrinter: currentPrinter),
    );

    if (result != null && context.mounted) {
      context.read<ProfileCubit>().savePrinter(result);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Printer "${result.name}" linked successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await LogoutDialog.show(context);
    if (confirmed && context.mounted) {
      context.read<ProfileCubit>().logout();
    }
  }
}
