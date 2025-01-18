import 'package:assignment/provider/cart_provider.dart';
import 'package:assignment/screens/product_details.dart';
import 'package:assignment/widgets/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QrCodeScanner(),
                ),
              );
            },
          ),
        ],
        title: const Text('Cart'),
      ),
      body: cart.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(
                          product: product,
                        ),
                      ),
                    );
                  },
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: Text('\$${product.price}'),
                );
              },
            ),
    );
  }
}
