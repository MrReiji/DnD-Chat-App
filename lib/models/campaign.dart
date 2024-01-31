import 'dart:io';

import 'package:equatable/equatable.dart';

/// Represents a campaign model.
///
/// A campaign is a collection of information including its unique [id],
/// [title], [description], [image], [creatorID], and [participants].
///
/// - The [id] is a unique identifier for the campaign.
/// - The [title] is the title of the campaign.
/// - The [description] is a brief description of the campaign.
/// - The [image] is the image associated with the campaign.
/// - The [creatorID] is the ID of the user who created the campaign.
/// - The [participants] is a list of IDs of the users participating in the campaign.
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
