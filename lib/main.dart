import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pos/core/di/dependency_injection.dart';
import 'package:pos/core/helpers/constants.dart';
import 'package:pos/core/helpers/shared_pref_helper.dart';
import 'package:pos/core/routing/app_router.dart';
import 'package:pos/core/services/sound_service.dart';
import 'package:pos/pos_app.dart';
import 'package:pos/core/helpers/extension.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  final loginCheckFuture = checkIfLoggedInUser();
  await loginCheckFuture;

  // Initialize sound service for scan feedback
  await SoundService().init();

  runApp(
    // PosApp(appRouter: AppRouter()),
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => PosApp(appRouter: AppRouter()), // Wrap your app
    ),
  );
}

checkIfLoggedInUser() async {
  String? userToken = await SharedPrefHelper.getSecuredString(
    SharedPrefKeys.userToken,
  );
  if (!userToken.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}
