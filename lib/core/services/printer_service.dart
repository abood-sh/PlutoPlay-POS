import 'package:esc_pos_printer_plus/esc_pos_printer_plus.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:pos/features/checkout/data/models/process_payment_response.dart';
import 'package:pos/features/printer/data/printer_service.dart'
    as printer_storage;

class PrinterService {
  // Print invoice
  static Future<Map<String, dynamic>> printInvoice({
    required List<Map<String, dynamic>> items,
    required double subtotal,
    required double tax,
    required double discount,
    required double total,
    String? customerName,
  }) async {
    try {
      // Get selected printer
      final printer = await printer_storage.PrinterService.getSelectedPrinter();
      if (printer == null) {
        return {
          'success': false,
          'message': 'No printer selected. Please link a printer first.',
        };
      }

      // Create capability profile
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm80, profile);

      // Build ticket
      List<int> bytes = [];

      // Header
      bytes += generator.text(
        'PlutoPay POS',
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
          bold: true,
        ),
      );
      bytes += generator.text(
        printer.location,
        styles: const PosStyles(align: PosAlign.center),
      );
      bytes += generator.text(
        'Date: ${DateTime.now().toString().substring(0, 16)}',
        styles: const PosStyles(align: PosAlign.center),
      );
      bytes += generator.hr();
      bytes += generator.emptyLines(1);

      // Customer info
      if (customerName != null && customerName.isNotEmpty) {
        bytes += generator.text('Customer: $customerName');
        bytes += generator.emptyLines(1);
      }

      // Items header
      bytes += generator.text('ITEMS', styles: const PosStyles(bold: true));
      bytes += generator.hr();

