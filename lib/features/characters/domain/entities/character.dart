// Entidad de personaje que representa los datos básicos del personaje
import 'package:equatable/equatable.dart';
import 'location.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final Location origin;
  final Location location;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,    
    required this.gender,
    required this.image,
    required this.origin,
    required this.location,
    required this.type,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'] ?? '',
      gender: json['gender'],
      image: json['image'],
      origin: Location.fromJson(json['origin']),
      location: Location.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'image': image,
      'origin': origin.toJson(),
      'location': location.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        image,
        origin,
        location,
      ];
}
