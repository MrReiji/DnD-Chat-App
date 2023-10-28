import 'dart:io';

import 'package:equatable/equatable.dart';

class Campaign extends Equatable {
  final String id;
  final String title;
  final String description;
  final File image;
  final String creatorID;

  const Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.creatorID,
  });

  Campaign copyWith({
    String? id,
    String? title,
    String? description,
    File? image,
    String? creatorID,
  }) {
    return Campaign(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        creatorID: creatorID ?? this.creatorID);
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        image,
        creatorID,
      ];
}
