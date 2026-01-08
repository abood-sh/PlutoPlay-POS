import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/home/logic/cubit/home_cubit.dart';
import 'package:pos/features/home/logic/cubit/home_state.dart';

class AddCustomItemDialog extends StatefulWidget {
  final HomeCubit homeCubit;

  const AddCustomItemDialog({super.key, required this.homeCubit});

  /// Show the dialog and return true if item was added successfully
  static Future<bool?> show(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => BlocProvider.value(
        value: homeCubit,
        child: AddCustomItemDialog(homeCubit: homeCubit),
      ),
    );
  }

  @override
  State<AddCustomItemDialog> createState() => _AddCustomItemDialogState();
}

class _AddCustomItemDialogState extends State<AddCustomItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _barcodeController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Focus node for barcode field (scanner support)
  final _barcodeFocusNode = FocusNode();
  bool _isScannerMode = true;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Get scanner mode from HomeCubit
    _isScannerMode = widget.homeCubit.isScannerMode;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _barcodeController.dispose();
    _descriptionController.dispose();
    _barcodeFocusNode.dispose();
    super.dispose();
  }

  void _toggleBarcodeScannerMode() {
    setState(() {
      _isScannerMode = !_isScannerMode;
    });
    _barcodeFocusNode.requestFocus();
    if (_isScannerMode) {
      // Hide keyboard in scanner mode
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final price = num.tryParse(_priceController.text.trim()) ?? 0;
    final quantity = int.tryParse(_quantityController.text.trim()) ?? 1;
    final barcode = _barcodeController.text.trim();
    final description = _descriptionController.text.trim();

    context.read<HomeCubit>().addCustomItem(
      name: name,
      price: price,
      quantity: quantity,
      barcode: barcode.isNotEmpty ? barcode : null,
      description: description.isNotEmpty ? description : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          current is AddCustomItemLoading ||
          current is AddCustomItemSuccess ||
          current is AddCustomItemError,
      listener: (context, state) {
        state.maybeWhen(
          addCustomItemLoading: () {
            setState(() => _isLoading = true);
          },
          addCustomItemSuccess: (_) {
            setState(() => _isLoading = false);
            // Store messenger before popping
            final messenger = ScaffoldMessenger.of(context);
            Navigator.pop(context, true);
            messenger.showSnackBar(
              const SnackBar(
                content: Text('Custom item added successfully'),
                backgroundColor: Colors.green,
              ),
            );
          },
          addCustomItemError: (error) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.message ?? 'Failed to add custom item'),
                backgroundColor: Colors.red,
              ),
            );
          },
          orElse: () {},
        );
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Responsive width
            final isTablet = MediaQuery.of(context).size.width > 600;
            final dialogWidth = isTablet ? 500.0 : double.infinity;

            return Container(
              width: dialogWidth,
              constraints: BoxConstraints(
                maxWidth: 500.w,
                maxHeight: MediaQuery.of(context).size.height * 0.85,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  _buildHeader(),
                  // Form
                  Flexible(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildNameField(),
                            verticalSpace(12.h),
                            _buildPriceQuantityRow(),
                            verticalSpace(12.h),
                            _buildBarcodeField(),
                            verticalSpace(12.h),
                            _buildDescriptionField(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Actions
                  _buildActions(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorsManager.mainBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.add_shopping_cart, color: Colors.white, size: 22.sp),
          horizontalSpace(8.w),
          Text('Add Custom Item', style: TextStyles.font16WhiteSemiBold),
          const Spacer(),
          IconButton(
            onPressed: _isLoading ? null : () => Navigator.pop(context),
            icon: Icon(Icons.close, color: Colors.white, size: 20.sp),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Item Name *', style: TextStyles.font14DarkBlueMedium),
        verticalSpace(6.h),
        TextFormField(
          controller: _nameController,
          textCapitalization: TextCapitalization.words,
          decoration: _inputDecoration(
            hint: 'Enter item name',
            icon: Icons.inventory_2_outlined,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter item name';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPriceQuantityRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price *', style: TextStyles.font14DarkBlueMedium),
              verticalSpace(6.h),
              TextFormField(
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: _inputDecoration(
                  hint: '0.00',
                  icon: Icons.attach_money,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Required';
                  }
                  final price = num.tryParse(value.trim());
                  if (price == null || price <= 0) {
                    return 'Invalid price';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        horizontalSpace(12.w),
        // Quantity
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quantity *', style: TextStyles.font14DarkBlueMedium),
              verticalSpace(6.h),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: _inputDecoration(hint: '1', icon: Icons.numbers),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Required';
                  }
                  final qty = int.tryParse(value.trim());
                  if (qty == null || qty <= 0) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBarcodeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Barcode', style: TextStyles.font14DarkBlueMedium),
            horizontalSpace(4.w),
            Expanded(
              child: Text(
                '(Optional - auto-generated if empty)',
                style: TextStyles.font12GrayRegular,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Scanner/Keyboard toggle button
            GestureDetector(
              onTap: _toggleBarcodeScannerMode,
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: _isScannerMode
                      ? ColorsManager.mainBlue
                      : Colors.orange,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  _isScannerMode ? Icons.qr_code_scanner : Icons.keyboard,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
          ],
        ),
        verticalSpace(6.h),
        TextFormField(
          controller: _barcodeController,
          focusNode: _barcodeFocusNode,
          readOnly: _isScannerMode,
          showCursor: !_isScannerMode,
          onTap: () {
            if (_isScannerMode) {
              // Hide keyboard in scanner mode
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            }
          },
          decoration: InputDecoration(
            hintText: _isScannerMode ? 'Scan barcode...' : 'CUSTOM-001',
            hintStyle: TextStyles.font14GrayRegular,
            prefixIcon: Icon(
              Icons.qr_code,
              color: ColorsManager.gray,
              size: 20.sp,
            ),
            suffixIcon: _isScannerMode
                ? Icon(
                    Icons.sensors,
                    color: ColorsManager.mainBlue,
                    size: 20.sp,
                  )
                : null,
            filled: true,
            fillColor: _isScannerMode
                ? ColorsManager.mainBlue.withOpacity(0.05)
                : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: _isScannerMode
                    ? ColorsManager.mainBlue
                    : ColorsManager.lighterGray,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: _isScannerMode
                    ? ColorsManager.mainBlue
                    : ColorsManager.lighterGray,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: ColorsManager.mainBlue, width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            isDense: true,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: TextStyles.font14DarkBlueMedium),
        horizontalSpace(4.w),
        Text('(Optional)', style: TextStyles.font12GrayRegular),
        verticalSpace(6.h),
        TextFormField(
          controller: _descriptionController,
          maxLines: 2,
          textCapitalization: TextCapitalization.sentences,
          decoration: _inputDecoration(
            hint: 'Enter item description',
            icon: Icons.description_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.lighterGray.withOpacity(0.3),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _isLoading ? null : () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                side: BorderSide(color: ColorsManager.gray),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text('Cancel', style: TextStyles.font14GrayRegular),
            ),
          ),
          horizontalSpace(12.w),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.mainBlue,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: _isLoading
                  ? SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 18.sp),
                        horizontalSpace(6.w),
                        Text('Add Item', style: TextStyles.font14WhiteSemiBold),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyles.font14GrayRegular,
      prefixIcon: Icon(icon, color: ColorsManager.gray, size: 20.sp),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: ColorsManager.lighterGray),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: ColorsManager.lighterGray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: ColorsManager.mainBlue, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      isDense: true,
    );
  }
}
