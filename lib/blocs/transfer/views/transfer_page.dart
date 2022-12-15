import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:supply_chain/widgets/dialog_app.dart';

import '../../../models/product.dart';
import '../../../models/transfer.dart';
import '../transfer.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransferBloc()..add(TransferInitEvent()),
      child: const TransferView(),
    );
  }
}

class TransferView extends StatefulWidget {
  const TransferView({super.key});

  @override
  State<TransferView> createState() => _TransferViewState();
}

class _TransferViewState extends State<TransferView> {
  void _transferInit() {
    const snackBar = SnackBar(
      content: Text('Đợi một chút...'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _transferSuccess() {
    const snackBar = SnackBar(
      content: Text('Thành công'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _transferUserNotInBlocchain() {
    const snackBar = SnackBar(
      content: Text('Lỗi: Chưa tham gia hệ thống blockchain'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _transferFailureGas() {
    const snackBar = SnackBar(
      content: Text('Không đủ số dư để trả phí cho giao dịch'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _transferFailureBuyerNotBlockchain() {
    const snackBar = SnackBar(
      content: Text('Người mua chưa tham gia hệ thống!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _transferIdAlready() {
    const snackBar = SnackBar(
      content: Text(
          'Trùng lặp ID giao dịch trên hệ thống vui lòng tạo lại giao dịch!'),
      duration: Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _transferFailure() {
    const snackBar = SnackBar(
      content:
          Text('Lỗi giao dịch không xác định, hãy liên hệ nhà phát triển.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransferBloc, TransferState>(
      bloc: BlocProvider.of<TransferBloc>(context),
      listener: (context, state) {
        switch (state.confirmTransferStatus) {
          case 0:
            _transferInit();
            break;
          case 1:
            _transferSuccess();
            break;
          case 2:
            _transferUserNotInBlocchain();
            break;
          case 3:
            _transferFailureGas();
            break;
          case 4:
            _transferFailureBuyerNotBlockchain();
            break;
          case 5:
            _transferIdAlready();
            break;
          case 400:
            _transferFailure();
            break;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Xác nhận giao dịch"),
          centerTitle: true,
          elevation: 1,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: _ListTransfer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListTransfer extends StatefulWidget {
  const _ListTransfer({Key? key}) : super(key: key);

  @override
  State<_ListTransfer> createState() => _ListTransferState();
}

class _ListTransferState extends State<_ListTransfer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferBloc, TransferState>(
      buildWhen: (previous, current) => previous.stream != current.stream,
      bloc: BlocProvider.of<TransferBloc>(context),
      builder: (context, state) {
        return state.stream == null
            ? const Center(
                child: Text("Đang lấy dữ liệu giao dịch..."),
              )
            : StreamBuilder<List<Transfer>>(
                stream: state.stream,
                builder: (context, snapshot) {
                  int itemCount =
                      snapshot.data != null ? snapshot.data!.length : 0;
                  return itemCount == 0
                      ? const Center(
                          child: Text("Chưa có giao dịch nào."),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: itemCount,
                          itemBuilder: (context, index) {
                            return _ItemTransfer(
                              idTransfer: snapshot.data![index].idTransfer,
                              keyProduct: snapshot.data![index].keyProduct,
                              description: snapshot.data![index].description,
                              addressBuyer: snapshot.data![index].addressBuyer,
                              product: snapshot.data![index].product,
                            );
                          },
                        );
                });
      },
    );
  }
}

class _ItemTransfer extends StatefulWidget {
  final String idTransfer;
  final String? keyProduct;
  final String? description;
  final String addressBuyer;
  final Product? product;
  const _ItemTransfer({
    required this.idTransfer,
    required this.keyProduct,
    required this.description,
    required this.addressBuyer,
    required this.product,
  });

  @override
  State<_ItemTransfer> createState() => _ItemTransferState();
}

class _ItemTransferState extends State<_ItemTransfer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferBloc, TransferState>(
      bloc: BlocProvider.of<TransferBloc>(context),
      builder: (context, state) {
        return Card(
          child: Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProductItemTransfer(
                  addressOwner: state.addressOwner,
                  idProduct: widget.keyProduct,
                  linkImage: widget.product == null ? null : widget.product!.linkImage,
                  name: widget.product == null ? null : widget.product!.name,
                ),
                _AddressBuyer(
                  addressBuyer: widget.addressBuyer,
                ),
                _Description(
                  description: widget.description,
                ),
                _TransferItemButton(
                  idTransfer: widget.idTransfer,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProductItemTransfer extends StatefulWidget {
  final String? addressOwner;
  final String? idProduct;
  final String? name;
  final String? linkImage;
  const _ProductItemTransfer({
    this.addressOwner,
    this.idProduct,
    this.name,
    this.linkImage,
  });

  @override
  State<_ProductItemTransfer> createState() => _ProductItemTransferState();
}

class _ProductItemTransferState extends State<_ProductItemTransfer> {
  String format(String? data) {
    final format = NumberFormat("#,###.0#");
    return format.format(double.parse(data!));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        _ImageProductItemTransfer(
          linkImageProduct: widget.linkImage,
        ),
        Expanded(
          child: Text(
            widget.name ?? "(Tên sản phẩm)",
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
        // Expanded(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisSize: MainAxisSize.max,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Text(
        //           widget.nameProduct ?? "(Tên sản phẩm)",
        //           textAlign: TextAlign.center,
        //           maxLines: 1,
        //           overflow: TextOverflow.ellipsis,
        //           style: const TextStyle(
        //             fontSize: 18,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     const Text(
        //       "Giá: ",
        //       textAlign: TextAlign.center,
        //       maxLines: 1,
        //       overflow: TextOverflow.ellipsis,
        //       style: TextStyle(
        //         fontSize: 16,
        //         color: Colors.black,
        //       ),
        //     ),
        //     Text(
        //       "${format(widget.price)} ${widget.currency}",
        //       textAlign: TextAlign.center,
        //       maxLines: 1,
        //       overflow: TextOverflow.ellipsis,
        //       style: const TextStyle(
        //         fontSize: 16,
        //         color: Colors.black,
        //       ),
        //     ),
        //   ],
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     const Text(
        //       "Số lượng: ",
        //       textAlign: TextAlign.center,
        //       maxLines: 1,
        //       overflow: TextOverflow.ellipsis,
        //       style: TextStyle(
        //         fontSize: 16,
        //         color: Colors.black,
        //       ),
        //     ),
        //     Text(
        //       "${format(widget.count)} ${widget.countingUnit}",
        //       textAlign: TextAlign.center,
        //       maxLines: 1,
        //       overflow: TextOverflow.ellipsis,
        //       style: const TextStyle(
        //         fontSize: 16,
        //         color: Colors.black,
        //       ),
        //     ),
        //   ],
        // ),
        //   ],
        // ),
        // )
      ],
    );
  }
}

class _ImageProductItemTransfer extends StatelessWidget {
  final String? linkImageProduct;
  const _ImageProductItemTransfer({required this.linkImageProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      margin: const EdgeInsets.all(5),
      child: linkImageProduct == null || linkImageProduct == ""
          ? Image.asset(
              "assets/images/icon_product.png",
              height: 80,
              width: 80,
            )
          : Image.network(
              linkImageProduct ?? "",
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
    );
  }
}

class _AddressBuyer extends StatelessWidget {
  final String addressBuyer;
  const _AddressBuyer({required this.addressBuyer});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Địa chỉ người nhận:",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              addressBuyer,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Description extends StatelessWidget {
  final String? description;
  const _Description({required this.description});

  @override
  Widget build(BuildContext context) {
    return description == null || description == ""
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Mô tả giao dịch:",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          );
  }
}

class _TransferItemButton extends StatefulWidget {
  final String idTransfer;
  const _TransferItemButton({required this.idTransfer});

  @override
  State<_TransferItemButton> createState() => _TransferItemButtonState();
}

class _TransferItemButtonState extends State<_TransferItemButton> {
  void _cancelTransfer() {
    openDialog(
      context,
      message: "Hủy và xóa giao dịch?",
      yes: "Hủy giao dịch",
      no: "Không",
      onPressed: () {
        context
            .read<TransferBloc>()
            .add(TransferCancelEvent(idTransfer: widget.idTransfer));
        Navigator.of(context).pop();
      },
    );
  }

  void _confirmTransfer() {
    openDialog(
      context,
      message:
          "Xác nhận giao dịch.\nGiao dịch sẽ được mạng blockchain xác nhận.",
      yes: "Xác nhận giao dịch",
      no: "Không",
      onPressed: () {
        if (mounted) {
          context
              .read<TransferBloc>()
              .add(TransferConfirmEvent(idTransfer: widget.idTransfer));
          Navigator.of(context).pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransferBloc, TransferState>(
      bloc: BlocProvider.of<TransferBloc>(context),
      listener: (context, state) {},
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                _cancelTransfer();
              },
              child: const Text(
                "Hủy",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _confirmTransfer();
              },
              child: const Text(
                "Xác nhận giao dịch",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
