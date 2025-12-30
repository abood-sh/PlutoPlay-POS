import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';

import '../../../../core/theming/styles.dart';

class PasswordValidation extends StatelessWidget {
  const PasswordValidation({
    super.key,
    required this.hasUpperCase,
    required this.hasLowerCase,
    required this.hasNumbers,
    required this.hasSpecialCharacters,
    required this.hasMinLength,
  });
  final bool hasUpperCase;
  final bool hasLowerCase;
  final bool hasNumbers;
  final bool hasSpecialCharacters;
  final bool hasMinLength;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // buildValidationRow('At least 1 UpperCase', hasUpperCase, context),
        // verticalSpace(6),
        // buildValidationRow('At least 1 LowerCase', hasLowerCase, context),
        // verticalSpace(6),
        // buildValidationRow('At least 1 Number', hasNumbers, context),
        // verticalSpace(6),
        // buildValidationRow(
        //   'At least 1 SpecialCharacter',
        //   hasSpecialCharacters,
        //   context,
        // ),
        // verticalSpace(6),
        buildValidationRow('At least 8 characters long', hasMinLength, context),
      ],
    );
  }

  Widget buildValidationRow(
    String text,
    bool hasValidate,
    BuildContext context,
  ) {
    return Row(
      children: [
        CircleAvatar(radius: 2.5.r, backgroundColor: ColorsManager.gray),
        horizontalSpace(6),
        Text(
          text,
          style: TextStyles.font13DarkBlueRegular.copyWith(
            decoration: hasValidate ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            decorationThickness: 2,
            color: hasValidate ? ColorsManager.gray : ColorsManager.darkBlue,
          ),
        ),
      ],
    );
  }
}
