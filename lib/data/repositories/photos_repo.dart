import 'dart:convert';

import 'package:cypress_album/data/model/photos_model.dart';

import '../dataproviders/api/api_provider.dart';

class PhotosRepository {
  final ApiProvider _provider = ApiProvider();

  Future<List<Photos>> fetchPhotosData(int albumId) async {
    final response = await _provider.get("/photos?albumId=$albumId");
    final responseBody = json.decode(response) as List;
    final photos = responseBody.map((e) => Photos.fromJson(e)).toList();
    return photos;
  }
}
