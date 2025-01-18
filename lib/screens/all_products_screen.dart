import 'package:assignment/provider/product_provider.dart';
import 'package:assignment/screens/add_product_screen.dart';
import 'package:assignment/screens/cart_screen.dart';
import 'package:assignment/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllProductsScreen extends ConsumerStatefulWidget {
  const AllProductsScreen({super.key});

  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends ConsumerState<AllProductsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch products when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productProvider.notifier).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    return Scaffold(
      appBar: AppBar(title: Text('All Products'), actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CartScreen();
            }));
          },
        ),
      ]),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductScreen()),
          );
        },
      ),
    );
  }
}
