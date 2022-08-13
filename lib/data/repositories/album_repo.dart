import 'dart:convert';

import 'package:cypress_album/data/model/albums_model.dart';

import '../dataproviders/api/api_provider.dart';

class AlbumsRepository {
  final ApiProvider _provider = ApiProvider();

  Future<List<Albums>> fetchAlbumsData() async {
    final response = await _provider.get("/albums");
    final responseBody = json.decode(response) as List;
    final albums = responseBody.map((e) => Albums.fromJson(e)).toList();
    return albums;
  }
}