      // Print items
      for (var item in items) {
        bytes += generator.row([
          PosColumn(
            text: item['name'] ?? '',
            width: 6,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: 'x${item['quantity'] ?? 0}',
            width: 2,
            styles: const PosStyles(align: PosAlign.center),
          ),
          PosColumn(
            text: '\$${item['subtotal'] ?? '0.00'}',
            width: 4,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);
      }

      bytes += generator.hr();
      bytes += generator.emptyLines(1);

      // Totals
      bytes += generator.row([
        PosColumn(text: 'Subtotal:', width: 6),
        PosColumn(
          text: '\$${subtotal.toStringAsFixed(2)}',
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);

      if (discount > 0) {
        bytes += generator.row([
          PosColumn(text: 'Discount:', width: 6),
          PosColumn(
            text: '-\$${discount.toStringAsFixed(2)}',
            width: 6,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);
      }

      bytes += generator.row([
        PosColumn(text: 'Tax:', width: 6),
        PosColumn(
          text: '\$${tax.toStringAsFixed(2)}',
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);

      bytes += generator.hr();

      // Total
      bytes += generator.row([
        PosColumn(
          text: 'TOTAL:',
          width: 6,
          styles: const PosStyles(bold: true, height: PosTextSize.size2),
        ),
        PosColumn(
          text: '\$${total.toStringAsFixed(2)}',
          width: 6,
          styles: const PosStyles(
            align: PosAlign.right,
            bold: true,
            height: PosTextSize.size2,
          ),
        ),
      ]);

      bytes += generator.emptyLines(2);
      bytes += generator.text(
        'Thank you for your business!',
        styles: const PosStyles(align: PosAlign.center),
      );
      bytes += generator.emptyLines(1);
      bytes += generator.cut();

      // Connect and print
      final networkPrinter = NetworkPrinter(PaperSize.mm80, profile);

      final result = await networkPrinter.connect(
        printer.ip,
        port: printer.port,
        timeout: const Duration(seconds: 5),
      );

      if (result == PosPrintResult.success) {
        networkPrinter.rawBytes(bytes);
        networkPrinter.disconnect();
        return {'success': true, 'message': 'Invoice printed successfully'};
      } else {
        return {
          'success': false,
          'message': 'Failed to connect to printer at ${printer.ip}',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Print error: ${e.toString()}'};
    }
  }

  // Print order invoice after payment success
  static Future<Map<String, dynamic>> printOrderInvoice({
    required PaymentResponseData paymentData,
    List<Map<String, dynamic>>? cartItems,
  }) async {
    try {
      final printer = await printer_storage.PrinterService.getSelectedPrinter();
      if (printer == null) {
        return {
          'success': false,
          'message': 'No printer selected. Please link a printer first.',
        };
      }

      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm80, profile);

      List<int> bytes = [];
      final order = paymentData.order;

      // Store Header
      bytes += generator.text(
        order?.store?.name ?? 'HOME TRENDS OUTLET',
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
          bold: true,
        ),
      );
      bytes += generator.emptyLines(1);
      bytes += generator.text(
        'by PlutoPay',
        styles: const PosStyles(align: PosAlign.center),
      );
      bytes += generator.hr();

      // Order Info
      bytes += generator.text(
        'Order #: ${order?.orderNumber ?? 'N/A'}',
        styles: const PosStyles(align: PosAlign.left),
      );
      bytes += generator.text(
        'Date: ${order?.orderDate ?? DateTime.now().toString().substring(0, 16)}',
        styles: const PosStyles(align: PosAlign.left),
      );
      bytes += generator.hr();

      // Items
      bytes += generator.text('ITEMS:', styles: const PosStyles(bold: true));
      bytes += generator.emptyLines(1);

      if (cartItems != null && cartItems.isNotEmpty) {
        for (var item in cartItems) {
          final name = item['name'] ?? 'Unknown';
          final qty = item['quantity'] ?? 1;
          final subtotal = item['subtotal'] ?? 0.0;

          bytes += generator.text(name);
          bytes += generator.text(
            '  $qty x \$${(subtotal / qty).toStringAsFixed(2)} = \$${subtotal.toStringAsFixed(2)}',
          );
        }
      } else {
        bytes += generator.text('${order?.itemsCount ?? 0} item(s)');
      }

      bytes += generator.hr();

      // Totals - Right aligned
      final subtotal = double.tryParse(order?.subtotal ?? '0') ?? 0;
      final discount = double.tryParse(order?.discount ?? '0') ?? 0;
      final tax = order?.taxAmount is num
          ? (order?.taxAmount as num).toDouble()
          : double.tryParse(order?.taxAmount?.toString() ?? '0') ?? 0;
      final total = double.tryParse(order?.total ?? '0') ?? 0;

      bytes += generator.row([
        PosColumn(text: 'Subtotal:', width: 6),
        PosColumn(
          text: '\$${subtotal.toStringAsFixed(2)}',
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);

      if (discount > 0) {
        bytes += generator.row([
          PosColumn(text: 'Discount:', width: 6),
          PosColumn(
            text: '-\$${discount.toStringAsFixed(2)}',
            width: 6,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);
      }

      bytes += generator.row([
        PosColumn(text: 'Tax:', width: 6),
        PosColumn(
          text: '\$${tax.toStringAsFixed(2)}',
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);

      bytes += generator.emptyLines(1);

      // Total
      bytes += generator.row([
        PosColumn(
          text: 'TOTAL:',
          width: 6,
          styles: const PosStyles(bold: true, height: PosTextSize.size2),
        ),
        PosColumn(
          text: '\$${total.toStringAsFixed(2)}',
          width: 6,
          styles: const PosStyles(
            align: PosAlign.right,
            bold: true,
            height: PosTextSize.size2,
          ),
        ),
      ]);

      bytes += generator.hr();

      // Payment Info
      if (order?.payments != null && order!.payments!.isNotEmpty) {
        for (var payment in order.payments!) {
          bytes += generator.text(
            'Payment: ${payment.paymentMethod?.toUpperCase() ?? 'N/A'}',
          );
        }
      } else {
        bytes += generator.text(
          'Payment: ${paymentData.paymentMethod?.toUpperCase() ?? 'N/A'}',
        );
      }
      bytes += generator.text(
        'Status: ${order?.paymentStatus?.toUpperCase() ?? 'PAID'}',
      );

      bytes += generator.hr();

      // Order barcode
      bytes += generator.emptyLines(1);
      bytes += generator.text(
        order?.orderNumber ?? '',
        styles: const PosStyles(align: PosAlign.center),
      );
      final barcodeData =
          order?.orderNumber?.replaceAll('ORD-', '') ?? '000000';
      bytes += generator.barcode(
        Barcode.code128(barcodeData.codeUnits),
        height: 60,
      );

      bytes += generator.emptyLines(1);

      // Footer
      bytes += generator.text(
        'THANK YOU!',
        styles: const PosStyles(
          align: PosAlign.center,
          bold: true,
          height: PosTextSize.size2,
        ),
      );
      bytes += generator.text(
        'Visit us again!',
        styles: const PosStyles(align: PosAlign.center),
      );
      bytes += generator.hr();
      bytes += generator.text(
        'Powered by PlutoPay',
        styles: const PosStyles(align: PosAlign.center),
      );
      bytes += generator.text(
        'www.plutopayus.com',
        styles: const PosStyles(align: PosAlign.center),
      );
      bytes += generator.emptyLines(2);
      bytes += generator.cut();

      // Connect and print
      final networkPrinter = NetworkPrinter(PaperSize.mm80, profile);

      final result = await networkPrinter.connect(
        printer.ip,
        port: printer.port,
        timeout: const Duration(seconds: 5),
      );

      if (result == PosPrintResult.success) {
        networkPrinter.rawBytes(bytes);
        networkPrinter.disconnect();
        return {'success': true, 'message': 'Receipt printed successfully'};
      } else {
        return {
          'success': false,
          'message': 'Failed to connect to printer at ${printer.ip}',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Print error: ${e.toString()}'};
    }
  }

  // Test print
  static Future<Map<String, dynamic>> testPrint() async {
    try {
      final printer = await printer_storage.PrinterService.getSelectedPrinter();
      if (printer == null) {
        return {
          'success': false,
          'message': 'No printer selected. Please link a printer first.',
        };
      }

      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm80, profile);

      List<int> bytes = [];
      bytes += generator.text(
        'TEST PRINT',
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
          bold: true,
        ),
      );
      bytes += generator.emptyLines(1);
      bytes += generator.text(
        'Printer: ${printer.name}',
        styles: const PosStyles(align: PosAlign.center),
      );
      bytes += generator.text(
        'Location: ${printer.location}',
        styles: const PosStyles(align: PosAlign.center),
      );
      bytes += generator.text(
        'IP: ${printer.ip}:${printer.port}',
        styles: const PosStyles(align: PosAlign.center),
      );
      bytes += generator.emptyLines(1);
      bytes += generator.text(
        'Date: ${DateTime.now()}',
        styles: const PosStyles(align: PosAlign.center),
      );
      bytes += generator.emptyLines(2);
      bytes += generator.text(
        'Test successful!',
        styles: const PosStyles(align: PosAlign.center, bold: true),
      );
      bytes += generator.emptyLines(1);
      bytes += generator.cut();

      final networkPrinter = NetworkPrinter(PaperSize.mm80, profile);

      final result = await networkPrinter.connect(
        printer.ip,
        port: printer.port,
        timeout: const Duration(seconds: 5),
      );

      if (result == PosPrintResult.success) {
        networkPrinter.rawBytes(bytes);
        networkPrinter.disconnect();
        return {'success': true, 'message': 'Test print successful'};
      } else {
        return {
          'success': false,
          'message': 'Failed to connect to printer at ${printer.ip}',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Print error: ${e.toString()}'};
    }
  }
}
