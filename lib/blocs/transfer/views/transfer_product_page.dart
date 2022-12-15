import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../enum.dart';
import '../transfer.dart';

class TransferProductPage extends StatelessWidget {
  const TransferProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String keyProduct =
        (ModalRoute.of(context)?.settings.arguments ?? "") as String;
    return BlocProvider(
      create: (context) =>
          TransferBloc()..add(TransferProductInitEvent(keyProduct: keyProduct)),
      child: const TransferProductView(),
    );
  }
}

class TransferProductView extends StatelessWidget {
  const TransferProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferBloc, TransferState>(
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
                  const _TitleTransferProduct(),
                  _ImageProduct(linkImage: state.linkImage ?? ""),
                  _CodeProduct(productCode: state.productCode ?? ""),
                  _NameProduct(productName: state.productName ?? ""),
                  _DescriptionProduct(description: state.description ?? ""),
                  const _AddressBuyerTranfer(),
                  // const _PriceProductInput(),
                  // const _CountingUnitAndUnit(),
                  const _DescriptionInput(),
                  const _NoteForm(),
                  const _ButtonTransfer(),
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}

class _TitleTransferProduct extends StatelessWidget {
  const _TitleTransferProduct({Key? key}) : super(key: key);

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
            "Vận chuyển",
            style: TextStyle(fontSize: 26, color: Colors.black87),
          ),
          const Text(
            "Vận chuyển sản phẩm giữa các nhà cung cấp và nhà sản xuất",
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _ImageProduct extends StatelessWidget {
  final String? linkImage;
  const _ImageProduct({required this.linkImage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: linkImage == null || linkImage == ""
            ? Image.asset(
                "assets/images/icon_product.png",
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              )
            : Image.network(
                linkImage ?? "",
                height: 80,
                width: 80,
              ),
      ),
    );
  }
}

class _CodeProduct extends StatelessWidget {
  final String productCode;
  const _CodeProduct({required this.productCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          const Text(
            "Mã sản phẩm: ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: Center(
              child: Text(
                productCode,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NameProduct extends StatelessWidget {
  final String productName;
  const _NameProduct({required this.productName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          const Text(
            "Tên sản phẩm: ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: Center(
              child: Text(
                productName,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DescriptionProduct extends StatelessWidget {
  final String description;
  const _DescriptionProduct({required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Mô tả: ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            description,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressBuyerTranfer extends StatelessWidget {
  const _AddressBuyerTranfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferBloc, TransferState>(
      bloc: BlocProvider.of<TransferBloc>(context),
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Địa chỉ người nhận",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: " *",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextFormField(
                onChanged: (address) => context
                    .read<TransferBloc>()
                    .add(TransferChangeAddressBuyerEvent(address: address)),
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
                  hintText: "0x...",
                  errorText:
                      state.addressBuyerStatus == AddressEtherStatus.invalid
                          ? "Tên không được để trống!"
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

// class _PriceProductInput extends StatefulWidget {
//   const _PriceProductInput({Key? key}) : super(key: key);

//   @override
//   State<_PriceProductInput> createState() => _PriceProductInputState();
// }

// class _PriceProductInputState extends State<_PriceProductInput> {
//   final List<String> currencyItems = [
//     'VND',
//     'USD',
//   ];

//   bool firstBuild = false;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TransferBloc, TransferState>(
//       bloc: BlocProvider.of<TransferBloc>(context),
//       builder: (context, state) {
//         if (!firstBuild) {
//           context
//               .read<TransferBloc>()
//               .add(TransferChangeCurrencyEvent(currency: currencyItems[0]));
//           firstBuild = true;
//         }
//         return Container(
//           margin: const EdgeInsets.only(top: 2),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: RichText(
//                     text: const TextSpan(children: [
//                   TextSpan(
//                       text: "Giá sản phẩm",
//                       style: TextStyle(fontSize: 18, color: Colors.black)),
//                   TextSpan(text: " *", style: TextStyle(color: Colors.red))
//                 ])),
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       onChanged: (price) => context
//                           .read<TransferBloc>()
//                           .add(TransferChangePriceEvent(price: price)),
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.grey[350],
//                         contentPadding: const EdgeInsets.only(
//                             left: 14.0, bottom: 8.0, top: 8.0),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.grey[350]!.withOpacity(1)),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.grey[350]!.withOpacity(1)),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         prefixIcon: const Icon(Icons.attach_money_outlined),
//                         hintText: "1.000, 2.000 ...",
//                         errorText: state.priceStatus == PriceStatus.invalid
//                             ? "Giá không hợp lệ!"
//                             : null,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(left: 10),
//                     // decoration: BoxDecoration(
//                     //   borderRadius: BorderRadius.circular(20),
//                     //   color: Colors.grey[350],
//                     // ),
//                     height: 48,
//                     width: 100,
//                     child: DropdownButtonFormField2(
//                       decoration: InputDecoration(
//                         contentPadding: const EdgeInsets.all(5),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       value: currencyItems[0],
//                       buttonPadding: const EdgeInsets.only(left: 10, top: 5),
//                       buttonHeight: 48,
//                       items: currencyItems.map((item) {
//                         return DropdownMenuItem<String>(
//                           value: item,
//                           child: Text(item),
//                         );
//                       }).toList(),
//                       onChanged: (currency) {
//                         context.read<TransferBloc>().add(
//                             TransferChangeCurrencyEvent(
//                                 currency: currency as String));
//                       },
//                       validator: (value) {
//                         if (value == null) {
//                           return 'Rỗng!';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class _CountingUnitAndUnit extends StatelessWidget {
//   const _CountingUnitAndUnit({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 5),
//       child: Row(
//         children: [
//           BlocBuilder<TransferBloc, TransferState>(
//             bloc: BlocProvider.of<TransferBloc>(context),
//             builder: (context, state) {
//               return Flexible(
//                 flex: 3,
//                 child: Column(
//                   children: [
//                     // Số lượng sản phẩm
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: RichText(
//                           text: const TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: "Số lượng",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: " *",
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     TextFormField(
//                       onChanged: (count) => context.read<TransferBloc>().add(
//                             TransferChangeCountEvent(count: count),
//                           ),
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.grey[350],
//                         contentPadding: const EdgeInsets.only(
//                           left: 14.0,
//                           bottom: 8.0,
//                           top: 8.0,
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.grey[350]!.withOpacity(1),
//                           ),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.grey[350]!.withOpacity(1),
//                           ),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         // prefixIcon: const Icon(Icons.store_outlined),
//                         hintText: "1, 2, 3, ...",
//                         errorText: state.countStatus == CountStatus.invalid
//                             ? "Số lượng không hợp lệ!"
//                             : null,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           BlocBuilder<TransferBloc, TransferState>(
//             bloc: BlocProvider.of<TransferBloc>(context),
//             builder: (context, state) {
//               return Flexible(
//                 flex: 2,
//                 child: Container(
//                   margin: const EdgeInsets.only(left: 10),
//                   child: Column(
//                     children: [
//                       // Đơn vị
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: RichText(
//                               text: const TextSpan(children: [
//                             TextSpan(
//                               text: "Đơn vị",
//                               style:
//                                   TextStyle(fontSize: 18, color: Colors.black),
//                             ),
//                             TextSpan(
//                               text: " *",
//                               style: TextStyle(color: Colors.red),
//                             ),
//                           ])),
//                         ),
//                       ),
//                       TextFormField(
//                         onChanged: (countingUnit) => context
//                             .read<TransferBloc>()
//                             .add(TransferChangeCountingUnitEvent(
//                                 countingUnit: countingUnit)),
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.grey[350],
//                           contentPadding: const EdgeInsets.only(
//                               left: 14.0, bottom: 8.0, top: 8.0),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Colors.grey[350]!.withOpacity(1)),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Colors.grey[350]!.withOpacity(1)),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           // prefixIcon: const Icon(Icons.store_outlined),
//                           hintText: "Thùng, Kg, ...",
//                           errorText: state.countingUnitStatus ==
//                                   CountingUnitStatus.invalid
//                               ? "Không được để trống!"
//                               : null,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

class _DescriptionInput extends StatelessWidget {
  const _DescriptionInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferBloc, TransferState>(
      bloc: BlocProvider.of<TransferBloc>(context),
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: "Mô tả",
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    // TextSpan(text: " *", style: TextStyle(color: Colors.red))
                  ])),
                ),
              ),
              TextFormField(
                minLines: 4,
                maxLines: 5,
                onChanged: (description) {
                  context.read<TransferBloc>().add(
                      TransferChangeDescriptionEvent(description: description));
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
                    hintText: "Mô tả giao dịch"
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

class _ButtonTransfer extends StatefulWidget {
  const _ButtonTransfer({Key? key}) : super(key: key);

  @override
  State<_ButtonTransfer> createState() => _ButtonTransferState();
}

class _ButtonTransferState extends State<_ButtonTransfer> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  void _onPressed() async {
    context.read<TransferBloc>().add(TransferSubmitedEvent());
  }

  void _submitSuccess(context) async {
    _buttonController.success();
    await Future.delayed(const Duration(milliseconds: 1000));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransferBloc, TransferState>(
      bloc: BlocProvider.of<TransferBloc>(context),
      listener: (context, state) {
        switch (state.transferStatus) {
          case TransferStatus.initialize:
            _buttonController.reset();
            break;
          case TransferStatus.loading:
            _buttonController.start();
            break;
          case TransferStatus.success:
            _submitSuccess(context);
            break;
          case TransferStatus.failure:
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
                  "Vận chuyển",
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
