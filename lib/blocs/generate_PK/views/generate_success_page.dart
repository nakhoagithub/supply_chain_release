import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:supply_chain/blocs/generate_PK/blocs/generate_bloc.dart';
import 'package:supply_chain/blocs/generate_PK/blocs/generate_event.dart';
import 'package:supply_chain/blocs/generate_PK/blocs/generate_state.dart';

class GenerateSuccessPage extends StatelessWidget {
  const GenerateSuccessPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (context) => const GenerateSuccessPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
        create: (context) {
          return GeneratePKBloc()..add(const GeneratePageSuccess());
        },
        child: const _GenerateSuccessPage(),
      )),
    );
  }
}

class _GenerateSuccessPage extends StatelessWidget {
  const _GenerateSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const _TitleGenerateSuccess(),
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
                    _ButtonReturnLoginPage(),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}

class _TitleGenerateSuccess extends StatelessWidget {
  const _TitleGenerateSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Thành công",
            style: TextStyle(fontSize: 26, color: Colors.black87),
          ),
          Text(
            "Đã tạo Private Key thành công",
            style: TextStyle(fontSize: 15, color: Colors.black54),
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
    return BlocBuilder<GeneratePKBloc, GeneratePKState>(
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
                        sigmaX: !state.privateKeyStatusVisible ? 5 : 0,
                        sigmaY: !state.privateKeyStatusVisible ? 5 : 0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.transparent),
                      child: state.privateKeyStatusVisible
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
    return BlocBuilder<GeneratePKBloc, GeneratePKState>(
      buildWhen: (previous, current) =>
          previous.privateKeyStatusVisible != current.privateKeyStatusVisible,
      builder: (context, state) => Container(
        margin: const EdgeInsets.only(top: 10),
        child: Center(
            child: InkWell(
                onTap: () {
                  _isVisibilityPrivateKey = !_isVisibilityPrivateKey;
                  context.read<GeneratePKBloc>().add(GenerateVisiblePrivateKey(
                      visibility: _isVisibilityPrivateKey));
                },
                child: Text(
                  state.privateKeyStatusVisible
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
    context.read<GeneratePKBloc>().add(const GenerateCopyPrivateKey());
    _controller.success();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneratePKBloc, GeneratePKState>(
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

class _ButtonReturnLoginPage extends StatefulWidget {
  const _ButtonReturnLoginPage({Key? key}) : super(key: key);

  @override
  State<_ButtonReturnLoginPage> createState() => _ButtonReturnLoginPageState();
}

class _ButtonReturnLoginPageState extends State<_ButtonReturnLoginPage> {
  final RoundedLoadingButtonController _controller =
      RoundedLoadingButtonController();

  void _onPressed(String? privateKey) async {
    Navigator.of(context).pop(privateKey);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneratePKBloc, GeneratePKState>(
      builder: (context, state) => Container(
        margin: const EdgeInsets.all(5),
        child: RoundedLoadingButton(
          controller: _controller,
          height: 40,
          width: 150,
          color: Colors.green[800],
          borderRadius: 10,
          onPressed: () => _onPressed(state.privateKey),
          child: const Text("Quay về đăng nhập",
              style: TextStyle(color: Colors.white, fontSize: 14)),
        ),
      ),
    );
  }
}
