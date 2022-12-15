import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../enum.dart';
import '../generate_private_key.dart';

class GeneratePKPage extends StatelessWidget {
  const GeneratePKPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            return GeneratePKBloc();
          },
          child: const GeneratePKForm(),
        ),
      ),
    );
  }
}

class GeneratePKForm extends StatelessWidget {
  const GeneratePKForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            _TitleGenerate(),
            _NameInput(),
            _EmailInput(),
            _AddressInput(),
            _NoteForm(),
            _ButtonGenerate(),
          ],
        ),
      ),
    );
  }
}

class _TitleGenerate extends StatelessWidget {
  const _TitleGenerate({Key? key}) : super(key: key);

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
            "Khởi tạo Private key",
            style: TextStyle(fontSize: 26, color: Colors.black87),
          ),
          const Text(
            "Khởi tạo Private Key cho công ty",
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneratePKBloc, GeneratePKState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: "Tên công ty",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  TextSpan(text: " *", style: TextStyle(color: Colors.red))
                ])),
              ),
              TextFormField(
                onChanged: (name) => context
                    .read<GeneratePKBloc>()
                    .add(GenerateCompanyNameChange(name: name)),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[350],
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
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
                    prefixIcon: const Icon(Icons.store_outlined),
                    errorText: state.nameStatus == NameStatus.invalid
                        ? "Tên không được để trống!"
                        : null),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneratePKBloc, GeneratePKState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: "Email công ty",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  TextSpan(text: " *", style: TextStyle(color: Colors.red))
                ])),
              ),
              TextFormField(
                onChanged: (email) => context
                    .read<GeneratePKBloc>()
                    .add(GenerateCompanyEmailChange(email: email)),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[350],
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
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
                    prefixIcon: const Icon(Icons.mail_outline),
                    errorText: state.emailStatus == EmailStatus.emailInvalid
                        ? "Email không hợp lệ!"
                        : null),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AddressInput extends StatelessWidget {
  const _AddressInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneratePKBloc, GeneratePKState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: "Địa chỉ công ty",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  TextSpan(text: " *", style: TextStyle(color: Colors.red))
                ])),
              ),
              TextFormField(
                onChanged: (address) => context
                    .read<GeneratePKBloc>()
                    .add(GenerateCompanyAddressChange(address: address)),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[350],
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
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
                    prefixIcon: const Icon(Icons.location_on_outlined),
                    errorText: state.addressStatus == AddressStatus.invalid
                        ? "Địa chỉ không hợp lệ!"
                        : null),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NoteForm extends StatelessWidget {
  const _NoteForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
                text: const TextSpan(children: [
              TextSpan(text: "* ", style: TextStyle(color: Colors.red)),
              TextSpan(
                  text: "Thông tin bắt buộc",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontStyle: FontStyle.italic)),
            ])),
          ),
        ],
      ),
    );
  }
}

// class _ButtonGenerate extends StatelessWidget {
//   const _ButtonGenerate({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GeneratePKBloc, GeneratePKState>(
//       builder: (context, state) => Center(
//         child: Container(
//           margin: const EdgeInsets.only(top: 30),
//           child: TextButton(
//             onPressed: () {
//               context.read<GeneratePKBloc>().add(GeneratePKSubmited(
//                   name: context.read<GeneratePKBloc>().state.name,
//                   email: context.read<GeneratePKBloc>().state.email,
//                   addressCompany:
//                       context.read<GeneratePKBloc>().state.address));
//             },
//             style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.indigo[700]),
//                 padding: MaterialStateProperty.all(const EdgeInsets.only(
//                     left: 25, right: 25, bottom: 12, top: 12)),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ))),
//             child: const Text("Khởi tạo",
//                 style: TextStyle(color: Colors.white, fontSize: 16)),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _ButtonGenerate extends StatefulWidget {
  const _ButtonGenerate({Key? key}) : super(key: key);

  @override
  State<_ButtonGenerate> createState() => _ButtonGenerateState();
}

class _ButtonGenerateState extends State<_ButtonGenerate> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  final Duration _duration = const Duration(milliseconds: 800);

  void _onPressed() async {
    context.read<GeneratePKBloc>().add(const GeneratePKSubmited());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GeneratePKBloc, GeneratePKState>(
      listener: (context, state) {
        switch (state.generateStatus) {
          case GenerateStatus.init:
            _buttonController.reset();
            break;
          case GenerateStatus.loading:
            _buttonController.start();
            break;
          case GenerateStatus.success:
            _buttonController.success();
            Timer(
              _duration,
              () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/generate_success');
              },
            );
            break;
          case GenerateStatus.failure:
            _buttonController.error();
            break;
          default:
        }
      },
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
                onPressed: _onPressed,
                child: const Text("Khởi tạo",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
