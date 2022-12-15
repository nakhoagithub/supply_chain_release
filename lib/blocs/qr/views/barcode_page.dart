import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:supply_chain/blocs/qr/bloc/barcode_event.dart';
import 'package:supply_chain/enum.dart';

import '../bloc/barcode_bloc.dart';
import '../bloc/barcode_state.dart';

class BarcodePage extends StatelessWidget {
  const BarcodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BarcodeBloc()..add(BarcodeInitialEvent()),
      child: const _BarcodeView(),
    );
  }
}

class _BarcodeView extends StatelessWidget {
  const _BarcodeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarcodeBloc, BarcodeState>(
      bloc: BlocProvider.of<BarcodeBloc>(context),
      buildWhen: (previous, current) =>
          previous.barcodeStatus != current.barcodeStatus,
      builder: (context, state) {
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
                    state.barcodeStatus == BarcodeStatus.permissionFailure
                        ? Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: Center(
                              child: Column(
                                children: const [
                                  Text(
                                    "Vui lòng cấp quyền truy cập máy ảnh và bộ nhớ.",
                                  ),
                                  _ButtonRequestPermission(),
                                ],
                              ),
                            ),
                          )
                        : const _BarcodeScan(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
            "Quét mã barcode",
            style: TextStyle(fontSize: 26, color: Colors.black87),
          ),
          const Text(
            "Quét mã barcode để xác nhận sản phẩm trong chuỗi",
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _ButtonRequestPermission extends StatefulWidget {
  const _ButtonRequestPermission();

  @override
  State<_ButtonRequestPermission> createState() =>
      _ButtonRequestPermissionState();
}

class _ButtonRequestPermissionState extends State<_ButtonRequestPermission> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: RoundedLoadingButton(
        height: 40,
        width: 150,
        color: Colors.indigo,
        successColor: Colors.green.shade700,
        borderRadius: 10,
        duration: const Duration(seconds: 1),
        controller: _buttonController,
        onPressed: () {
          context.read<BarcodeBloc>().add(BarcodeInitialEvent());
        },
        child: const Text("Cấp quyền",
            style: TextStyle(color: Colors.white, fontSize: 14)),
      ),
    );
  }
}

class _BarcodeScan extends StatefulWidget {
  const _BarcodeScan();

  @override
  State<_BarcodeScan> createState() => __BarcodeScanState();
}

class __BarcodeScanState extends State<_BarcodeScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  bool viewResumeCamera = false;

  void _toSuccessPage(String? barcode) async {
    final result = await Navigator.of(context)
        .pushNamed<dynamic>("/scan_barcode_success", arguments: barcode);
    if (result == "SUCCESS") {
      if (mounted) {
        Navigator.of(context).pop("SUCCESS");
      }
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      _toSuccessPage(scanData.code);
      _viewResumeCamera();
    });
  }

  void _viewResumeCamera() {
    if (mounted) {
      setState(() {
        viewResumeCamera = true;
      });
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: 300,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            !viewResumeCamera
                ? Container()
                : Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: TextButton(
                      onPressed: () {
                        controller?.resumeCamera();
                      },
                      child: const Text("Quét lại"),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
