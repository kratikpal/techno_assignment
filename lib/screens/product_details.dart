import 'package:assignment/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Price: \$${product.price.toString()}',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 20),
            // Add the QR code section
            QRCodeGenerator(
              qrCodeId: product.qrCodeId!,
            ), // Pass product's id or any identifier
          ],
        ),
      ),
    );
  }
}

class QRCodeGenerator extends StatelessWidget {
  final String qrCodeId;

  const QRCodeGenerator({required this.qrCodeId, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImageView(
        data: qrCodeId, // The unique QR Code ID to encode
        version: QrVersions
            .auto, // Auto-detects the version based on the data length
        size: 200.0, // Set the size of the QR code
        gapless: false, // Set whether there should be a gapless QR code or not
      ),
    );
  }
}
