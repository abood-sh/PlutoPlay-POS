import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/helpers/extension.dart';
import 'package:pos/core/networking/api_error_model.dart';
import 'package:pos/features/login/logic/cubit/login_cubit.dart';
import 'package:pos/features/login/logic/cubit/login_state.dart';

import '../../../../core/routing/routers.dart';
import '../../../../core/theming/styles.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            // showDialog(
            //   context: context,
            //   builder: (context) =>
            //       const Center(child: CircularProgressIndicator()),
            // );
          },
          success: (loginResponse) {
            //context.pop();
            context.pushReplacementNamed(Routers.navigationBar);
          },
          error: (apiErrorModel) {
            setUpErrorState(context, apiErrorModel);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void setUpErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
    // context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.error, color: Colors.red, size: 80),
        content: Text(
          apiErrorModel.message ?? "An unexpected error occurred",
          style: TextStyles.font15DarkBlueMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text('Got it', style: TextStyles.font14BlueSemiBold),
          ),
        ],
      ),
    );
  }
}
