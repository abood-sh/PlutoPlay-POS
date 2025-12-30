import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/theming/styles.dart';
import 'package:pos/features/home/logic/cubit/navigation_cubit.dart';
import 'package:pos/features/home/ui/widgets/bottom_nav_bar.dart';

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              getTitle(currentIndex),
              style: TextStyles.font18DarkBlueBold,
            ),
          ),
          body: pages[currentIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
