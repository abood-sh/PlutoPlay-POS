import 'package:pos/features/printer/data/models/printer_model.dart';

class PrinterConfig {
  static final List<PrinterModel> availablePrinters = [
    // PrinterModel(
    //   name: 'Test Printer (Virtual)',
    //   ip: '127.0.0.1', // localhost for testing
    //   port: 9100,
    //   location: 'Virtual Printer',
    // ),
    PrinterModel(
      name: 'Main Store Counter',
      ip: '10.1.10.151',
      port: 9100,
      location: 'Store 1 - Front Counter',
    ),
    PrinterModel(
      name: 'Counter 2',
      ip: '10.1.10.80',
      port: 9100,
      location: 'Counter 2',
    ),
    PrinterModel(
      name: 'Counter 3',
      ip: '10.1.10.21',
      port: 9100,
      location: 'Counter 3',
    ),
    PrinterModel(
      name: 'Counter 4',
      ip: '10.1.10.215',
      port: 9100,
      location: 'Counter 4',
    ),
  ];
}
