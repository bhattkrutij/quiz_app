import 'dart:async';

import 'package:http/http.dart' show Client;

import '../model/response_model.dart';

class ApiService {
  final String baseUrl =
      "https://quizapi.io/api/v1/questions?apiKey=F9MkiwyCJhWufKoAscZGQwTdNdB4RjzNBO2jEUQQ&category=linux&difficulty=Hard&limit=20";
  Client client = Client();
  Future<List<Response>> getQuizData() async {
    final response = await client.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      //  print("response code 200${responseFromJson(response.body)}");
      List<Response> items = responseFromJson(response.body);
      return items;
    }
    return [];
  }
}
