import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/blocs/home/views/bloc/home_event.dart';

import 'bloc/home_bloc.dart';
import 'bloc/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeInitEvent()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Trang chủ"),
      //   centerTitle: true,
      //   elevation: 1,
      // ),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [_InfoCompany()]),
      ),
    );
  }
}

class _InfoCompany extends StatelessWidget {
  const _InfoCompany();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: BlocProvider.of<HomeBloc>(context),
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 40),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                state.linkImageCompany == null || state.linkImageCompany == ""
                    ? Image.asset(
                        "assets/images/icon_bussiness.png",
                        height: 140,
                        width: 140,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        state.linkImageCompany ?? "",
                        height: 140,
                        width: 140,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          "assets/images/icon_bussiness.png",
                          height: 140,
                          width: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    state.name ?? "??",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const _ScanForSupplyChain()),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const _History()),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _History extends StatelessWidget {
  const _History();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.grey[300],
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("/transfer_history");
            },
            child: Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Lịch sử giao dịch",
                )),
          )),
    );
  }
}

class _ScanForSupplyChain extends StatelessWidget {
  const _ScanForSupplyChain();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.grey[300],
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/scan');
            },
            child: Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Truy xuất chuỗi cung ứng sản phẩm",
                )),
          )),
    );
  }
}
