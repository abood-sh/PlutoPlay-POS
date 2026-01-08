import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/services/sound_service.dart';
import 'package:pos/features/home/logic/cubit/home_cubit.dart';
import 'package:pos/features/home/logic/cubit/home_state.dart';

class AddRfidBlocListener extends StatelessWidget {
  const AddRfidBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          current is AddRfidToCartSuccess ||
          current is AddRfidToCartError ||
          current is AddCustomItemSuccess ||
          current is AddCustomItemError,
      listener: (context, state) {
        state.maybeWhen(
          addRfidToCartSuccess: (cartData) {
            // RFID added successfully - play success sound
            SoundService().playSuccess();
          },
          addRfidToCartError: (apiErrorModel) {
            // RFID add failed - play error sound
            SoundService().playError();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  apiErrorModel.message ?? 'Failed to add item to cart',
                ),
                backgroundColor: Colors.red,
              ),
            );
          },
          addCustomItemSuccess: (cartData) {
            // Custom item added successfully - play success sound
            SoundService().playSuccess();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Custom item added successfully'),
                backgroundColor: Colors.green,
              ),
            );
          },
          addCustomItemError: (apiErrorModel) {
            // Custom item add failed - play error sound
            SoundService().playError();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  apiErrorModel.message ?? 'Failed to add custom item',
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
