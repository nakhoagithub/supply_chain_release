import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain/blocs/history/bloc/history_event.dart';
import 'package:supply_chain/enum.dart';
import 'package:supply_chain/models/history.dart';

import '../bloc/history_bloc.dart';
import '../bloc/history_state.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc()..add(HistoryInitEvent()),
      child: const _HistoryView(),
    );
  }
}

class _HistoryView extends StatelessWidget {
  const _HistoryView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Các giao dịch đã xác nhận"),
        centerTitle: true,
        elevation: 1,
        actionsIconTheme: const IconThemeData(color: Colors.black),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              child: _ListTransferHistory(),
            )
          ],
        ),
      ),
    );
  }
}

class _ListTransferHistory extends StatelessWidget {
  const _ListTransferHistory();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      bloc: BlocProvider.of<HistoryBloc>(context),
      builder: (context, state) {
        return state.historyStatus == HistoryStatus.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state.histories == null
                ? const Center(
                    child: Text("Chưa có giao dịch"),
                  )
                : ListView.builder(
                    itemCount: state.histories!.length,
                    itemBuilder: (context, index) {
                      return _ItemHistoryTransfer(
                        history: state.histories![index],
                      );
                    },
                  );
      },
    );
  }
}

class _ItemHistoryTransfer extends StatelessWidget {
  final History history;
  const _ItemHistoryTransfer({
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed("/history_info", arguments: history);
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Text(
                  history.type == "sell" ? "Xuất" : "Nhập",
                  style: TextStyle(
                    color: history.type == "sell"
                        ? Colors.red[300]
                        : Colors.green[900],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Giao dịch: ${history.tx}",
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "Người nhận: ${history.addressBuyer}",
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
