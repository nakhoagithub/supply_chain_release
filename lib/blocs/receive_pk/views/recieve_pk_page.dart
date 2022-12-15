import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:supply_chain/blocs/receive_pk/bloc/receive_pk_bloc.dart';
import 'package:supply_chain/blocs/receive_pk/bloc/receive_pk_event.dart';
import 'package:supply_chain/blocs/receive_pk/bloc/receive_pk_state.dart';

class ReceivePKPage extends StatelessWidget {
  const ReceivePKPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
        create: (context) {
          return ReceivePKBloc()..add(ReceivePKInit());
        },
        child: const _ReceivePKView(),
      )),
    );
  }
}

class _ReceivePKView extends StatelessWidget {
  const _ReceivePKView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const _TitleReceivePrivateKey(),
              const _ViewPrivateKey(),
              const _TextShowPrivateKey(),
              const _NotePrivateKey(),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    _ButtonCopyPrivateKey(),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}


class _TitleReceivePrivateKey extends StatelessWidget {
  const _TitleReceivePrivateKey({Key? key}) : super(key: key);

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
            "Nhận Private Key",
            style: TextStyle(fontSize: 26, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

class _ViewPrivateKey extends StatefulWidget {
  const _ViewPrivateKey({Key? key}) : super(key: key);

  @override
  State<_ViewPrivateKey> createState() => _ViewPrivateKeyState();
}

class _ViewPrivateKeyState extends State<_ViewPrivateKey> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceivePKBloc, ReceivePKState>(
      builder: (context, state) => Container(
        margin: const EdgeInsets.only(top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                  text: const TextSpan(children: [
                TextSpan(
                    text: "Private Key",
                    style: TextStyle(fontSize: 18, color: Colors.black))
              ])),
            ),
            ClipRRect(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(6)),
                    width: double.infinity,
                    child: Text("${state.privateKey}\n\n\n",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                  Positioned.fill(
                      child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: !state.privateKeyVisibilityStatus ? 5 : 0,
                        sigmaY: !state.privateKeyVisibilityStatus ? 5 : 0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.transparent),
                      child: state.privateKeyVisibilityStatus
                          ? null
                          : Center(
                              child: Icon(
                              Icons.visibility_off,
                              color: Colors.black.withOpacity(0.6),
                            )),
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextShowPrivateKey extends StatefulWidget {
  const _TextShowPrivateKey({Key? key}) : super(key: key);

  @override
  State<_TextShowPrivateKey> createState() => _TextShowPrivateKeyState();
}

class _TextShowPrivateKeyState extends State<_TextShowPrivateKey> {
  bool _isVisibilityPrivateKey = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceivePKBloc, ReceivePKState>(
      buildWhen: (previous, current) =>
          previous.privateKeyVisibilityStatus != current.privateKeyVisibilityStatus,
      builder: (context, state) => Container(
        margin: const EdgeInsets.only(top: 10),
        child: Center(
            child: InkWell(
                onTap: () {
                  _isVisibilityPrivateKey = !_isVisibilityPrivateKey;
                  context.read<ReceivePKBloc>().add(ReceivePKVisiblePrivateKey(visibility: _isVisibilityPrivateKey));
                },
                child: Text(
                  state.privateKeyVisibilityStatus
                      ? "Ẩn thị Private Key"
                      : "Hiển thị Private Key",
                  style: const TextStyle(color: Colors.blue),
                ))),
      ),
    );
  }
}

class _NotePrivateKey extends StatelessWidget {
  const _NotePrivateKey({Key? key}) : super(key: key);

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
                    "Đây là địa chỉ riêng vui lòng lưu trữ nó và không được tiết lộ cho người khác biết",
                style: TextStyle(fontSize: 14)),
          ])),
        ],
      ),
    );
  }
}

class _ButtonCopyPrivateKey extends StatefulWidget {
  const _ButtonCopyPrivateKey({Key? key}) : super(key: key);

  @override
  State<_ButtonCopyPrivateKey> createState() => _ButtonCopyPrivateKeyState();
}

class _ButtonCopyPrivateKeyState extends State<_ButtonCopyPrivateKey> {
  final RoundedLoadingButtonController _controller =
      RoundedLoadingButtonController();

  void _onPress() {
    context.read<ReceivePKBloc>().add(ReceivePKCopy());
    _controller.success();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceivePKBloc, ReceivePKState>(
      builder: (context, state) => Container(
        margin: const EdgeInsets.all(5),
        child: RoundedLoadingButton(
          controller: _controller,
          height: 40,
          width: 150,
          color: Colors.cyan[800],
          successColor: Colors.green,
          borderRadius: 10,
          onPressed: _onPress,
          child: const Text("Copy Private Key",
              style: TextStyle(color: Colors.white, fontSize: 14)),
        ),
      ),
    );
  }
}