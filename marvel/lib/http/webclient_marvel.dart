import 'dart:convert';
import 'package:marvel/http/webclient.dart';
import 'package:marvel/models/marvel_response.dart';
import 'package:http/http.dart' as http;

class MarvelWebClient {
  Future<MarvelApiResponse> fetch(offset, limit) async {
    dynamic uri = Uri.parse(
        'http://gateway.marvel.com/v1/public/characters?ts=$ts&apikey=$apiPublicKey&hash=$hash&limit=$limit&offset=$offset');
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response : ${response.headers}');
    // print('Response body: ${response.body}');
    return MarvelApiResponse.fromJson(json);
  }
}
