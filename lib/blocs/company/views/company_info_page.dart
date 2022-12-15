import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/blocs/company/bloc/company_bloc.dart';
import 'package:supply_chain/blocs/company/bloc/company_event.dart';
import 'package:supply_chain/models/company.dart';

import '../../../models/product.dart';
import '../../../widgets/dialog_app.dart';
import '../bloc/company_state.dart';

class CompanyInfoPage extends StatelessWidget {
  const CompanyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Company? company = (ModalRoute.of(context)?.settings.arguments) as Company;
    return BlocProvider(
      create: (context) => CompanyBloc(),
      child: _CompanyInfoView(
        company: company,
      ),
    );
  }
}

class _CompanyInfoView extends StatelessWidget {
  final Company? company;
  const _CompanyInfoView({
    required this.company,
  });

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
              children: [
                const _Title(),
                _Info(company: company),
                _ProductOfCompany(address: company!.address),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_rounded)),
          const Text(
            "Thông tin",
            style: TextStyle(fontSize: 26, color: Colors.black87),
          ),
          const Text(
            "Thông tin của các thành viên trong hệ thống.",
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _Info extends StatefulWidget {
  final Company? company;
  const _Info({
    required this.company,
  });

  @override
  State<_Info> createState() => _InfoState();
}

class _InfoState extends State<_Info> {
  void _copyAddress() {
    if (widget.company != null) {
      Clipboard.setData(ClipboardData(text: widget.company!.address));
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.company == null
        ? const Center(
            child: Text("Không có thông tin"),
          )
        : Column(
            children: [
              widget.company!.linkImage == null ||
                      widget.company!.linkImage == ""
                  ? Image.asset(
                      "assets/images/icon_bussiness.png",
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.network(
                        widget.company!.linkImage ?? "",
                        height: 80,
                        width: 80,
                      ),
                    )
                  : Image.network(
                      widget.company!.linkImage ?? "",
                      height: 80,
                      width: 80,
                    ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    widget.company!.name ?? "??",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.company!.address ?? "??",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue[900],
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: _copyAddress,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  margin: const EdgeInsets.all(5),
                                  child: const Icon(
                                    Icons.copy,
                                    size: 18,
                                  ))),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Địa chỉ: ${widget.company!.addressCompany ?? "??"}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}

class _ProductOfCompany extends StatefulWidget {
  final String? address;
  const _ProductOfCompany({required this.address});

  @override
  State<_ProductOfCompany> createState() => _ProductOfCompanyState();
}

class _ProductOfCompanyState extends State<_ProductOfCompany> {
  @override
  void initState() {
    super.initState();
    context
        .read<CompanyBloc>()
        .add(ProductCompanyEvent(address: widget.address ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyBloc, CompanyState>(
      bloc: BlocProvider.of<CompanyBloc>(context),
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Sản phẩm:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: state.productOfCompanyWithAddress == null
                  ? Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : state.productOfCompanyWithAddress!.isEmpty
                      ? const Center(
                          child: Text("Chưa có sản phẩm"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: state.productOfCompanyWithAddress!.length,
                          itemBuilder: (context, index) {
                            return _ItemProductOfCompany(
                                product:
                                    state.productOfCompanyWithAddress![index]);
                          },
                        ),
            ),
          ]),
        );
      },
    );
  }
}

class _ItemProductOfCompany extends StatefulWidget {
  final Product product;
  const _ItemProductOfCompany({required this.product});

  @override
  State<_ItemProductOfCompany> createState() => _ItemProductOfCompanyState();
}

class _ItemProductOfCompanyState extends State<_ItemProductOfCompany> {
  // void openBottomSheetProduct(
  //     context, CompanyBloc bloc, String? keyProduct, String nameProduct) {
  //   showModalBottomSheet(
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(10),
  //         topRight: Radius.circular(10),
  //       ),
  //     ),
  //     clipBehavior: Clip.antiAliasWithSaveLayer,
  //     context: context,
  //     builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Container(
  //               margin: const EdgeInsets.all(10),
  //               child: Text(
  //                 "Sản phẩm $nameProduct",
  //                 style: const TextStyle(fontSize: 20),
  //               ),
  //             ),
  //             keyProduct == null
  //                 ? const Center(
  //                     child: Text("Sản phẩm có sự cố"),
  //                   )
  //                 : _MenuRequestProduct(idProduct: keyProduct, bloc: bloc),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        // onTap: () {
        //   openBottomSheetProduct(
        //     context,
        //     BlocProvider.of<CompanyBloc>(context),
        //     widget.product.id,
        //     widget.product.name,
        //   );
        // },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            widget.product.linkImage == null || widget.product.linkImage == ""
                ? Image.asset(
                    "assets/images/icon_product.png",
                    height: 80,
                    width: 80,
                  )
                : Image.network(
                    widget.product.linkImage ?? "",
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
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 5),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        widget.product.description ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

// class _MenuRequestProduct extends StatelessWidget {
//   final String idProduct;
//   final CompanyBloc bloc;
//   const _MenuRequestProduct(
//       {Key? key, required this.idProduct, required this.bloc})
//       : super(key: key);

//   void _buyProduct(BuildContext context) {
//     openDialog(context, message: "Mua sản phẩm", yes: "Mua", no: "Không",
//         onPressed: () {
//       bloc.add(BuyProductOfCompany(idProduct: idProduct));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         _buyProduct(context);
//       },
//       child: Row(
//         children: [
//           Container(
//             margin: const EdgeInsets.all(10),
//             child: Icon(
//               Icons.shopping_cart,
//               size: 18,
//               color: Colors.green[800],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.all(10),
//             child: Text(
//               "Mua sản phẩm",
//               style: TextStyle(fontSize: 16, color: Colors.green[800]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
