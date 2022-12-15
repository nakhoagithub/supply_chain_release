import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:supply_chain/models/ingredient.dart';

import '../../../enum.dart';
import '../product.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(),
      child: const Scaffold(
        body: SafeArea(
          child: AddProductView(),
        ),
      ),
    );
  }
}

class AddProductView extends StatelessWidget {
  const AddProductView({Key? key}) : super(key: key);

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
              _Ingredient(),
              _LinkImageInput(),
              _DescriptionInput(),
              _ButtonAddProduct(),
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
            "Tạo sản phẩm",
            style: TextStyle(fontSize: 26, color: Colors.black87),
          ),
          const Text(
            "Thêm các sản phẩm vào kho",
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _CodeProductInput extends StatelessWidget {
  const _CodeProductInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: BlocProvider.of<ProductBloc>(context),
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
                      text: "Mã sản phẩm",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  TextSpan(text: " *", style: TextStyle(color: Colors.red))
                ])),
              ),
              TextFormField(
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

class _NameProductInput extends StatelessWidget {
  const _NameProductInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: BlocProvider.of<ProductBloc>(context),
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
                      text: "Tên sản phẩm",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  TextSpan(text: " *", style: TextStyle(color: Colors.red))
                ])),
              ),
              TextFormField(
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

class _Ingredient extends StatefulWidget {
  const _Ingredient();

  @override
  State<_Ingredient> createState() => _IngredientState();
}

class _IngredientState extends State<_Ingredient> {
  List<Ingredient> ingredients = [];

  void _addIngredient() async {
    dynamic result =
        await Navigator.of(context).pushNamed<dynamic>('/list_ingredient');
    if (result is Ingredient) {
      // kiểm tra nguyên liệu chưa được thêm
      int index = ingredients.indexWhere(
        (element) {
          if (element.id == result.id) {
            return true;
          }
          return false;
        },
      );
      if (index == -1) {
        setState(() {
          ingredients.add(result);
          context
              .read<ProductBloc>()
              .add(ProductChangeIngredientEvent(ingredients: ingredients));
        });
      }
    }
  }

  void _deleteIngredient(int index) {
    setState(() {
      ingredients.removeAt(index);
      context
          .read<ProductBloc>()
          .add(ProductChangeIngredientEvent(ingredients: ingredients));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
                text: const TextSpan(children: [
              TextSpan(
                  text: "Thêm nguyên liệu",
                  style: TextStyle(fontSize: 18, color: Colors.black)),
            ])),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[350],
            ),
            // height: 300,
            child: ingredients.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Không có nguyên liệu gốc"),
                    ),
                  )
                : ListView.builder(
                    primary: false,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: ingredients.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: _ItemIngredient(
                              name: ingredients[index].name ?? "??",
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _deleteIngredient(index);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.remove_circle_outline_rounded,
                                color: Colors.red[300],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextButton(
                onPressed: () {
                  _addIngredient();
                },
                child: const Text("Thêm nguyên liệu"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemIngredient extends StatelessWidget {
  final String name;
  const _ItemIngredient({
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Text(name),
          ],
        ),
      ),
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
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: BlocProvider.of<ProductBloc>(context),
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

class _DescriptionInput extends StatefulWidget {
  const _DescriptionInput({Key? key}) : super(key: key);

  @override
  State<_DescriptionInput> createState() => _DescriptionInputState();
}

class _DescriptionInputState extends State<_DescriptionInput> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: BlocProvider.of<ProductBloc>(context),
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

class _ButtonAddProduct extends StatefulWidget {
  const _ButtonAddProduct({Key? key}) : super(key: key);

  @override
  State<_ButtonAddProduct> createState() => _ButtonAddProductState();
}

class _ButtonAddProductState extends State<_ButtonAddProduct> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  void _onPressed() async {
    context.read<ProductBloc>().add(const ProductSubmitedEvent());
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
            Navigator.of(context).pop();
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
                  "Thêm",
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
