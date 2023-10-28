import 'dart:typed_data';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<File> downloadImage(Uri imageUrl, String id) async {
  final http.Response responseData = await http.get(imageUrl);
  Uint8List uint8list = responseData.bodyBytes;
  var buffer = uint8list.buffer;
  ByteData byteData = ByteData.view(buffer);
  var tempDir = await getTemporaryDirectory();
  return await File('${tempDir.path}/$id').writeAsBytes(
      buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
}
