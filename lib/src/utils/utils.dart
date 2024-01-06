import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

void dioErrorHandle({
  required Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, response.data['msg']);
      break;
    case 500:
      showSnackBar(context, response.data['error']);
      break;
    default:
      showSnackBar(context, response.data.toString());
  }
}
