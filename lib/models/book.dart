import 'package:flutter/foundation.dart';

class Book {
  final String? id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final ValueNotifier<bool> _isFavorite;
  Book({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    isFavorite = false,
  }) : _isFavorite = ValueNotifier(isFavorite);

  set isFavorite(bool newValue) {
    _isFavorite.value = newValue;
  }

  bool get isFavorite {
    return _isFavorite.value;
  }

  ValueNotifier<bool> get isFavoriteListenable {
    return _isFavorite;
  }

  Book copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Book(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl
    };
  } 

  static Book fromJson(Map<String, dynamic> json){
    return Book(   
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl']
    );
  }
}
