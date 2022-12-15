import 'package:flutter/material.dart';

class ListCompany extends StatefulWidget {
  const ListCompany({Key? key}) : super(key: key);

  @override
  State<ListCompany> createState() => _ListCompanyState();
}

class _ListCompanyState extends State<ListCompany> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Danh sách công ty thành viên",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: const Center(child: Text("Danh sách công ty thành viên")),
    );
  }
}
