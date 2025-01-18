import 'package:assignment/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, List<ProductModel>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<ProductModel>> {
  CartNotifier() : super([]);

  // fetch a product usin id
  Future<void> fetchProduct(String qrCodeId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('products')
        .doc(qrCodeId)
        .get();
    final product = ProductModel.fromFirestore(snapshot);
    state = [...state, product];
  }
}
