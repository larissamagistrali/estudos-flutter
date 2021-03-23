import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

final client = http.Client();

const String baseUrl = 'https://gateway.marvel.com/v1/public/characters';
var ts = '${DateTime.now().millisecondsSinceEpoch}';
const String apiPublicKey = 'a2fde8113679aa4bb661c6518a83ef82';
const String apiPrivateKey = '73d921ed9cb20b9eccfc908326f6ecbe63b7850e';
String hash =
    md5.convert(utf8.encode('$ts.$apiPrivateKey$apiPublicKey')).toString();
