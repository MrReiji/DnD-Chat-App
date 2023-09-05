import 'package:faker/faker.dart';

class AppFaker {
  final Faker faker = Faker();

  String generatePlaceholderImage() {
    final placeholderImage = faker.image.image(
      keywords: ['Dungeons and Dragons'],
      random: true,
    );
    return placeholderImage;
  }
}
