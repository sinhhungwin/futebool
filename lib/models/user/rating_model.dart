import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final int id;
  final int rating;

  const Rating({required this.id, required this.rating});

  @override
  List<Object?> get props => [id, rating];
}
