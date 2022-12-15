import 'package:flutter/material.dart';
class ProductHistory extends StatefulWidget {
  const ProductHistory({Key? key}) : super(key: key);

  @override
  State<ProductHistory> createState() => _ProductHistoryState();
}

class _ProductHistoryState extends State<ProductHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lịch sử Sản Phẩm",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: const Center(child: Text("Lịch sử Sản Phẩm")),
    );
  }
}