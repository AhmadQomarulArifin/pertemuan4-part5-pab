// lib/pages/checkout_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String phone = "";
  String email = "";
  String address = "";
  String city = "";
  String postalCode = "";
  String paymentMethod = "Transfer Bank";
  String shippingMethod = "Regular";
  String note = "";

  double getShippingCost() {
    if (shippingMethod == "Express") return 50000;
    return 20000;
  }

  String formatRupiah(double price) {
    return "Rp ${price.toStringAsFixed(0)}";
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    final shippingCost = getShippingCost();
    final grandTotal = cart.totalPrice + shippingCost;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: cart.isEmpty
          ? const Center(
              child: Text(
                "Cart is empty",
                style: TextStyle(fontSize: 18),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  // ============================
                  // ORDER SUMMARY
                  // ============================
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Order Summary",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),

                          ...cart.itemsList.map(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${item.product.name} x${item.quantity}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(formatRupiah(item.totalPrice)),
                                ],
                              ),
                            ),
                          ),

                          const Divider(),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Subtotal"),
                              Text(formatRupiah(cart.totalPrice)),
                            ],
                          ),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Shipping"),
                              Text(formatRupiah(shippingCost)),
                            ],
                          ),

                          const SizedBox(height: 8),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Grand Total",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                formatRupiah(grandTotal),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ============================
                  // CUSTOMER FORM
                  // ============================
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Full Name",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? "Name required" : null,
                          onSaved: (value) => name = value!,
                        ),

                        const SizedBox(height: 12),

                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Phone Number",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) =>
                              value!.isEmpty ? "Phone required" : null,
                          onSaved: (value) => phone = value!,
                        ),

                        const SizedBox(height: 12),

                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              value!.isEmpty ? "Email required" : null,
                          onSaved: (value) => email = value!,
                        ),

                        const SizedBox(height: 12),

                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Full Address",
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                          validator: (value) =>
                              value!.isEmpty ? "Address required" : null,
                          onSaved: (value) => address = value!,
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: "City",
                                  border: OutlineInputBorder(),
                                ),
                                onSaved: (value) => city = value!,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: "Postal Code",
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType:
                                    TextInputType.number,
                                onSaved: (value) =>
                                    postalCode = value!,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // ============================
                        // PAYMENT METHOD
                        // ============================
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Payment Method",
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        RadioListTile(
                          value: "Transfer Bank",
                          groupValue: paymentMethod,
                          onChanged: (value) {
                            setState(() =>
                                paymentMethod = value.toString());
                          },
                          title: const Text("Transfer Bank"),
                        ),

                        RadioListTile(
                          value: "E-Wallet",
                          groupValue: paymentMethod,
                          onChanged: (value) {
                            setState(() =>
                                paymentMethod = value.toString());
                          },
                          title: const Text("E-Wallet"),
                        ),

                        RadioListTile(
                          value: "COD",
                          groupValue: paymentMethod,
                          onChanged: (value) {
                            setState(() =>
                                paymentMethod = value.toString());
                          },
                          title: const Text("Cash On Delivery"),
                        ),

                        const SizedBox(height: 10),

                        DropdownButtonFormField(
                          value: shippingMethod,
                          items: const [
                            DropdownMenuItem(
                              value: "Regular",
                              child:
                                  Text("Regular (Rp 20.000)"),
                            ),
                            DropdownMenuItem(
                              value: "Express",
                              child:
                                  Text("Express (Rp 50.000)"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() =>
                                shippingMethod =
                                    value.toString());
                          },
                          decoration: const InputDecoration(
                            labelText: "Shipping Method",
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 12),

                        TextFormField(
                          decoration: const InputDecoration(
                            labelText:
                                "Order Note (Optional)",
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 2,
                          onSaved: (value) =>
                              note = value ?? "",
                        ),

                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!
                                  .validate()) {
                                _formKey.currentState!
                                    .save();

                                cart.clear();

                                showDialog(
                                  context: context,
                                  builder: (_) =>
                                      AlertDialog(
                                    title: const Text(
                                        "Order Success"),
                                    content: Text(
                                      "Thank you $name!\n\n"
                                      "Payment: $paymentMethod\n"
                                      "Shipping: $shippingMethod\n\n"
                                      "Total: ${formatRupiah(grandTotal)}",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context);
                                          Navigator.pop(
                                              context);
                                        },
                                        child:
                                            const Text("OK"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: const Padding(
                              padding:
                                  EdgeInsets.symmetric(
                                      vertical: 16),
                              child: Text(
                                "Place Order",
                                style:
                                    TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}