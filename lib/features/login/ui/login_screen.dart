import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/spacing.dart';
import 'package:pos/core/theming/colors.dart';

import '../../../core/theming/styles.dart';
import '../../../core/widget/app_text_button.dart';
import '../logic/cubit/login_cubit.dart';
import '../logic/cubit/login_state.dart';
import 'widgets/email_and_password.dart';
import 'widgets/login_bloc_listener.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth > 600;
            final maxWidth = isTablet ? 500.0 : double.infinity;

            return Center(
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                    vertical: 24.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Welcome to PlutoPay",
                        style: TextStyles.font24BlueBold,
                      ),
                      verticalSpace(8.h),
                      Text(
                        "Login with the data you entered during your registration",
                        style: TextStyles.font14GrayRegular,
                      ),
                      verticalSpace(24.h),
                      const EmailAndPassword(),
                      verticalSpace(25.h),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          if (state is Loading) {
                            return AppTextButton(
                              buttonText: "",
                              buttonHeight: 50.h,
                              backgroundColor: ColorsManager.lighterGray,
                              textStyle: TextStyles.font16WhiteSemiBold,
                              onPressed: () {},
                              isLoading: true,
                            );
                          }
                          return AppTextButton(
                            buttonText: "Login",
                            buttonHeight: 60.h,
                            textStyle: TextStyles.font16WhiteSemiBold,
                            onPressed: () {
                              validateThenLogin(context);
                            },
                          );
                        },
                      ),
                      const LoginBlocListener(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void validateThenLogin(BuildContext context) {
    if (context.read<LoginCubit>().formKey.currentState!.validate()) {
      context.read<LoginCubit>().emitLoginStates();
    }
  }
}
