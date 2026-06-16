import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:food_app_task/features/auth/presentation/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../error/error.dart';
import '../utils/app_constants.dart';
import '../widgets/snackbar.dart';
import 'api_client_interface.dart';

class ApiClient extends GetxService implements ApiClientInterface {
  final FlutterSecureStorage storage;
  final String baseUrl;
  final int timeoutInSeconds = 120;

  ApiClient({required this.storage, required this.baseUrl});

  bool _credentialsLoaded = false;
  Future<void> _loadCredentials() async {
    if (_credentialsLoaded) return;
    token = await storage.read(key: 'token');
    String? languageCode = await storage.read(key: 'language_code');
    updateHeader(token ?? '', languageCode: languageCode);
    _credentialsLoaded = true;
  }

  http.Client? _client;
  Map<String, String> _mainHeaders = {"Content-Type": "application/json", 'Accept': 'application/json'};

  @override
  String? token;

  @override
  void updateHeader(String token, {String? languageCode}) {
    this.token = token;
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'localization': languageCode ?? 'en',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<void> cancelRequest() async {
    _client?.close();
    _client = null;
    debugPrint('====> API request canceled');
  }

  Future<http.Response?> _request(
    String method,
    String uri, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  }) async {
    await _loadCredentials();
    Uri url = Uri.parse('$baseUrl$uri').replace(queryParameters: queryParams);
    try {
      _printData(url.toString(), body: body);
      _client = http.Client();
      http.Response response;
      final requestHeaders = {..._mainHeaders, ...?headers};
      switch (method) {
        case 'GET':
          response = await _client!.get(url, headers: requestHeaders);
          break;
        case 'POST':
          response = await _client!.post(url, body: jsonEncode(body), headers: requestHeaders);
          break;
        case 'PUT':
          response = await _client!.put(url, body: jsonEncode(body), headers: requestHeaders);
          break;
        case 'DELETE':
          response = await _client!.delete(url, headers: requestHeaders);
          break;
        default:
          throw UnsupportedError("HTTP method not supported");
      }
      hideLoading();

      return await _handleResponse(response, url.toString());
    } catch (e) {
      developer.log('❌ API Request Exception', name: 'ApiClient', error: e, stackTrace: StackTrace.current);
      _socketException(e);
      return null;
    } finally {
      _client = null;
    }
  }

  @override
  Future<http.Response?> get(String uri, {Map<String, String>? headers, Map<String, String>? queryParams}) =>
      _request('GET', uri, headers: headers, queryParams: queryParams);

  //dp not use _request() here because this is for full url request
  @override
  Future<http.Response?> getNOBase(Uri url) async {
    try {
      _client = http.Client();
      final response = await _client!.get(url).timeout(const Duration(seconds: 10));
      return await _handleResponse(response, url.toString());
    } catch (e) {
      developer.log('❌ API Request Exception (No Base)', name: 'ApiClient', error: e, stackTrace: StackTrace.current);
      _socketException(e);
      return null;
    } finally {
      _client = null;
    }
  }

  @override
  Future<http.Response?> post(String uri, Map<String, dynamic> body, {Map<String, String>? headers}) =>
      _request('POST', uri, body: body, headers: headers);

  @override
  Future<http.Response?> put(String uri, Map<String, dynamic> body, {Map<String, String>? headers}) =>
      _request('PUT', uri, body: body, headers: headers);

  @override
  Future<http.Response?> postMultipartData(
    String uri,
    List<MultipartBody> multipartBody,
    Map<String, dynamic>? body, {
    Map<String, dynamic>? headers,
  }) async {
    await _loadCredentials();
    Uri url = Uri.parse(AppConstants.baseUrl + uri);
    try {
      debugPrint('====> API Body: $body');
      http.MultipartRequest request = http.MultipartRequest('POST', url);
      request.headers.addAll({..._mainHeaders, if (headers != null) ...headers.map((key, value) => MapEntry(key, value.toString()))});
      for (MultipartBody multipart in multipartBody) {
        File file = File(multipart.file.path);
        request.files.add(
          http.MultipartFile(multipart.key, file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last),
        );
      }
      if (body != null) {
        request.fields.addAll(body.map((key, value) => MapEntry(key, value.toString())));
      }

      final streamedResponse = await request.send().timeout(Duration(seconds: timeoutInSeconds));
      final response = await http.Response.fromStream(streamedResponse);
      hideLoading();

      return _handleResponse(response, url.toString());
    } catch (e) {
      developer.log('❌ Multipart Upload Exception', name: 'ApiClient', error: e, stackTrace: StackTrace.current);
      _socketException(e);
      return null;
    }
  }

