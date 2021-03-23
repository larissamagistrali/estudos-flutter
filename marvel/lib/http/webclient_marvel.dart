import 'dart:convert';
import 'package:marvel/http/webclient.dart';
import 'package:marvel/models/marvel_response.dart';

class MarvelWebClient {
  Future<MarvelResponse> fetch() async {
    final uri = Uri.http(baseUrl, 'current', {
      "apikey": apiPublicKey,
      "ts": ts,
      "hash": hash,
      "limit": '20',
      "offset": '0'
    });
    final response = await client.get(uri);
    final json = jsonDecode(response.body);
    return MarvelResponse.fromJson(json);
  }
}
