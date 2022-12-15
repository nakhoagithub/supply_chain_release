import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:supply_chain/blocs/scan/bloc/scan_bloc.dart';

class ScanSuccess extends StatelessWidget {
  const ScanSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    String? argument = (ModalRoute.of(context)?.settings.arguments) as String?;
    return BlocProvider(
      create: (context) => ScanBloc()..add(ScanInitialEvent()),
      child: _ScanSuccess(
        barcode: argument,
      ),
    );
  }
}

class _ScanSuccess extends StatelessWidget {
  final String? barcode;
  const _ScanSuccess({required this.barcode});

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
                const _Note(),
                _Barcode(
                  barcode: barcode,
                ),
                _ButtonConfirmBarcode(
                  barcode: barcode,
                )
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
            "Quét thành công",
            style: TextStyle(fontSize: 26, color: Colors.black87),
          ),
          const Text(
            "Truy xuất chuỗi cung ứng của sản phẩm.",
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _Note extends StatelessWidget {
  const _Note({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        children: const [
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Lưu ý: ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.red)),
            TextSpan(
                text:
                    "Vui lòng kiểm tra mã đã quét xong phải trùng khớp với số trên mã vạch của sản phẩm",
                style: TextStyle(fontSize: 16)),
          ])),
        ],
      ),
    );
  }
}

class _Barcode extends StatelessWidget {
  final String? barcode;
  const _Barcode({
    required this.barcode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Center(
        child: Text(
          barcode ?? "Rỗng",
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _ButtonConfirmBarcode extends StatefulWidget {
  final String? barcode;
  const _ButtonConfirmBarcode({
    required this.barcode,
  });

  @override
  State<_ButtonConfirmBarcode> createState() => _ButtonRequestPermissionState();
}

class _ButtonRequestPermissionState extends State<_ButtonConfirmBarcode> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  void _resultNull() {
    const snackBar = SnackBar(
      content: Text('Có thể mã vạch của bạn không chính xác'),
      duration: Duration(milliseconds: 1000),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    _buttonController.reset();
  }

  void _listenState(int? result, dynamic dataResult) async {
    switch (result) {
      case 400:
        _resultNull();
        break;
      case 1:
        _buttonController.success();
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          Navigator.of(context).pop(["SUCCESS", dataResult]);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScanBloc, ScanState>(
      listenWhen: (previous, current) =>
          previous.statusResult != current.statusResult,
      bloc: BlocProvider.of<ScanBloc>(context),
      listener: (context, state) {
        _listenState(state.statusResult, state.dataResult);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 100),
        child: RoundedLoadingButton(
          height: 40,
          width: 150,
          color: Colors.indigo,
          successColor: Colors.green.shade700,
          borderRadius: 10,
          duration: const Duration(seconds: 1),
          controller: _buttonController,
          onPressed: () {
            if (widget.barcode != null) {
              context
                  .read<ScanBloc>()
                  .add(ScanSuccessEvent(barcode: widget.barcode));
            }
          },
          child: const Text("Xác nhận",
              style: TextStyle(color: Colors.white, fontSize: 14)),
        ),
      ),
    );
  }
}
