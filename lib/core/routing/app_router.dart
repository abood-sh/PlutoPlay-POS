import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/routing/routers.dart';
import 'package:pos/features/checkout/logic/cubit/checkout_cubit.dart';
import 'package:pos/features/checkout/ui/checkout_screen.dart';
import 'package:pos/features/home/data/models/cart_model_response.dart';
import 'package:pos/features/home/logic/cubit/home_cubit.dart';
import 'package:pos/features/home/logic/cubit/navigation_cubit.dart';
import 'package:pos/features/home/ui/home_screen.dart';
import 'package:pos/features/home/ui/nav_bar.dart' hide NavigationBar;
import 'package:pos/features/login/logic/cubit/login_cubit.dart';
import 'package:pos/features/login/ui/login_screen.dart';
import 'package:pos/features/terminal/logic/cubit/terminal_cubit.dart';
import 'package:pos/features/terminal/ui/terminal_selection_screen.dart';
import 'package:pos/features/terminal/ui/reader_selection_screen.dart';

import '../di/dependency_injection.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routers.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routers.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: const HomeScreen(),
          ),
        );
      case Routers.navigationBar:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => NavigationCubit(),
            child: NavigationBarApp(),
          ),
        );

      case Routers.terminalSelection:
        final deviceId = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<TerminalCubit>(),
            child: TerminalSelectionScreen(deviceId: deviceId),
          ),
        );

      case Routers.readerSelection:
        // Use provided locationId or default to the registered Stripe location
        final locationId =
            settings.arguments as String? ?? 'tml_GXZzIwIyrIFZYi';
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<TerminalCubit>(),
            child: ReaderSelectionScreen(locationId: locationId),
          ),
        );

      case Routers.checkoutScreen:
        final cartData = settings.arguments as CartData?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = getIt<CheckoutCubit>();
              if (cartData != null) {
                cubit.setCartData(cartData);
              }
              return cubit;
            },
            child: const CheckoutScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
