import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mek_stripe_terminal/mek_stripe_terminal.dart';
import 'package:pos/core/helpers/extension.dart';
import 'package:pos/core/routing/routers.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/terminal/logic/cubit/terminal_cubit.dart';
import 'package:pos/features/terminal/logic/cubit/terminal_state.dart';

/// Screen for discovering and selecting card readers via Stripe Terminal SDK
/// Uses WiFi/Internet discovery to find available readers
class ReaderSelectionScreen extends StatefulWidget {
  final String locationId;

  const ReaderSelectionScreen({super.key, required this.locationId});

  @override
  State<ReaderSelectionScreen> createState() => _ReaderSelectionScreenState();
}

class _ReaderSelectionScreenState extends State<ReaderSelectionScreen> {
  @override
  void initState() {
    super.initState();
    // Start SDK initialization and reader discovery
    context.read<TerminalCubit>().initializeAndDiscoverReaders(
      locationId: widget.locationId,
      //todo :Set to true for testing with
      isSimulated: false, // Set to true for testing without physical reader
    );
  }

  @override
  void dispose() {
    // Stop discovery when leaving screen
    context.read<TerminalCubit>().stopDiscovery();
    super.dispose();
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
              Expanded(child: _buildReaderList()),
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
        Text('Select Card Reader', style: TextStyles.font32BlueBold),
        SizedBox(height: 12.h),
        Text(
          'Discovering available card readers on your network. Select a reader to connect.',
          style: TextStyles.font13GrayRegular.copyWith(fontSize: 16.sp),
        ),
      ],
    );
  }

  Widget _buildReaderList() {
    return BlocConsumer<TerminalCubit, TerminalState>(
      listener: (context, state) {
        state.whenOrNull(
          terminalSelected: () {
            context.pushReplacementNamed(Routers.navigationBar);
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
          success: (_) => const SizedBox.shrink(),
          terminalSelected: () => _buildConnectionSuccessState('Connected!'),
          error: (apiErrorModel) => _buildErrorState(apiErrorModel.message),
          // SDK states
          sdkInitializing: () => _buildLoadingState(
            'Initializing Stripe Terminal...',
            'Setting up secure connection',
          ),
          sdkInitialized: () => _buildLoadingState(
            'SDK Ready',
            'Preparing to discover readers...',
          ),
          sdkError: (message) => _buildErrorState(message),
          // Reader discovery states
          discoveringReaders: () => _buildLoadingState(
            'Discovering Readers...',
            'Searching for card readers on your network',
          ),
          readersDiscovered: (readers) => _buildReaderGrid(readers),
          noReadersFound: () => _buildNoReadersState(),
          // Reader connection states
          readerConnecting: () => _buildLoadingState(
            'Connecting to Reader...',
            'Please wait while we establish connection',
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

  Widget _buildNoReadersState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: 80.w, color: ColorsManager.gray),
          SizedBox(height: 16.h),
          Text(
            'No readers found',
            style: TextStyles.font13DarkBlueMedium.copyWith(fontSize: 18.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            'Make sure your card reader is powered on\nand connected to the same network.',
            style: TextStyles.font13GrayRegular,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: () {
              context.read<TerminalCubit>().refreshDiscovery();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
            ),
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
            message ?? 'Failed to discover readers',
            style: TextStyles.font13DarkBlueMedium.copyWith(fontSize: 18.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: () {
              context.read<TerminalCubit>().refreshDiscovery();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReaderGrid(List<Reader> readers) {
    return Column(
      children: [
        // Reader count and refresh button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${readers.length} reader${readers.length != 1 ? 's' : ''} found',
              style: TextStyles.font13GrayRegular.copyWith(fontSize: 14.sp),
            ),
            TextButton.icon(
              onPressed: () {
                context.read<TerminalCubit>().refreshDiscovery();
              },
              icon: Icon(Icons.refresh, size: 18.w),
              label: const Text('Refresh'),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        // Reader grid
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 1.3,
            ),
            itemCount: readers.length,
            itemBuilder: (context, index) {
              return _buildReaderCard(readers[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReaderCard(Reader reader) {
    final isOnline = reader.networkStatus == NetworkStatus.online;
    final deviceType =
        reader.deviceType?.name.replaceAll('_', ' ') ?? 'Unknown';

    return GestureDetector(
      onTap: () => _showConfirmDialog(reader),
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
                    reader.label ?? reader.serialNumber,
                    style: TextStyles.font13DarkBlueMedium.copyWith(
                      fontSize: 16.sp,
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
                Row(
                  children: [
                    Icon(Icons.wifi, size: 16.w, color: ColorsManager.gray),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        reader.ipAddress ?? 'No IP',
                        style: TextStyles.font8GrayRegular.copyWith(
                          fontSize: 12.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  deviceType.toUpperCase(),
                  style: TextStyles.font8GrayRegular.copyWith(
                    fontSize: 10.sp,
                    color: ColorsManager.mainBlue,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'S/N: ${reader.serialNumber}',
                  style: TextStyles.font8GrayRegular.copyWith(fontSize: 10.sp),
                  overflow: TextOverflow.ellipsis,
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
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isOnline
            ? ColorsManager.green.withOpacity(0.1)
            : ColorsManager.gray.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: isOnline ? ColorsManager.green : ColorsManager.gray,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            isOnline ? 'Online' : 'Offline',
            style: TextStyle(
              fontSize: 10.sp,
              color: isOnline ? ColorsManager.green : ColorsManager.gray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmDialog(Reader reader) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Connect to Reader?',
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
                    reader.label ?? reader.serialNumber,
                    style: TextStyles.font13DarkBlueMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'IP: ${reader.ipAddress ?? 'N/A'}',
                    style: TextStyles.font13GrayRegular,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'S/N: ${reader.serialNumber}',
                    style: TextStyles.font8GrayRegular.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Type: ${reader.deviceType?.name.replaceAll('_', ' ').toUpperCase() ?? 'Unknown'}',
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
              context.read<TerminalCubit>().connectToReader(reader);
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
