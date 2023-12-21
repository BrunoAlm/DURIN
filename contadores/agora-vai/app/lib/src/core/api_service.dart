import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class ApiErro implements Exception {
  final String message;
  final String code;

  ApiErro({
    required this.message,
    required this.code,
  });
}

class ApiService {
  final _client = Dio();
  final String host = "http://contadores.durin.com.br";
  // final String host = "http://localhost:8000";

  Future get({required String path}) async {
    final response = await _client.get("$host$path");
    _handleError(response);
    return response.data;
  }

  Future post({
    required String path,
    required Map<String, dynamic> body,
  }) async {
    _logRequest(body: body, url: "$host$path", method: "post");
    final response = await _client.post(
      "$host$path",
      data: body,
    );
    _handleError(response);
    return response.data;
  }

  Future put({
    required String path,
    required Map<String, dynamic> body,
  }) async {
    _logRequest(body: body, url: "$host$path", method: "put");
    final response = await _client.put(
      "$host$path",
      data: body,
    );
    _handleError(response);
    return response.data;
  }

  void _handleError(Response response) {
    log(
      "---------Response----------\n"
      "-- body: ${json.encode(response.data)} \n"
      "-- status: ${response.statusCode} \n"
      "-- statusMessage: ${response.statusMessage} \n",
      name: "Api",
    );
    if ((response.statusCode ?? 999) > 299) {
      throw ApiErro(
        code: response.data['code'],
        message: response.data['message'],
      );
    }
  }

  void _logRequest(
      {Map body = const {}, required String url, required String method}) {
    log(
      "---------Request----------\n"
      "-- body: ${json.encode(body)} \n"
      "-- url: $url\n"
      "-- method: $method\n",
      name: "Api",
    );
  }
}
