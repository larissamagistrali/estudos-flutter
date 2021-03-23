import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

final client = http.Client();

String parameter = 'Spider-Man';
final ts = DateTime.now().millisecondsSinceEpoch;
const String apiPublicKey = 'a2fde8113679aa4bb661c6518a83ef82';
const String apiPrivateKey = '73d921ed9cb20b9eccfc908326f6ecbe63b7850e';
dynamic concat = '$ts$apiPrivateKey$apiPublicKey';
String hash = md5.convert(utf8.encode(concat)).toString();
String urlMarvel =
    'http://gateway.marvel.com/v1/public/characters?ts=$ts&apikey=$apiPublicKey&hash=$hash';
