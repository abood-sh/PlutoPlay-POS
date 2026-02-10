import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/helpers/constants.dart';
import 'package:pos/core/routing/app_router.dart';
import 'package:pos/core/routing/routers.dart';
// import 'package:device_preview/device_preview.dart';

class PosApp extends StatelessWidget {
  final AppRouter appRouter;
  const PosApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        1366,
        768,
      ), // Smaller design = larger UI on 1366x768
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'POS ABB',
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          // initialRoute: Routers.readerSelection,
          initialRoute: isLoggedInUser
              ? Routers.navigationBar
              : Routers.loginScreen,
          onGenerateRoute: appRouter.generateRoute,
        );
      },
    );
  }
}
