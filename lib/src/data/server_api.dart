import 'dart:convert';

import 'package:chuck_norris/src/data/models/joke_dto.dart';
import 'package:chuck_norris/src/domain/repositories/preference_repository.dart';
import 'package:http/http.dart' as http;

class ServerApi {
  final PreferenceRepository _preferenceRepository;

  ServerApi(this._preferenceRepository);

  Future<http.Response> getData(
    String endpoint, {
    Map<String, String>? query,
  }) async {
    Uri url = Uri.https(_preferenceRepository.getServerUrl(), endpoint, query);

    dynamic response;
    response = await http.get(url);

    return response;
  }

  Future<List<String>> getAllCategories() async {
    return getData('jokes/categories').then((response) {
      List<String> categoryList = jsonDecode(response.body).cast<String>();
      return categoryList;
    });
  }

  Future<JokeDTO> getJoke(String categoryName) async {
    var response = await getData('jokes/random', query: {"joke": categoryName});

    var body = json.decode(response.body);

    return JokeDTO.fromJson(body);
  }

  Future<List<JokeDTO>> getRandomJokes(String searchQuery) async {
    return getData('jokes/search', query: {"query": searchQuery})
        .then((response) {
      dynamic list = json.decode(response.body)['result'];
      if (list == null) {
        return [];
      }
      return list.map<JokeDTO>((e) => JokeDTO.fromJson(e)).toList();
    });
  }
}
