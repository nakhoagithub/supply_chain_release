import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:supply_chain/blocs/history/bloc/history_event.dart';
import 'package:supply_chain/models/history.dart';
import 'package:supply_chain/models/product.dart';
import 'package:supply_chain/widgets/text_html.dart';

import '../bloc/history_bloc.dart';
import '../bloc/history_state.dart';

class HistoryInfoPage extends StatelessWidget {
  const HistoryInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    History arguments = (ModalRoute.of(context)?.settings.arguments) as History;
    return BlocProvider(
      create: (context) => HistoryBloc(),
      child: _HistoryInfoView(history: arguments),
    );
  }
}

class _HistoryInfoView extends StatefulWidget {
  final History history;
  const _HistoryInfoView({
    required this.history,
  });

  @override
  State<_HistoryInfoView> createState() => _HistoryInfoViewState();
}

class _HistoryInfoViewState extends State<_HistoryInfoView> {
  Product? product;

  @override
  void initState() {
    super.initState();
    getProduct(widget.history.addressOwner, widget.history.keyProduct);
  }

  Future<void> getProduct(String address, String idProduct) async {
    DatabaseReference database = FirebaseDatabase.instance.ref();
    final p =
        await database.child('product_view').child('VIEW_$idProduct').get();
    Product pData = Product.fromJson(
        jsonDecode(jsonEncode(p.value)) as Map<String, dynamic>);
    if (mounted) {
      setState(() {
        product = pData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const _Title(),
                _ProductView(product: product),
                _InfoTransfer(history: widget.history),
                widget.history.type == "buy"
                    ? Container()
                    : _GenerateBarcodeImage(history: widget.history),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_rounded)),
          const Text(
            "Thông tin giao dịch",
            style: TextStyle(fontSize: 26, color: Colors.black87),
          ),
          const Text(
            "Các giao dịch đã được xác nhận và vận chuyển tới người mua",
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _ProductView extends StatelessWidget {
  final Product? product;
  const _ProductView({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          product == null
              ? Container(
                  margin: const EdgeInsets.all(20),
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 1),
                  ),
                )
              : product!.linkImage == null || product!.linkImage == ""
                  ? Image.asset(
                      "assets/images/icon_product.png",
                      height: 80,
                      width: 80,
                    )
                  : Image.network(
                      product!.linkImage ?? "",
                      height: 80,
                      width: 80,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/icon_product.png",
                          height: 80,
                          width: 80,
                        );
                      },
                    ),
          product == null
              ? Container()
              : Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    product!.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

class _InfoTransfer extends StatelessWidget {
  final History history;
  const _InfoTransfer({
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   margin: const EdgeInsets.all(5),
        //   child: Row(
        //     children: [
        //       const Expanded(flex: 1, child: Text("ID")),
        //       Expanded(flex: 3, child: Text(history.idHistory)),
        //     ],
        //   ),
        // ),
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 5, left: 5, right: 5),
          child: Row(
            children: [
              const Expanded(flex: 1, child: Text("TX")),
              Expanded(
                flex: 3,
                child: TextHTML(
                  text:
                      '<link blockchain_tx="${history.tx}">${history.tx}</link>',
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Row(
            children: [
              const Expanded(flex: 1, child: Text("Người nhận")),
              Expanded(flex: 3, child: Text(history.addressBuyer)),
            ],
          ),
        ),
        history.type == "buy"
            ? Container()
            : _CreateBarCode(
                history: history,
              ),
      ],
    );
  }
}

class _CreateBarCode extends StatefulWidget {
  final History history;
  const _CreateBarCode({required this.history});

  @override
  State<_CreateBarCode> createState() => _CreateBarCodeState();
}

class _CreateBarCodeState extends State<_CreateBarCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: BarcodeWidget(
          barcode: Barcode.code128(),
          width: 200,
          data: widget.history.idHistory,
        ),
      ),
    );
  }
}

class _GenerateBarcodeImage extends StatefulWidget {
  final History history;
  const _GenerateBarcodeImage({
    required this.history,
  });

  @override
  State<_GenerateBarcodeImage> createState() => _GenerateBarcodeImageState();
}

class _GenerateBarcodeImageState extends State<_GenerateBarcodeImage> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  void _success() async {
    _buttonController.success();
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _error() async {
    _buttonController.error();
    await Future.delayed(const Duration(seconds: 1));
    _buttonController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoryBloc, HistoryState>(
      bloc: BlocProvider.of<HistoryBloc>(context),
      listenWhen: (previous, current) =>
          previous.statusFile != current.statusFile,
      listener: (context, state) {
        switch (state.statusFile) {
          case 0:
            _error();
            break;
          case 1:
            _success();
            break;
          case 2:
            _error();
            break;
          case 3:
            _error();
            break;
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: RoundedLoadingButton(
          height: 40,
          width: 150,
          color: Colors.indigo,
          successColor: Colors.green.shade700,
          borderRadius: 10,
          duration: const Duration(seconds: 1),
          controller: _buttonController,
          onPressed: () {
            context
                .read<HistoryBloc>()
                .add(HistoryCreateBarcodeEvent(data: widget.history.idHistory));
          },
          child: const Text("Tạo ảnh Barcode",
              style: TextStyle(color: Colors.white, fontSize: 14)),
        ),
      ),
    );
  }
}
