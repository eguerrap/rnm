import '../../domain/entities/character.dart';
import 'location_model.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.status,
    required super.species,    
    required super.gender,
    required super.image,
    required LocationModel super.origin,
    required LocationModel super.location,
    required super.type,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      image: json['image'],
      origin: LocationModel.fromJson(json['origin']),
      location: LocationModel.fromJson(json['location']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'image': image,
      'origin': (origin as LocationModel).toJson(),
      'location': (location as LocationModel).toJson(),
    };
  }
}
