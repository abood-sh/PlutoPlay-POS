import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/di/dependency_injection.dart';
import 'package:pos/core/theming/colors.dart';
import 'package:pos/features/home/logic/cubit/home_cubit.dart';
import 'package:pos/features/home/logic/cubit/navigation_cubit.dart';
import 'package:pos/features/home/ui/home_screen.dart';
import 'package:pos/features/last_transaction/last_transaction_page.dart';
import 'package:pos/features/profile/profile_page.dart';
import 'package:pos/features/refund/refund_page.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            context.read<NavigationCubit>().changeTab(index);
          },
          //  type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorsManager.mainBlue,
          unselectedItemColor: ColorsManager.gray,
          // selectedLabelStyle: TextStyles.font12DarkBlueRegular,
          // unselectedLabelStyle: TextStyles.font12GrayRegular,
          iconSize: 100.sp,

          // selectedFontSize: 200.sp,
          // unselectedFontSize: 10.sp,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.refresh), label: 'Refund'),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Last Transaction',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      },
    );
  }
}

final List<Widget> pages = [
  BlocProvider(
    create: (context) => getIt<HomeCubit>()..getCart(),
    child: const HomeScreen(),
  ),
  const RefundPage(),
  const LastTransactionPage(),
  const ProfilePage(),
];
String getTitle(int index) {
  switch (index) {
    case 0:
      return 'POS System';
    case 1:
      return 'Refund';
    case 2:
      return 'Last Transaction';
    case 3:
      return 'Profile';
    default:
      return 'POS System';
  }
}
