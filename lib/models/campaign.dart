import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Campaign extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageURL;

  Campaign(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageURL});

  Campaign copyWith({
    String? id,
    String? title,
    String? description,
    String? imageURL,
  }) {
    return Campaign(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        imageURL: imageURL ?? this.imageURL);
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageURL,
      ];
}
