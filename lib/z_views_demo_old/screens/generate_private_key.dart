import 'package:flutter/material.dart';

class GeneratePrivateKey extends StatefulWidget {
  const GeneratePrivateKey({Key? key}) : super(key: key);

  @override
  State<GeneratePrivateKey> createState() => _GeneratePrivateKeyState();
}

class _GeneratePrivateKeyState extends State<GeneratePrivateKey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_rounded)),
              const Text(
                "Khởi tạo Private key",
                style: TextStyle(fontSize: 26, color: Colors.black87),
              ),
              const Text(
                "Khởi tạo Private Key cho công ty",
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Tên công ty",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[350],
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey[350]!.withOpacity(1)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey[350]!.withOpacity(1)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Email công ty",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[350],
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey[350]!.withOpacity(1)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey[350]!.withOpacity(1)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Địa chỉ công ty",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[350],
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey[350]!.withOpacity(1)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey[350]!.withOpacity(1)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.indigo[700]),
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          left: 25, right: 25, bottom: 12, top: 12)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ))),
                  child: const Text("Khởi tạo",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
