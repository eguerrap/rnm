// Modelo de ubicación para mapear la respuesta JSON de la API
import '../../domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel({
    required super.name,
    required super.type,
    required super.dimension,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      type: json['type'] ?? '',
      dimension: json['dimension'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'dimension': dimension,
    };
  }
}
