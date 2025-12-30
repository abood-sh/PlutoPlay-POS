import 'package:pos/core/helpers/shared_pref_helper.dart';
import 'package:pos/features/printer/data/models/printer_model.dart';
import 'dart:convert';

class PrinterService {
  static const String _printerKey = 'selected_printer';

  // Save selected printer
  static Future<void> saveSelectedPrinter(PrinterModel printer) async {
    final printerJson = json.encode(printer.toJson());
    await SharedPrefHelper.setData(_printerKey, printerJson);
  }

  // Get selected printer
  static Future<PrinterModel?> getSelectedPrinter() async {
    final printerJson = await SharedPrefHelper.getString(_printerKey);
    if (printerJson != null && printerJson.isNotEmpty) {
      final printerMap = json.decode(printerJson) as Map<String, dynamic>;
      return PrinterModel.fromJson(printerMap);
    }
    return null;
  }

  // Clear selected printer
  static Future<void> clearSelectedPrinter() async {
    await SharedPrefHelper.removeData(_printerKey);
  }
}
