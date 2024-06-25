import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String name;
  final String type;
  final String dimension;

  const Location({
    required this.name,
    required this.type,
    required this.dimension,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      type: json['type'],
      dimension: json['dimension'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'dimension': dimension,
    };
  }

  @override
  List<Object> get props => [name, type, dimension];
}
