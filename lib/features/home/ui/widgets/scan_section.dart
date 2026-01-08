import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/home/logic/cubit/home_cubit.dart';
import 'package:pos/features/home/ui/widgets/add_custom_item_dialog.dart';

class ScanSection extends StatefulWidget {
  const ScanSection({super.key});

  @override
  State<ScanSection> createState() => _ScanSectionState();
}

class _ScanSectionState extends State<ScanSection> with WidgetsBindingObserver {
  final TextEditingController _barcodeController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // Scanner mode: true = RFID scanner (no keyboard), false = manual keyboard entry
  bool _isScannerMode = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Sync scanner mode with HomeCubit
    _isScannerMode = context.read<HomeCubit>().isScannerMode;

    // Auto focus on scan input
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _maintainFocus();
    });

    // Listen to focus changes to maintain focus in scanner mode
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _focusNode.removeListener(_onFocusChange);
    _barcodeController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Re-focus when app resumes
    if (state == AppLifecycleState.resumed && _isCurrentRouteActive()) {
      _maintainFocus();
    }
  }

  /// Check if the current route is the top route (visible)
  bool _isCurrentRouteActive() {
    final route = ModalRoute.of(context);
    return route != null && route.isCurrent;
  }

  void _onFocusChange() {
    // Only re-request focus if we're on the active route
    if (!_focusNode.hasFocus && _isScannerMode && _isCurrentRouteActive()) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted && _isScannerMode && _isCurrentRouteActive()) {
          _maintainFocus();
        }
      });
    }
  }

  void _maintainFocus() {
    // Don't maintain focus if another route is on top
    if (!_isCurrentRouteActive()) return;

    _focusNode.requestFocus();
    // In scanner mode, hide the software keyboard after a short delay
    if (_isScannerMode) {
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted && _isCurrentRouteActive()) {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        }
      });
    }
  }

  void _toggleScannerMode() {
    setState(() {
      _isScannerMode = !_isScannerMode;
    });

    // Sync with HomeCubit
    context.read<HomeCubit>().setScannerMode(_isScannerMode);

    _focusNode.requestFocus();

    if (_isScannerMode) {
      // Scanner mode: hide keyboard
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
    // In keyboard mode, the keyboard will show automatically when focused
  }

  void _addRfidToCart() {
    final tagId = _barcodeController.text.trim();
    if (tagId.isNotEmpty) {
      context.read<HomeCubit>().addRfidToCart(tagId);
      _barcodeController.clear();
      _maintainFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorsManager.mainBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorsManager.mainBlue.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          // Scanner/Keyboard mode toggle
          GestureDetector(
            onTap: _toggleScannerMode,
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: _isScannerMode ? ColorsManager.mainBlue : Colors.orange,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                _isScannerMode ? Icons.qr_code_scanner : Icons.keyboard,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
          ),
          horizontalSpace(12.w),
          Expanded(
            child: TextField(
              controller: _barcodeController,
              focusNode: _focusNode,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              // Auto-submit when Enter is pressed (scanner sends Enter after code)
              onSubmitted: (value) => _addRfidToCart(),
              onTap: () {
                // When tapped in scanner mode, hide keyboard again
                if (_isScannerMode) {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                }
              },
              decoration: InputDecoration(
                hintText: _isScannerMode
                    ? 'Ready for RFID scan...'
                    : 'Enter barcode manually...',
                hintStyle: TextStyles.font14GrayRegular,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                // Show mode indicator
                suffixIcon: Icon(
                  _isScannerMode
                      ? Icons.bluetooth_connected
                      : Icons.keyboard_alt_outlined,
                  color: _isScannerMode ? Colors.green : Colors.orange,
                  size: 20.sp,
                ),
              ),
            ),
          ),
          horizontalSpace(8.w),
          ElevatedButton(
            onPressed: _addRfidToCart,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text('Add', style: TextStyles.font14WhiteSemiBold),
          ),
          horizontalSpace(8.w),
          // Add Custom Item button
          GestureDetector(
            onTap: () => AddCustomItemDialog.show(context),
            child: Container(
              width: 120.w,
              height: 40.h,
              padding: EdgeInsets.all(10.w),
              margin: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.add_box_outlined,
                color: Colors.white,
                size: 40.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
