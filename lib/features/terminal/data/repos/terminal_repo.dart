import 'package:pos/core/networking/api_constanta.dart';
import 'package:pos/core/networking/api_error_handler.dart';
import 'package:pos/core/networking/api_result.dart';
import 'package:pos/core/networking/api_service.dart';
import 'package:pos/features/terminal/data/models/terminal_model.dart';

class TerminalRepo {
  final ApiService _apiService;

  TerminalRepo(this._apiService);

  Future<ApiResult<TerminalListResponse>> getTerminals(String deviceId) async {
    try {
      final path = ApiConstanta.listTerminals(deviceId);
      final response = await _apiService.listTerminals(path);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
