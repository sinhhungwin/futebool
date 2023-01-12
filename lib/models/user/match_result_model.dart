import 'package:equatable/equatable.dart';

class MatchResult extends Equatable {
  final int opponentId;
  final int elo;
  final bool result;

  const MatchResult(
      {required this.opponentId, required this.elo, required this.result});

  @override
  List<Object?> get props => [opponentId, elo, result];
}
