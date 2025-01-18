import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String name;
  final String description;
  final double price;
  final String? qrCodeId;

  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    this.qrCodeId,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      qrCodeId: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? 0.0,
    );
  }

  // Convert Product object to Firestore document format
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
    };
  }

  // CopyWith method to create a new instance with modified values
  ProductModel copyWith({
    String? name,
    String? description,
    double? price,
    String? qrCodeId,
  }) {
    return ProductModel(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      qrCodeId: qrCodeId ?? this.qrCodeId,
    );
  }
}
