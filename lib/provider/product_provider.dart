import 'package:assignment/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final productProvider =
    StateNotifierProvider<ProductNotifier, List<ProductModel>>((ref) {
  return ProductNotifier();
});

class ProductNotifier extends StateNotifier<List<ProductModel>> {
  ProductNotifier() : super([]);

  // Fetch all products from Firestore
  Future<void> fetchProducts() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    state =
        snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
  }

  // Add a new product to Firestore
  Future<void> addProduct(ProductModel product) async {
    final docRef = await FirebaseFirestore.instance
        .collection('products')
        .add(product.toMap());
    final newProduct = product.copyWith(qrCodeId: docRef.id);
    state = [...state, newProduct];
  }
}
