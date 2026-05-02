import 'dart:convert';
import 'package:http/http.dart' as http;
import '../errors/exception.dart';

abstract class BaseApiClient {
  Future<http.Response> get({
    required String url,
    Map<String, String>? headers,
  });

  Future<http.Response> post({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  });
}

class ApiClient implements BaseApiClient {

  @override
  Future<http.Response> get({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      return _handleResponse(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<http.Response> post({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers ?? {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
  // The server respons operation
  http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw ServerException(
        message: response.body,
        statusCode: response.statusCode,
      );
    }
  }
}