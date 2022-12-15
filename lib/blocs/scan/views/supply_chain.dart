import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/models/company.dart';

import '../../../models/ingredient.dart';
import '../../../models/product.dart';
import '../../../widgets/text_html.dart';
import '../bloc/scan_bloc.dart';

class SupplyChain extends StatelessWidget {
  const SupplyChain({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> data =
        (ModalRoute.of(context)?.settings.arguments) as List<dynamic>;
    return BlocProvider(
      create: (context) => ScanBloc(),
      child: _SupplyChainView(data: data),
    );
  }
}

class _SupplyChainView extends StatefulWidget {
  final List<dynamic>? data;
  const _SupplyChainView({required this.data});

  @override
  State<_SupplyChainView> createState() => _SupplyChainViewState();
}

class _SupplyChainViewState extends State<_SupplyChainView> {
  @override
  void initState() {
    super.initState();
    context.read<ScanBloc>().add(ScanDataResult(data: widget.data));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanBloc, ScanState>(
      bloc: BlocProvider.of<ScanBloc>(context),
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
                    _ImageProduct(product: state.product),
                    _InBlockchain(
                      addressBuyer: state.addressBuyer,
                      addressOwner: state.addressOwner,
                    ),
                    _Source(
                      company: state.company,
                    ),
                    const _Ingredient(),
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
            "Chuỗi cung ứng",
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

class _ImageProduct extends StatelessWidget {
  final Product? product;
  const _ImageProduct({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        product == null
            ? Container(
                margin: const EdgeInsets.all(20),
                child: Center(
                  child: Image.asset(
                    "assets/images/icon_product.png",
                    height: 80,
                    width: 80,
                  ),
                ),
              )
            : product!.linkImage == null || product!.linkImage == ""
                ? Image.asset(
                    "assets/images/icon_product.png",
                    height: 80,
                    width: 80,
                  )
                : Image.network(
                    product!.linkImage ?? "",
                    height: 80,
                    width: 80,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/images/icon_product.png",
                        height: 80,
                        width: 80,
                      );
                    },
                  ),
        product == null
            ? Container()
            : Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  product!.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
      ],
    ));
  }
}

class _InBlockchain extends StatelessWidget {
  final String? addressBuyer;
  final String? addressOwner;
  const _InBlockchain({
    required this.addressBuyer,
    required this.addressOwner,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        margin: const EdgeInsets.all(10),
        child: const Text(
          "Xem trên Blockchain:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 5),
        child: addressOwner == null
            ? const Text("- Địa chỉ Chủ sở hữu: ...")
            : TextHTML(
                text:
                    '- Địa chỉ Chủ sở hữu: <link blockchain_address="$addressOwner">$addressOwner</link>',
              ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 5),
        child: addressBuyer == null
            ? const Text("- Địa chỉ Chủ sở hữu: ...")
            : TextHTML(
                text:
                    '- Địa chỉ bên Mua: <link blockchain_address="$addressBuyer">$addressBuyer</link>',
              ),
      ),
    ]);
  }
}

class _Source extends StatelessWidget {
  final Company? company;
  const _Source({
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        margin: const EdgeInsets.all(10),
        child: const Text(
          "Nơi sản xuất:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      company == null
          ? const Center(
              child: Text("Không có công ty cung cấp"),
            )
          : Card(
              child: Container(
                width: w,
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      company!.name ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        company!.email ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      company!.addressCompany ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    ]);
  }
}

class _Ingredient extends StatelessWidget {
  const _Ingredient();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanBloc, ScanState>(
      bloc: BlocProvider.of<ScanBloc>(context),
      buildWhen: (previous, current) =>
          previous.ingredients != current.ingredients,
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: const Text(
              "Nguồn nguyên liệu",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          _ListIngredient(
            ingredients: state.ingredients,
          ),
        ]);
      },
    );
  }
}

class _ListIngredient extends StatefulWidget {
  final List<Ingredient>? ingredients;
  const _ListIngredient({required this.ingredients});

  @override
  State<_ListIngredient> createState() => _ListIngredientState();
}

class _ListIngredientState extends State<_ListIngredient> {
  void _scanIngredient(int index) {
    if (widget.ingredients != null) {
      final idHistory = widget.ingredients![index].idHistory;
      if (idHistory != null) {
        String id = idHistory.trim();
        context.read<ScanBloc>().add(ScanSuccessEvent(barcode: id));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.ingredients == null ||
            (widget.ingredients != null && widget.ingredients!.isEmpty)
        ? const Center(
            child: Text("Sản phẩm không có nguyên liệu!"),
          )
        : BlocListener<ScanBloc, ScanState>(
            listenWhen: (previous, current) =>
                previous.dataResult != current.dataResult,
            listener: (context, state) {
              if (state.dataResult != null) {
                Navigator.of(context).pushNamed(
                  '/supply_chain',
                  arguments:
                      BlocProvider.of<ScanBloc>(context).state.dataResult,
                );
              }
            },
            child: ListView.builder(
              itemCount: widget.ingredients!.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    onTap: () {
                      _scanIngredient(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Text(
                            widget.ingredients![index].name ??
                                "(Tên nguyên liệu)",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
