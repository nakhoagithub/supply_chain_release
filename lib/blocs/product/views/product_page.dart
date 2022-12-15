import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/widgets/dialog_app.dart';

import '../../../enum.dart';
import '../../../models/product.dart';
import '../product.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(ProductInitEvent()),
      child: const ProductView(),
    );
  }
}

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hàng hóa"),
        centerTitle: true,
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/add_product');
              },
              icon: const Icon(Icons.add_business))
        ],
      ),
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [Expanded(child: _ListProduct())]),
      ),
    );
  }
}

class _ListProduct extends StatefulWidget {
  const _ListProduct({Key? key}) : super(key: key);

  @override
  State<_ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<_ListProduct> {
  void _processingProductSuccess() {
    const snackBar = SnackBar(
      content: Text('Đã chuyển đổi sản phẩm thành sản phẩm chế biến'),
      duration: Duration(milliseconds: 500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) => previous.stream != current.stream,
      bloc: BlocProvider.of<ProductBloc>(context),
      builder: (context, state) {
        if (state.processingProductStatus == ProcessingProductStatus.success) {
          _processingProductSuccess();
        }
        return state.stream == null
            ? const Center(
                child: Text("Đang lấy dữ liệu sản phẩm..."),
              )
            : StreamBuilder<List<Product>>(
                stream: state.stream,
                builder: (context, snapshot) {
                  int itemCount =
                      snapshot.data != null ? snapshot.data!.length : 0;
                  return itemCount == 0
                      ? const Center(
                          child: Text("Chưa có sản phẩm"),
                        )
                      : GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: itemCount,
                          itemBuilder: (context, index) {
                            return _ItemProduct(
                              keyProduct: snapshot.data?[index].id,
                              linkImageProduct: snapshot.data?[index].linkImage,
                              name: snapshot.data?[index].name,
                              type: snapshot.data?[index].type,
                            );
                          },
                        );
                });
      },
    );
  }
}

class _ItemProduct extends StatefulWidget {
  final String? keyProduct;
  final String? linkImageProduct;
  final String? name;
  final String? type;
  const _ItemProduct({
    Key? key,
    required this.keyProduct,
    required this.linkImageProduct,
    required this.name,
    required this.type,
  }) : super(key: key);

  @override
  State<_ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<_ItemProduct> {
  Icon? getIconProduct(String? type) {
    switch (type) {
      case "create":
        return const Icon(
          Icons.add_circle_outline_sharp,
          color: Colors.green,
        );
      case "transfer":
        return const Icon(
          Icons.access_time_rounded,
          color: Colors.orange,
        );
      case "buyed":
        return const Icon(
          Icons.check_circle_outline_rounded,
          color: Colors.green,
        );
      case "processing":
        return const Icon(
          Icons.account_tree_rounded,
          color: Colors.green,
        );
    }
    return null;
  }

  void openBottomSheetManagerProduct(
      context, ProductBloc bloc, String? keyProduct) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Quản lý",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              _ProductTransfer(keyProduct: keyProduct),
              _ProductChangeInfo(keyProduct: keyProduct),
              _MenuDeleteProduct(idProduct: keyProduct, bloc: bloc),
            ],
          ),
        );
      },
    );
  }

  void openBottomSheetComfirmProduct(
      context, ProductBloc bloc, String? keyProduct) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Xác nhận sản phẩm",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              _ProductComfirm(keyProduct: keyProduct),
            ],
          ),
        );
      },
    );
  }

  void openBottomSheetProductBuyed(
      context, ProductBloc bloc, String? keyProduct) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Quản lý sản phẩm đã mua",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              _MenuDeleteProduct(idProduct: keyProduct, bloc: bloc),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ProductBloc>(context),
      child: InkWell(
        onTap: () async {
          if (widget.keyProduct != null) {
            if (widget.type == "transfer") {
              openBottomSheetComfirmProduct(context,
                  BlocProvider.of<ProductBloc>(context), widget.keyProduct);
            }
            if (widget.type == "create") {
              openBottomSheetManagerProduct(context,
                  BlocProvider.of<ProductBloc>(context), widget.keyProduct);
            }
            if (widget.type == "buyed") {
              openBottomSheetProductBuyed(context,
                  BlocProvider.of<ProductBloc>(context), widget.keyProduct);
            }
          }
        },
        child: Card(
          child: Stack(
            children: [
              Column(children: [
                Expanded(
                  child: Center(
                    child: Container(
                      child: widget.linkImageProduct == null ||
                              widget.linkImageProduct == ""
                          ? Image.asset(
                              "assets/images/icon_product.png",
                              height: 80,
                              width: 80,
                            )
                          : Image.network(
                              widget.linkImageProduct ?? "",
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
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Text(
                    widget.name ?? "(Sản phẩm)",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]),
              Container(
                margin: const EdgeInsets.all(5),
                child: getIconProduct(widget.type),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductTransfer extends StatelessWidget {
  final String? keyProduct;
  const _ProductTransfer({Key? key, required this.keyProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed("/product_transfer", arguments: keyProduct);
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: const Icon(
              Icons.transform_rounded,
              size: 18,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: const Text(
              "Vận chuyển",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductChangeInfo extends StatelessWidget {
  final String? keyProduct;
  const _ProductChangeInfo({Key? key, required this.keyProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed("/product_manager", arguments: keyProduct);
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: const Icon(
              Icons.info_outline,
              size: 18,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: const Text(
              "Thông tin/Chỉnh sửa sản phẩm",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuDeleteProduct extends StatelessWidget {
  final String? idProduct;
  final ProductBloc bloc;
  const _MenuDeleteProduct(
      {Key? key, required this.idProduct, required this.bloc})
      : super(key: key);

  void deleteProduct(context, ProductBloc bloc) {
    openDialog(context, message: "Xóa sản phẩm", yes: "Xóa", no: "Không",
        onPressed: () {
      bloc.add(ProductDeleteEvent(idProduct: idProduct));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      bloc: bloc,
      listener: (context, state) {
        switch (state.productDeleteStatus) {
          case DeleteStatus.initialize:
            break;
          case DeleteStatus.success:
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            break;
          case DeleteStatus.failure:
            break;
          default:
        }
      },
      child: InkWell(
        onTap: () {
          deleteProduct(context, bloc);
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: const Icon(
                Icons.delete,
                size: 18,
                color: Colors.red,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: const Text(
                "Xóa sản phẩm",
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductComfirm extends StatefulWidget {
  final String? keyProduct;
  const _ProductComfirm({Key? key, required this.keyProduct}) : super(key: key);

  @override
  State<_ProductComfirm> createState() => _ProductComfirmState();
}

class _ProductComfirmState extends State<_ProductComfirm> {
  void _scanQR() async {
    final result = await Navigator.of(context)
        .pushNamed<dynamic>("/qr", arguments: widget.keyProduct);
    if (result == "SUCCESS") {
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _scanQR();
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: const Icon(
              Icons.qr_code,
              size: 18,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: const Text(
              "Xác nhận sản phẩm - Quét mã QR",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
