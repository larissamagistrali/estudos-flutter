import 'dart:convert';
import 'package:marvel/http/webclient.dart';
import 'package:marvel/models/marvel_response.dart';
import 'package:http/http.dart' as http;

class MarvelWebClient {
  Future<MarvelResponsePersonagem> fetch() async {
    dynamic uri = Uri.parse(urlMarvel);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response : ${response.headers}');
    // print('Response body: ${response.body}');

    return MarvelResponsePersonagem.fromJson(json);
  }
}
