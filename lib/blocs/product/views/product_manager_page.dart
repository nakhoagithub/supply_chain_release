import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../enum.dart';
import '../product.dart';

class ProductManagerPage extends StatelessWidget {
  const ProductManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String arguments =
        (ModalRoute.of(context)?.settings.arguments ?? "") as String;
    return BlocProvider(
      create: (context) =>
          ProductBloc()..add(ProductManagerInitEvent(keyProduct: arguments)),
      child: const ProductManagerView(),
    );
  }
}

class ProductManagerView extends StatelessWidget {
  const ProductManagerView({Key? key}) : super(key: key);

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
            children: const [
              _TitleAddProduct(),
              _CodeProductInput(),
              _NameProductInput(),
              _DescriptionInput(),
              _LinkImageInput(),
              _NoteForm(),
              _ButtonSave(),
            ],
          ),
        ),
      )),
    );
  }
}

class _TitleAddProduct extends StatelessWidget {
  const _TitleAddProduct({Key? key}) : super(key: key);

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
            "Quản lý thông tin sản phẩm",
            style: TextStyle(fontSize: 26, color: Colors.black87),
          ),
          const Text(
            "Quản lý các sản phẩm trong kho",
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _CodeProductInput extends StatefulWidget {
  const _CodeProductInput({Key? key}) : super(key: key);

  @override
  State<_CodeProductInput> createState() => _CodeProductInputState();
}

class _CodeProductInputState extends State<_CodeProductInput> {
  bool initController = true;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          previous.productCode != current.productCode,
      bloc: BlocProvider.of<ProductBloc>(context),
      builder: (context, state) {
        if (state.productCode != null) {
          if (initController) {
            textEditingController.text = state.productCode ?? "";
          }
          initController = false;
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
                      text: "Mã sản phẩm",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  TextSpan(text: " *", style: TextStyle(color: Colors.red))
                ])),
              ),
              TextFormField(
                controller: textEditingController,
                onChanged: (code) => context
                    .read<ProductBloc>()
                    .add(ProductChangeCodeEvent(productCode: code)),
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
                    // prefixIcon: const Icon(Icons.store_outlined),
                    errorText: state.codeStatus == CodeStatus.codeInvalid
                        ? "Mã sản phẩm không được để trống!"
                        : null),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NameProductInput extends StatefulWidget {
  const _NameProductInput({Key? key}) : super(key: key);

  @override
  State<_NameProductInput> createState() => _NameProductInputState();
}

class _NameProductInputState extends State<_NameProductInput> {
  bool initController = true;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: BlocProvider.of<ProductBloc>(context),
      builder: (context, state) {
        if (state.productCode != null) {
          if (initController) {
            textEditingController.text = state.productName ?? "";
          }
          initController = false;
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
                      text: "Tên sản phẩm",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  TextSpan(text: " *", style: TextStyle(color: Colors.red))
                ])),
              ),
              TextFormField(
                controller: textEditingController,
                onChanged: (name) => context
                    .read<ProductBloc>()
                    .add(ProductChangeNameEvent(productName: name)),
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
                    // prefixIcon: const Icon(Icons.store_outlined),
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

class _DescriptionInput extends StatefulWidget {
  const _DescriptionInput({Key? key}) : super(key: key);

  @override
  State<_DescriptionInput> createState() => _DescriptionInputState();
}

class _DescriptionInputState extends State<_DescriptionInput> {
  bool initController = true;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: BlocProvider.of<ProductBloc>(context),
      builder: (context, state) {
        if (state.productCode != null) {
          if (initController) {
            textEditingController.text = state.description ?? "";
          }
          initController = false;
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
                  // TextSpan(text: " *", style: TextStyle(color: Colors.red))
                ])),
              ),
              TextFormField(
                controller: textEditingController,
                minLines: 4,
                maxLines: 5,
                onChanged: (description) {
                  context.read<ProductBloc>().add(
                      ProductChangeDescriptionEvent(description: description));
                },
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
                    hintText: "Mô tả sản phẩm"
                    // errorText:
                    //     state.descriptionStatus == DescriptionStatus.invalid
                    //         ? "Mô tả không được để trống!"
                    //         : null),
                    ),
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
  bool initController = true;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: BlocProvider.of<ProductBloc>(context),
      builder: (context, state) {
        if (state.productCode != null) {
          if (initController) {
            textEditingController.text = state.linkImage ?? "";
          }
          initController = false;
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
                  TextSpan(text: " *", style: TextStyle(color: Colors.red))
                ])),
              ),
              TextFormField(
                controller: textEditingController,
                onChanged: (link) => context
                    .read<ProductBloc>()
                    .add(ProductChangeLinkImageEvent(link: link)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[350],
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
                  prefixIcon: const Icon(Icons.link),
                  hintText: "https://...",
                  errorText: state.linkImageStatus == LinkImageStatus.invalid
                      ? "Đường dẫn không hợp lệ!"
                      : null,
                ),
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

class _ButtonSave extends StatefulWidget {
  const _ButtonSave({Key? key}) : super(key: key);

  @override
  State<_ButtonSave> createState() => _ButtonSaveState();
}

class _ButtonSaveState extends State<_ButtonSave> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  void _onPressed() async {
    context.read<ProductBloc>().add(const ProductChangeSubmitedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      bloc: BlocProvider.of<ProductBloc>(context),
      listener: (context, state) {
        switch (state.productStatus) {
          case ProductStatus.initialize:
            _buttonController.reset();
            break;
          case ProductStatus.loading:
            _buttonController.start();
            break;
          case ProductStatus.success:
            _buttonController.success();
            break;
          case ProductStatus.failure:
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
                child: const Text(
                  "Lưu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
