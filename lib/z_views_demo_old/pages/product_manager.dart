import 'package:flutter/material.dart';

class ProductManager extends StatefulWidget {
  const ProductManager({Key? key}) : super(key: key);

  @override
  State<ProductManager> createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quản lý Sản Phẩm",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: const Center(child: Text("Quản lý sản phẩm")),
    );
  }
}
