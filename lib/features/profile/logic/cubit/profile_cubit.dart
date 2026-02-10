import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/helpers/constants.dart';
import 'package:pos/core/helpers/shared_pref_helper.dart';
import 'package:pos/core/networking/api_result.dart';
import 'package:pos/features/printer/data/models/printer_model.dart';
import 'package:pos/features/printer/data/printer_service.dart';
import 'package:pos/features/profile/data/models/profile_response.dart';
import 'package:pos/features/profile/data/repos/profile_repo.dart';
import 'package:pos/features/profile/logic/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;

  ProfileCubit(this._profileRepo) : super(const ProfileState.initial());

  ProfileData? _cachedProfileData;
  PrinterModel? _cachedPrinter;

  // Expose cached data for UI access during transitional states
  ProfileData? get cachedProfileData => _cachedProfileData;
  PrinterModel? get cachedPrinter => _cachedPrinter;

  void getProfile() async {
    emit(const ProfileState.loading());

    final response = await _profileRepo.getProfile();

    response.when(
      success: (profileResponse) {
        _cachedProfileData = profileResponse.data;
        emit(
          ProfileState.success(
            profileData: profileResponse.data!,
            selectedPrinter: _cachedPrinter,
          ),
        );
      },
      failure: (apiErrorModel) {
        emit(ProfileState.error(apiErrorModel));
      },
    );
  }

  void loadPrinter() async {
    final printer = await PrinterService.getSelectedPrinter();
    _cachedPrinter = printer;

    // If we have profile data, emit success with printer
    if (_cachedProfileData != null) {
      emit(
        ProfileState.success(
          profileData: _cachedProfileData!,
          selectedPrinter: printer,
        ),
      );
    }
  }

  void savePrinter(PrinterModel printer) async {
    await PrinterService.saveSelectedPrinter(printer);
    _cachedPrinter = printer;
    emit(ProfileState.printerUpdated(printer));

    // Return to success state with updated printer
    if (_cachedProfileData != null) {
      emit(
        ProfileState.success(
          profileData: _cachedProfileData!,
          selectedPrinter: printer,
        ),
      );
    }
  }

  void logout() async {
    emit(const ProfileState.loggingOut());

    try {
      // Clear all shared preferences
      await SharedPrefHelper.clearAllData();

      // Clear all secured data (token, terminal data, etc.)
      await SharedPrefHelper.clearAllSecuredData();

      // Reset the global logged in flag
      isLoggedInUser = false;

      emit(const ProfileState.logoutSuccess());
    } catch (e) {
      debugPrint('Logout error: $e');
      // Still emit logout success to allow navigation even if there's an error
      emit(const ProfileState.logoutSuccess());
    }
  }
}
