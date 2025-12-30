import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/features/home/logic/cubit/home_cubit.dart';
import 'package:pos/features/home/logic/cubit/home_state.dart';

class AddRfidBlocListener extends StatelessWidget {
  const AddRfidBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          current is GetCartSuccess || current is AddRfidToCartError,
      listener: (context, state) {
        state.maybeWhen(
          getCartSuccess: (cartData) {
            // Cart refreshed successfully after adding RFID
          },
          addRfidToCartError: (apiErrorModel) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  apiErrorModel.message ?? 'Failed to add item to cart',
                ),
                backgroundColor: Colors.red,
              ),
            );
          },
          orElse: () {},
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
