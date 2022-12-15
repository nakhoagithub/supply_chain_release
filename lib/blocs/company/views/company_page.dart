import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/blocs/company/bloc/company_bloc.dart';
import 'package:supply_chain/blocs/company/bloc/company_event.dart';
import 'package:supply_chain/blocs/company/bloc/company_state.dart';

import '../../../models/company.dart';

class CompanyPage extends StatelessWidget {
  const CompanyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CompanyBloc()..add(CompanyInitEvent()),
        child: const _CompanyView());
  }
}

class _CompanyView extends StatefulWidget {
  const _CompanyView({Key? key}) : super(key: key);

  @override
  State<_CompanyView> createState() => __CompanyViewState();
}

class __CompanyViewState extends State<_CompanyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Công ty"),
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(2),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [Expanded(child: _ListCompany())]),
        ),
      ),
    );
  }
}

class _ListCompany extends StatelessWidget {
  const _ListCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyBloc, CompanyState>(
      buildWhen: (previous, current) =>
          previous.companyStatus != current.companyStatus,
      builder: (context, state) => SingleChildScrollView(
        child: StreamBuilder<List<Company>>(
          stream: state.streamData,
          builder: (context, snapshot) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  // scrollDirection: Axis.vertical,
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return _ItemCompany(
                      name: snapshot.data?[index].name,
                      email: snapshot.data?[index].email,
                      address: snapshot.data?[index].address,
                      addressCompany: snapshot.data?[index].addressCompany,
                      description: snapshot.data?[index].description,
                      linkImage: snapshot.data?[index].linkImage,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ItemCompany extends StatefulWidget {
  final String? name;
  final String? email;
  final String? address;
  final String? addressCompany;
  final String? description;
  final String? linkImage;
  const _ItemCompany({
    Key? key,
    required this.name,
    required this.email,
    required this.address,
    required this.addressCompany,
    required this.description,
    required this.linkImage,
  }) : super(key: key);

  @override
  State<_ItemCompany> createState() => _ItemCompanyState();
}

class _ItemCompanyState extends State<_ItemCompany> {
  void _viewInfoCompany() {
    Company company = Company(
      name: widget.name,
      address: widget.address,
      addressCompany: widget.addressCompany,
      description: widget.description,
      email: widget.email,
      linkImage: widget.linkImage,
    );

    Navigator.of(context).pushNamed('/info_company', arguments: company);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: _viewInfoCompany,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(children: [
            SizedBox(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: widget.linkImage == null || widget.linkImage == ""
                        ? Image.asset(
                            "assets/images/icon_bussiness.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            widget.linkImage ?? "",
                            height: 80,
                            width: 80,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              "assets/images/icon_bussiness.png",
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name ?? "(Tên)",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.all(2),
                              child: Text(
                                widget.email ?? "(address@emailexample.com)",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          Text(
                            widget.addressCompany ?? "(Địa chỉ công ty)",
                            maxLines: 2,
                            style: const TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            widget.description == null || widget.description == ""
                ? Container()
                : Container(
                    margin: const EdgeInsets.all(5),
                    child: Text(
                      widget.description ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
          ]),
        ),
      ),
    );
  }
}
