import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:supply_chain/blocs/generate_PK/blocs/generate_bloc.dart';

import '../../../enum.dart';
import '../login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => LoginBloc(),
      ),
      BlocProvider(create: (context) => GeneratePKBloc()),
    ], child: const LoginForm());
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                children: const [
                  _ForUserPage(),
                  _ForCompany(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 20,
        margin: const EdgeInsets.all(10),
        child: Center(
          child: SmoothPageIndicator(
              controller: controller, // PageController
              count: 2,
              effect: const ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 10,
              ), // your preferred effect
              onDotClicked: (index) {}),
        ),
      ),
    );
  }
}

class _ForCompany extends StatelessWidget {
  const _ForCompany();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: const [
                Center(child: _TitleLogin()),
                _PrimaryKeyInput(),
                _ButtonLogin(),
                _TextButtonGeneratePrivateKey()
              ]),
        ),
      ),
    );
  }
}

class _ForUserPage extends StatelessWidget {
  const _ForUserPage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: const [
                _TitleForUser(),
                _ScanForSupplyChain(),
              ]),
        ),
      ),
    );
  }
}

class _ScanForSupplyChain extends StatelessWidget {
  const _ScanForSupplyChain();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.grey[300],
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/scan');
            },
            child: Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Truy xuất chuỗi cung ứng sản phẩm",
                )),
          )),
    );
  }
}

class _TitleForUser extends StatelessWidget {
  const _TitleForUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      child: Column(
        children: const [
          Text(
            "Welcome to Supply Chain",
            style: TextStyle(fontSize: 26, color: Colors.black87),
          ),
          Text(
            "Quét mã vạch để truy xuất nguồn gốc sản phẩm",
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _TitleLogin extends StatelessWidget {
  const _TitleLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      child: Column(
        children: const [
          Text(
            "Welcome to Supply Chain",
            style: TextStyle(fontSize: 26, color: Colors.black87),
          ),
          Text(
            "Sử dụng Private Key để đăng nhập vào hệ thống",
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _PrimaryKeyInput extends StatefulWidget {
  const _PrimaryKeyInput({Key? key}) : super(key: key);

  @override
  State<_PrimaryKeyInput> createState() => _PrimaryKeyInputState();
}

class _PrimaryKeyInputState extends State<_PrimaryKeyInput> {
  bool isInvisibilityPass = true;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.privateKey != current.privateKey ||
          previous.privateKeyFromGeneratePage !=
              current.privateKeyFromGeneratePage,
      builder: (context, state) {
        if (state.privateKeyFromGeneratePage != null &&
            state.privateKey == null) {
          _controller.text = state.privateKeyFromGeneratePage ?? "";
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Private Key",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            TextFormField(
              controller: _controller,
              onChanged: (privateKey) {
                context
                    .read<LoginBloc>()
                    .add(LoginPrivateKeyChange(privateKey: privateKey));
              },
              obscureText: isInvisibilityPass,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[350],
                  suffixIcon: IconButton(
                      icon: Icon(isInvisibilityPass
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () {
                        setState(() {
                          isInvisibilityPass = !isInvisibilityPass;
                        });
                      }),
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey[350]!.withOpacity(1)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey[350]!.withOpacity(1)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  errorText: state.primaryKeyStatus == PrivateKeyStatus.invalid
                      ? "Private Key không hợp lệ!"
                      : null),
            ),
          ],
        );
      },
    );
  }
}

class _ButtonLogin extends StatefulWidget {
  const _ButtonLogin({Key? key}) : super(key: key);

  @override
  State<_ButtonLogin> createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<_ButtonLogin> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  final Duration _duration = const Duration(milliseconds: 500);

  void _onPressed(String? privateKey) {
    context.read<LoginBloc>().add(LoginSubmited(privateKey: privateKey));
  }

  String? privateKey = "";

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state.primaryKeyStatus) {
          case PrivateKeyStatus.init:
            break;
          case PrivateKeyStatus.valid:
            privateKey = state.privateKey;
            _buttonController.reset();
            break;
          case PrivateKeyStatus.invalid:
            privateKey = "";
            break;
          default:
        }
        switch (state.loginStatus) {
          case LoginStatus.init:
            _buttonController.reset();
            break;
          case LoginStatus.success:
            _buttonController.success();
            Timer(
              _duration,
              () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/home', (route) => false);
              },
            );
            break;
          case LoginStatus.fail:
            _buttonController.error();
            break;
          default:
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                RoundedLoadingButton(
                  height: 40,
                  width: 150,
                  color: Colors.indigo,
                  successColor: Colors.green.shade700,
                  borderRadius: 10,
                  controller: _buttonController,
                  onPressed: () {
                    _onPressed(privateKey);
                  },
                  child: const Text("Đăng nhập",
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TextButtonGeneratePrivateKey extends StatefulWidget {
  const _TextButtonGeneratePrivateKey({Key? key}) : super(key: key);

  @override
  State<_TextButtonGeneratePrivateKey> createState() =>
      _TextButtonGeneratePrivateKeyState();
}

class _TextButtonGeneratePrivateKeyState
    extends State<_TextButtonGeneratePrivateKey> {
  // Future<void> _pushToGeneratePage(BuildContext context) async {
  //   final result = await Navigator.pushNamed(
  //     context,
  //     '/generate',
  //   );
  //   if (!mounted) return;

  //   if (result == "SUCCESS") {
  //     final resultFromGenerateSuccess = await Navigator.pushNamed(
  //       context,
  //       '/generate_success',
  //     );
  //     if (!mounted) return;
  //     context.read<LoginBloc>().add(LoginInitPKFromGeneratePage(
  //         privateKey: resultFromGenerateSuccess as String));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Center(
        child: InkWell(
          child: Text(
            "Khởi tạo private key",
            style: TextStyle(color: Colors.blue[700]),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/generate');
          },
        ),
      ),
    );
  }
}
