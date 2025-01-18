import 'package:assignment/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QrCodeScanner extends ConsumerStatefulWidget {
  const QrCodeScanner({super.key});

  @override
  ConsumerState<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends ConsumerState<QrCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: (QRViewController controller) {
          this.controller = controller;
          controller.scannedDataStream.listen((event) async {
            controller.pauseCamera();
            // Extract the scanned QR code value (which is expected to be the product ID)
            String qrCodeId = event.code ?? '';

            if (qrCodeId.isNotEmpty) {
              // Fetch the product using the cart provider
              await ref.read(cartProvider.notifier).fetchProduct(qrCodeId);
              // Navigate back after fetching the product
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Product added to cart!'),
                ),
              );
              Navigator.pop(context);
            }
          });
        },
      ),
    );
  }
}
