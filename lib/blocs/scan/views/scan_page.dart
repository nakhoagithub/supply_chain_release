import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ScanView();
  }
}

class _ScanView extends StatelessWidget {
  const _ScanView();

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
            "Truy xuất nguồn gốc",
            style: TextStyle(fontSize: 26, color: Colors.black87),
          ),
          const Text(
            "Quét mã vạch in trên sản phẩm để truy xuất nguồn gốc.",
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
          const _BarcodeScan(),
        ],
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
        .pushNamed<dynamic>("/scan_success", arguments: barcode);
    if (result != null && result[0] == "SUCCESS") {
      if (mounted) {
        Navigator.of(context).pushNamed('/supply_chain', arguments: result[1]);
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
