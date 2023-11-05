import 'dart:io';

import 'package:equatable/equatable.dart';

class Campaign extends Equatable {
  final String id;
  final String title;
  final String description;
  final File image;
  final String creatorID;
  final List<String> participants;

  const Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.creatorID,
    required this.participants,
  });

  Campaign copyWith(
      {String? id,
      String? title,
      String? description,
      File? image,
      String? creatorID,
      List<String>? participants}) {
    return Campaign(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      creatorID: creatorID ?? this.creatorID,
      participants: participants ?? this.participants,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        image,
        creatorID,
        participants,
      ];
}
