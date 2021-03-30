import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel/models/marvel_response.dart';

showMyDialog(BuildContext context, MarvelApiResponse response, index) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.lightBlue[900],
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        title: Text(response.data.results[index].name),
        content:
            Image.network(response.data.results[index].thumbnail.getFoto()),
      );
    },
  );
}
