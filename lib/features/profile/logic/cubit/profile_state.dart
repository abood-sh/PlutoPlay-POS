import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/core/networking/api_error_model.dart';
import 'package:pos/features/printer/data/models/printer_model.dart';
import 'package:pos/features/profile/data/models/profile_response.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = ProfileInitial;
  const factory ProfileState.loading() = ProfileLoading;
  const factory ProfileState.success({
    required ProfileData profileData,
    PrinterModel? selectedPrinter,
  }) = ProfileSuccess;
  const factory ProfileState.error(ApiErrorModel error) = ProfileError;
  const factory ProfileState.loggingOut() = ProfileLoggingOut;
  const factory ProfileState.logoutSuccess() = ProfileLogoutSuccess;
  const factory ProfileState.printerUpdated(PrinterModel printer) =
      ProfilePrinterUpdated;
}
