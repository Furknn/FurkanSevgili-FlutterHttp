import 'dart:convert';
import 'dart:io';

import 'package:planets/Planets/model/ErrorModel.dart';
import 'package:planets/Planets/model/PlanetModel.dart';
import 'package:planets/Planets/service/IPlanetService.dart';
import 'package:http/http.dart' as http;

import '../model/PlanetModel.dart';

class PlanetService extends IPlanetService {
  final url = "http://192.168.1.106:3000";

  Future _httpGet(String path) async {
    try {
      final response = await http.get(url);
      if (response is http.Response) {
        switch (response.statusCode) {
          case HttpStatus.ok:
            return _bodyParser(response.body);

          default:
            throw ErrorModel(response.body);
        }
      }
      return response;
    } catch (e) {
      return ErrorModel("see");
    }
  }

  dynamic _bodyParser(String body) {
    final jsonBody = jsonDecode(body);
    if (jsonBody is List) {
      return jsonBody
          .map((e) => PlanetModel.fromJson(e))
          .cast<PlanetModel>()
          .toList();
    } else if (jsonBody is Map) {
      return PlanetModel.fromJson(jsonBody);
    } else {
      return jsonBody;
    }
  }

  @override
  Future<List<PlanetModel>> getPlanetList() async {
    return await _httpGet(url);
  }
}
