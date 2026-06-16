import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';

class MultipartBody {
  String key;
  XFile file;
  MultipartBody(this.key, this.file);
}

abstract class ApiClientInterface {
  String? token;

  void updateHeader(String token, {String? languageCode});

  Future<void> cancelRequest();
  Future<Response?> postMultipartData(
    String uri,
    List<MultipartBody> multipartBody,
    Map<String, dynamic>? body, {
    Map<String, dynamic>? headers,
  });
  Future<Response?> get(String uri, {Map<String, String>? headers, Map<String, String>? queryParams});
  Future<Response?> getNOBase(Uri url);

  Future<Response?> post(String url, Map<String, dynamic> body, {Map<String, String>? headers});

  Future<Response?> put(String url, Map<String, dynamic> body, {Map<String, String>? headers});

  Future<Response?> delete(String url, {Map<String, String>? headers});

  Future<Uint8List?> downloadImage(String uri);
}
