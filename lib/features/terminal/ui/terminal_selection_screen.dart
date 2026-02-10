import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/extension.dart';
import 'package:pos/core/routing/routers.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/terminal/data/models/terminal_model.dart';
import 'package:pos/features/terminal/logic/cubit/terminal_cubit.dart';
import 'package:pos/features/terminal/logic/cubit/terminal_state.dart';

class TerminalSelectionScreen extends StatefulWidget {
  final String deviceId;

  const TerminalSelectionScreen({super.key, required this.deviceId});

  @override
  State<TerminalSelectionScreen> createState() =>
      _TerminalSelectionScreenState();
}

class _TerminalSelectionScreenState extends State<TerminalSelectionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TerminalCubit>().fetchTerminals(widget.deviceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.moreLighterGray,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              _buildHeader(),
              SizedBox(height: 40.h),
              Expanded(child: _buildTerminalList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Terminal', style: TextStyles.font32BlueBold),
        SizedBox(height: 12.h),
        Text(
          'Choose a terminal to connect with this device. This selection is required for payment processing.',
          style: TextStyles.font13GrayRegular.copyWith(fontSize: 16.sp),
        ),
      ],
    );
  }

  Widget _buildTerminalList() {
    return BlocConsumer<TerminalCubit, TerminalState>(
      listener: (context, state) {
        state.whenOrNull(
          terminalSelected: () {
            context.pushReplacementNamed(Routers.navigationBar);
          },
          error: (apiErrorModel) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(apiErrorModel.message ?? 'An error occurred'),
                backgroundColor: ColorsManager.red,
              ),
            );
          },
          sdkError: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('SDK Error: $message'),
                backgroundColor: ColorsManager.red,
              ),
            );
          },
          readerConnectionError: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: ColorsManager.red,
              ),
            );
          },
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          success: (data) {
            final terminals = context.read<TerminalCubit>().terminals;
            if (terminals.isEmpty) {
              return _buildEmptyState();
            }
            return _buildTerminalGrid(terminals);
          },
          terminalSelected: () => _buildConnectionSuccessState('Connected!'),
          error: (apiErrorModel) => _buildErrorState(apiErrorModel.message),
          // SDK states
          sdkInitializing: () => _buildLoadingState(
            'Initializing Stripe Terminal...',
            'Setting up secure connection',
          ),
          sdkInitialized: () =>
              _buildLoadingState('SDK Ready', 'Preparing to connect reader...'),
          sdkError: (message) => _buildErrorState(message),
          // Reader discovery states (not used in this screen, handled in ReaderSelectionScreen)
          discoveringReaders: () => const SizedBox.shrink(),
          readersDiscovered: (_) => const SizedBox.shrink(),
          noReadersFound: () => const SizedBox.shrink(),
          // Reader connection states
          readerConnecting: () => _buildLoadingState(
            'Connecting to Reader...',
            'Please wait while we connect via WiFi',
          ),
          readerConnected: (readerLabel) =>
              _buildConnectionSuccessState('Connected to: $readerLabel'),
          readerConnectionError: (message) => _buildErrorState(message),
        );
      },
    );
  }

  Widget _buildLoadingState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: 24.h),
          Text(
            title,
            style: TextStyles.font13DarkBlueMedium.copyWith(fontSize: 18.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: TextStyles.font13GrayRegular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionSuccessState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: ColorsManager.green, size: 80.w),
          SizedBox(height: 16.h),
          Text(
            message,
            style: TextStyles.font13DarkBlueMedium.copyWith(fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.devices_other, size: 80.w, color: ColorsManager.gray),
          SizedBox(height: 16.h),
          Text(
            'No terminals available',
            style: TextStyles.font13DarkBlueMedium.copyWith(fontSize: 18.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            'Please contact your administrator',
            style: TextStyles.font13GrayRegular,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              context.read<TerminalCubit>().fetchTerminals(widget.deviceId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
            ),
            child: Text('Retry', style: TextStyles.font16WhiteSemiBold),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String? message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80.w, color: ColorsManager.red),
          SizedBox(height: 16.h),
          Text(
            message ?? 'Failed to load terminals',
            style: TextStyles.font13DarkBlueMedium.copyWith(fontSize: 18.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              context.read<TerminalCubit>().fetchTerminals(widget.deviceId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
            ),
            child: Text('Retry', style: TextStyles.font16WhiteSemiBold),
          ),
        ],
      ),
    );
  }

  Widget _buildTerminalGrid(List<TerminalModel> terminals) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 1.5,
      ),
      itemCount: terminals.length,
      itemBuilder: (context, index) {
        return _buildTerminalCard(terminals[index]);
      },
    );
  }

  Widget _buildTerminalCard(TerminalModel terminal) {
    final isOnline = terminal.isOnline;

    return GestureDetector(
      onTap: () => _showConfirmDialog(terminal),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isOnline ? ColorsManager.green : ColorsManager.lightGray,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    terminal.label ?? 'Unknown Terminal',
                    style: TextStyles.font13DarkBlueMedium.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _buildStatusIndicator(isOnline),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  terminal.store?.name ?? '',
                  style: TextStyles.font13GrayRegular.copyWith(fontSize: 14.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.wifi, size: 16.w, color: ColorsManager.gray),
                    SizedBox(width: 4.w),
                    Text(
                      terminal.ipAddress ?? 'No IP',
                      style: TextStyles.font8GrayRegular.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  terminal.deviceType?.replaceAll('_', ' ').toUpperCase() ?? '',
                  style: TextStyles.font8GrayRegular.copyWith(
                    fontSize: 10.sp,
                    color: ColorsManager.mainBlue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(bool isOnline) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isOnline
            ? ColorsManager.green.withOpacity(0.1)
            : ColorsManager.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: isOnline ? ColorsManager.green : ColorsManager.red,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            isOnline ? 'Online' : 'Offline',
            style: TextStyle(
              fontSize: 12.sp,
              color: isOnline ? ColorsManager.green : ColorsManager.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmDialog(TerminalModel terminal) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Connect to Terminal?',
          style: TextStyles.font24BlackBold.copyWith(fontSize: 20.sp),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You are about to connect to:',
              style: TextStyles.font13GrayRegular,
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: ColorsManager.moreLighterGray,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    terminal.label ?? 'Unknown',
                    style: TextStyles.font13DarkBlueMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    terminal.store?.name ?? '',
                    style: TextStyles.font13GrayRegular,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'IP: ${terminal.ipAddress ?? 'N/A'}',
                    style: TextStyles.font8GrayRegular.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel', style: TextStyles.font13GrayRegular),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<TerminalCubit>().selectTerminal(terminal);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Connect',
              style: TextStyles.font16WhiteSemiBold.copyWith(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}
