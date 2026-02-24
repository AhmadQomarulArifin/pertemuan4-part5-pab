// lib/pages/product_list_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cart_model.dart';
import 'cart_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  String searchQuery = "";
  String selectedCategory = "All";

  String formatRupiah(double price) {
    return "Rp ${price.toStringAsFixed(0)}";
  }

  @override
  Widget build(BuildContext context) {

    final products = [
      Product(
        id: '1',
        name: 'Laptop Gaming',
        price: 15000000,
        emoji: '💻',
        description: 'Laptop gaming performa tinggi',
        category: 'Electronics',
      ),
      Product(
        id: '2',
        name: 'Smartphone Pro',
        price: 8000000,
        emoji: '📱',
        description: 'Smartphone flagship terbaru',
        category: 'Electronics',
      ),
      Product(
        id: '3',
        name: 'Wireless Headphones',
        price: 1500000,
        emoji: '🎧',
        description: 'Headphones noise-cancelling',
        category: 'Accessories',
      ),
      Product(
        id: '4',
        name: 'Smart Watch',
        price: 3000000,
        emoji: '⌚',
        description: 'Smartwatch dengan health tracking',
        category: 'Accessories',
      ),
      Product(
        id: '5',
        name: 'Camera DSLR',
        price: 12000000,
        emoji: '📷',
        description: 'Kamera DSLR profesional',
        category: 'Electronics',
      ),
      Product(
        id: '6',
        name: 'Tablet Pro',
        price: 7000000,
        emoji: '📟',
        description: 'Tablet untuk produktivitas',
        category: 'Electronics',
      ),
    ];

    final filteredProducts = products.where((product) {
      final matchesSearch =
          product.name.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory =
          selectedCategory == "All" || product.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                  ),
                  if (cart.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${cart.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: Column(
        children: [

          // 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search product...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          // 🏷 CATEGORY FILTER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonFormField<String>(
              value: selectedCategory,
              items: ["All", "Electronics", "Accessories"]
                  .map(
                    (cat) => DropdownMenuItem(
                      value: cat,
                      child: Text(cat),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];

                return Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(product.name),
                                content: Text(product.description),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Close"),
                                  )
                                ],
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.deepPurple.shade50,
                            child: Center(
                              child: Text(
                                product.emoji,
                                style: const TextStyle(fontSize: 64),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              formatRupiah(product.price),
                              style: TextStyle(
                                color: Colors.green[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  context.read<CartModel>().addItem(product);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${product.name} ditambahkan ke cart!'),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.add_shopping_cart, size: 16),
                                label: const Text('Add',
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}