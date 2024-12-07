import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageSaver {
  static Future<void> saveImageToGallery(String imageUrl, BuildContext context) async {
    try {

      final Dio dio = Dio();
      final Response<List<int>> response = await dio.get<List<int>>(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      await ImageGallerySaver.saveImage(Uint8List.fromList(response.data!));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('تم حفظ الصورة في معرض الصور بنجاح!'),
        ),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('فشل حفظ الصورة. يرجى المحاولة مرة أخرى.'),
        ),
      );
    }
  }
}