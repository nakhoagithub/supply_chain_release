import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:supply_chain/blocs/change_info/change_info.dart';
import '../../../enum.dart';

class ChangeInformationUserPage extends StatelessWidget {
  const ChangeInformationUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ChangeInfoBloc()..add(const ChangeInfoInit()),
        child: const ChangeInfomationUserForm());
  }
}

class ChangeInfomationUserForm extends StatelessWidget {
  const ChangeInfomationUserForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeInfoBloc, ChangeInfoState>(
      buildWhen: (previous, current) =>
          previous.haveChange != current.haveChange,
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop("RELOAD");
            return false;
          },
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                      _DescriptionInput(),
                      _LinkImageInput(),
                      _NoteForm(),
                      _ButtonGenerate(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TitleGenerate extends StatelessWidget {
  const _TitleGenerate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeInfoBloc, ChangeInfoState>(
        buildWhen: (previous, current) =>
            previous.haveChange != current.haveChange,
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop(state.haveChange ? "RELOAD" : "");
                    },
                    icon: const Icon(Icons.arrow_back_rounded)),
                const Text(
                  "Thay đổi thông tin",
                  style: TextStyle(fontSize: 26, color: Colors.black87),
                ),
                const Text(
                  "Thay đổi thông tin của công ty",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ],
            ),
          );
        });
  }
}

class _NameInput extends StatefulWidget {
  const _NameInput({Key? key}) : super(key: key);

  @override
  State<_NameInput> createState() => _NameInputState();
}

class _NameInputState extends State<_NameInput> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeInfoBloc, ChangeInfoState>(
      buildWhen: (previous, current) =>
          previous.nameStatus != current.nameStatus ||
          previous.name != current.name,
      builder: (context, state) {
        if (state.changeInfoStatus == ChangeInfoStatus.initData) {
          textEditingController.text = state.name ?? "";
        }
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
                controller: textEditingController,
                onChanged: (name) => context
                    .read<ChangeInfoBloc>()
                    .add(ChangeInfoCompanyNameChange(name: name)),
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

class _EmailInput extends StatefulWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  State<_EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<_EmailInput> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeInfoBloc, ChangeInfoState>(
      buildWhen: (previous, current) =>
          previous.emailStatus != current.emailStatus ||
          previous.email != current.email,
      builder: (context, state) {
        if (state.changeInfoStatus == ChangeInfoStatus.initData) {
          textEditingController.text = state.email ?? "";
        }
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
                controller: textEditingController,
                onChanged: (email) => context
                    .read<ChangeInfoBloc>()
                    .add(ChangeInfoCompanyEmailChange(email: email)),
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

class _AddressInput extends StatefulWidget {
  const _AddressInput({Key? key}) : super(key: key);

  @override
  State<_AddressInput> createState() => _AddressInputState();
}

class _AddressInputState extends State<_AddressInput> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeInfoBloc, ChangeInfoState>(
      buildWhen: (previous, current) =>
          previous.addressStatus != current.addressStatus ||
          previous.address != current.address,
      builder: (context, state) {
        if (state.changeInfoStatus == ChangeInfoStatus.initData) {
          textEditingController.text = state.address ?? "";
        }
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
                controller: textEditingController,
                onChanged: (address) => context
                    .read<ChangeInfoBloc>()
                    .add(ChangeInfoCompanyAddressChange(address: address)),
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

class _DescriptionInput extends StatefulWidget {
  const _DescriptionInput({Key? key}) : super(key: key);

  @override
  State<_DescriptionInput> createState() => _DescriptionInputState();
}

class _DescriptionInputState extends State<_DescriptionInput> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeInfoBloc, ChangeInfoState>(
      buildWhen: (previous, current) =>
          previous.descriptionStatus != current.descriptionStatus ||
          previous.description != current.description,
      builder: (context, state) {
        if (state.changeInfoStatus == ChangeInfoStatus.initData) {
          textEditingController.text = state.description ?? "";
        }
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
                      text: "Mô tả",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  TextSpan(text: " *", style: TextStyle(color: Colors.red))
                ])),
              ),
              TextFormField(
                controller: textEditingController,
                minLines: 4,
                maxLines: 5,
                onChanged: (description) => context.read<ChangeInfoBloc>().add(
                    ChangeInfoCompanyDescriptionChange(
                        description: description)),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[350],
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[350]!.withOpacity(1)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[350]!.withOpacity(1)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText:
                        state.descriptionStatus == DescriptionStatus.invalid
                            ? "Mô tả không được để trống!"
                            : null),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LinkImageInput extends StatefulWidget {
  const _LinkImageInput({Key? key}) : super(key: key);

  @override
  State<_LinkImageInput> createState() => _LinkImageInputState();
}

class _LinkImageInputState extends State<_LinkImageInput> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeInfoBloc, ChangeInfoState>(
      buildWhen: (previous, current) =>
          previous.linkImageStatus != current.linkImageStatus ||
          previous.linkImage != current.linkImage,
      builder: (context, state) {
        if (state.changeInfoStatus == ChangeInfoStatus.initData) {
          textEditingController.text = state.linkImage ?? "";
        }
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
                      text: "Đường dẫn ảnh",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  // TextSpan(text: " *", style: TextStyle(color: Colors.red))
                ])),
              ),
              TextFormField(
                controller: textEditingController,
                onChanged: (link) => context
                    .read<ChangeInfoBloc>()
                    .add(ChangeInfoCompanyLinkImageChange(link: link)),
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
                    prefixIcon: const Icon(Icons.link),
                    errorText: state.linkImageStatus == LinkImageStatus.invalid
                        ? "Đường dẫn không hợp lệ!"
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

class _ButtonGenerate extends StatefulWidget {
  const _ButtonGenerate({Key? key}) : super(key: key);

  @override
  State<_ButtonGenerate> createState() => _ButtonGenerateState();
}

class _ButtonGenerateState extends State<_ButtonGenerate> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  void _onPressed() async {
    context.read<ChangeInfoBloc>().add(const ChangeInfoSubmited());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangeInfoBloc, ChangeInfoState>(
      listener: (context, state) {
        switch (state.changeInfoStatus) {
          case ChangeInfoStatus.init:
            _buttonController.reset();
            break;
          case ChangeInfoStatus.loading:
            _buttonController.start();
            break;
          case ChangeInfoStatus.success:
            _buttonController.success();
            break;
          case ChangeInfoStatus.failure:
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
                child: const Text("Lưu",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
