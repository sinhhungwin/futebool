import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String xCoordinate;
  final String yCoordinate;
  final String name;

  const Location(
      {required this.xCoordinate,
      required this.yCoordinate,
      required this.name});

  @override
  List<Object?> get props => [xCoordinate, yCoordinate, name];
}
