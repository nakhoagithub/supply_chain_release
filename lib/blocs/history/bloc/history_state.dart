import 'package:equatable/equatable.dart';
import 'package:supply_chain/models/history.dart';

import '../../../enum.dart';

class HistoryState extends Equatable {
  final HistoryStatus? historyStatus;
  final List<History>? histories;
  final int? statusFile;
  const HistoryState({
    required this.historyStatus,
    this.histories,
    this.statusFile,
  });

  HistoryState copyWith({
    HistoryStatus? historyStatus,
    List<History>? histories,
    int? statusFile,
  }) {
    return HistoryState(
      historyStatus: historyStatus ?? this.historyStatus,
      histories: histories ?? this.histories,
      statusFile: statusFile ?? this.statusFile,
    );
  }

  @override
  List<Object?> get props => [historyStatus, histories, statusFile];
}