  @override
  Future<http.Response?> delete(String uri, {Map<String, String>? headers}) => _request('DELETE', uri, headers: headers);

  @override
  Future<Uint8List?> downloadImage(String uri) async {
    await _loadCredentials();
    try {
      _printData(uri);
      final response = await http.get(Uri.parse(uri), headers: _mainHeaders).timeout(Duration(seconds: timeoutInSeconds));
      return response.statusCode == 200
          ? Uint8List.fromList(response.bodyBytes)
          : _handleError(jsonDecode(response.body), uri, response.statusCode);
    } catch (e) {
      developer.log('❌ Image Download Exception', name: 'ApiClient', error: e, stackTrace: StackTrace.current);
      _socketException(e);
      return null;
    }
  }

  void _printData(String url, {Map<String, dynamic>? body}) {
    debugPrint('====> API Call: $url, ====> Headers: $_mainHeaders');
    if (body != null) debugPrint('====> Body: $body');
  }

  Future<http.Response?> _handleResponse(http.Response response, String url) async {
    // hideLoading();
    if (response.statusCode == 200) {
      return response;
    } else {
      // Log error response details
      developer.log('❌ API Error Response', name: 'ApiClient');
      developer.log('URL: $url', name: 'ApiClient');
      developer.log('Status Code: ${response.statusCode}', name: 'ApiClient');
      developer.log('Headers: ${response.headers}', name: 'ApiClient');
      developer.log('Response Body: ${response.body}', name: 'ApiClient');

      try {
        return _handleError(jsonDecode(response.body), url, response.statusCode);
      } catch (e) {
        developer.log('❌ Failed to parse error response', name: 'ApiClient');
        developer.log('Raw body: ${response.body}', name: 'ApiClient');
        developer.log('Parse error: $e', name: 'ApiClient');
        showToast('Server error: ${response.statusCode}');
        return null;
      }
    }
  }

  dynamic _handleError(Map<String, dynamic> body, String url, int statusCode) {
    developer.log('🔴 API Error Handler', name: 'ApiClient');
    developer.log('URL: $url', name: 'ApiClient');
    developer.log('Status Code: $statusCode', name: 'ApiClient');
    developer.log('Error Body: ${jsonEncode(body)}', name: 'ApiClient');

    // Check for message field
    if (body.containsKey('message')) {
      String message = body['message'];
      developer.log('📝 Error Message: $message', name: 'ApiClient');

      // Check if data field contains the actual error message
      if (body.containsKey('data') && body['data'] is String && body['data'].isNotEmpty) {
        String dataMessage = body['data'];
        developer.log('📋 Error Data: $dataMessage', name: 'ApiClient');
        showToast(dataMessage); // Show the actual error from data field
      } else {
        showToast(message); // Show the generic message
      }

      if (message == "Unauthenticated") {
        developer.log('🚪 User unauthenticated - logging out', name: 'ApiClient');
        // TODO: Implement AuthController to handle logout
        // AuthController.find.logout();
      }
    }

    // Try to parse structured errors array
    try {
      ErrorResponse response = ErrorResponse.fromJson(body);
      if (response.errors.isNotEmpty) {
        developer.log('⚠️ Error Details: ${response.errors.first.message}', name: 'ApiClient');
        // Only show if we haven't already shown a message from data field
        if (!body.containsKey('data') || body['data'] is! String) {
          showToast(response.errors.first.message);
        }
      } else {
        developer.log('⚠️ No errors in ErrorResponse', name: 'ApiClient');
      }
    } catch (e) {
      developer.log('❌ Failed to parse ErrorResponse', name: 'ApiClient');
      developer.log('Parse error: $e', name: 'ApiClient');
    }

    return null;
  }

  void _socketException(Object e) {
    hideLoading();

    if (e is SocketException) {
      developer.log('🌐 Network Error', name: 'ApiClient', error: 'SocketException: ${e.message}');
      showToast('Please check your internet connection');
    } else {
      developer.log('⚠️ Unknown Exception', name: 'ApiClient', error: e, stackTrace: StackTrace.current);
      // showToast('Something went wrong');
    }
  }
}
