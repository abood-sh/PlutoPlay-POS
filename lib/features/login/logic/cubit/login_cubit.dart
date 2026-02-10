import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/helpers/constants.dart';
import 'package:pos/core/helpers/shared_pref_helper.dart';
import 'package:pos/core/networking/api_result.dart';
import 'package:pos/core/networking/dio_factory.dart';
import 'package:pos/features/login/data/models/login_req_body.dart';
import 'package:pos/features/login/data/repos/login_repos.dart';
import 'package:pos/features/login/logic/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(
      LoginRequestBody(
        email: emailController.text,
        password: passwordController.text,
        deviceName: "Flutter Testing",
        deviceId: "postman-001",
      ),
    );
    response.when(
      success: (loginResponse) async {
        await saveUserToken(loginResponse.userData?.token ?? "");
        await saveDeviceId(loginResponse.userData?.deviceId ?? "");
        emit(LoginState.success(loginResponse));
      },
      failure: (apiErrorModel) {
        emit(LoginState.error(apiErrorModel));
      },
    );
  }

  saveUserToken(String token, {String? deviceId}) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token, deviceId: deviceId);
  }

  saveDeviceId(String deviceId) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.deviceId, deviceId);
    DioFactory.setDeviceIdIntoHeader(deviceId);
  }
}
