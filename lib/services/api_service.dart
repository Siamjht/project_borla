import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:http/http.dart';
import 'package:mime/mime.dart';
import 'package:project_borla/features/auth/login_screen.dart';
import '../helpers/prefs_helper.dart';
import '../models/api_response_model.dart';
import '../utils/app_texts.dart';


enum HttpMethod { get, post, put, patch, delete }

class ApiService {
  static const int timeOut = 30;

  /// Get default headers
  static Map<String, String> _getHeaders({Map<String, String>? customHeaders, bool isMultipart = false}) {
    Map<String, String> defaultHeaders = {
      'Authorization': "Bearer ${PrefsHelper.token}",
      if (!isMultipart) 'Content-Type': 'application/json', // ✅ skip for multipart
      'Accept': 'application/json',
    };

    if (customHeaders != null) {
      defaultHeaders.addAll(customHeaders);
    }

    return defaultHeaders;
  }

  /// Log request details (only in debug mode)
  static void _logRequest(HttpMethod method, String url, {dynamic body, Map<String, String>? headers}) {
    if (kDebugMode) {
      log("========================================");
      log("🔵 ${method.name.toUpperCase()} Request");
      log("📍 URL: $url");
      if (headers != null) log("📋 Headers: $headers");
      if (body != null) log("📦 Body: $body");
      log("========================================");
    }
  }

  /// Log response details (only in debug mode)
  static void _logResponse(int statusCode, dynamic body) {
    if (kDebugMode) {
      log("========================================");
      log("🟢 Response Status: $statusCode");
      log("📥 Response Body: $body");
      log("========================================");
    }
  }

  /// Handle API errors
  static ApiResponseModel _handleError(dynamic error) {
    if (error is SocketException) {
      return ApiResponseModel(503, AppStrings.noInternetConnection, {});
    } else if (error is FormatException) {
      return ApiResponseModel(400, AppStrings.badResponseRequest, {});
    } else if (error is TimeoutException) {
      return ApiResponseModel(408, AppStrings.requestTimeOut, {});
    } else {
      return ApiResponseModel(400, error.toString(), {});
    }
  }

  /// Handle response based on status code
  static ApiResponseModel _handleResponse(http.Response response) {
    Map<String, dynamic> data = {};

    try {
      data = jsonDecode(response.body);
    } catch (e) {
      data = {'message': 'Invalid response format', 'error': e.toString()};
    }

    _logResponse(response.statusCode, data);

    String message = data['message'] ?? 'No message';

    switch (response.statusCode) {
      case 200:
      case 201:
        return ApiResponseModel(200, message, data);

      case 401:
        PrefsHelper.removeAllPrefData();
        Get.offAll(LoginScreen());
        return ApiResponseModel(response.statusCode, message, data);

      case 400:
      case 404:
      case 500:
        return ApiResponseModel(response.statusCode, message, data);

      default:
        return ApiResponseModel(response.statusCode, message, data);
    }
  }

  ///<<<======================== Universal HTTP Request ==============================>>>

  static Future<ApiResponseModel> request({
    required String url,
    required HttpMethod method,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    final requestHeaders = _getHeaders(customHeaders: headers);
    _logRequest(method, url, body: body, headers: requestHeaders);

    try {
      http.Response response;

      // Encode body if it's a Map
      final encodedBody = body != null && body is Map ? jsonEncode(body) : body;

      switch (method) {
        case HttpMethod.get:
          response = await http
              .get(Uri.parse(url), headers: requestHeaders)
              .timeout(const Duration(seconds: timeOut));
          break;

        case HttpMethod.post:
          response = await http
              .post(Uri.parse(url), body: encodedBody, headers: requestHeaders)
              .timeout(const Duration(seconds: timeOut));
          break;

        case HttpMethod.put:
          response = await http
              .put(Uri.parse(url), body: encodedBody, headers: requestHeaders)
              .timeout(const Duration(seconds: timeOut));
          break;

        case HttpMethod.patch:
          response = await http
              .patch(Uri.parse(url), body: encodedBody, headers: requestHeaders)
              .timeout(const Duration(seconds: timeOut));
          break;

        case HttpMethod.delete:
          response = await http
              .delete(Uri.parse(url), body: encodedBody, headers: requestHeaders)
              .timeout(const Duration(seconds: timeOut));
          break;
      }

      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  ///<<<======================== Convenience Methods (Optional - for backward compatibility) ==============================>>>

  static Future<ApiResponseModel> get(String url, {Map<String, String>? headers}) {
    return request(url: url, method: HttpMethod.get, headers: headers);
  }

  static Future<ApiResponseModel> post(String url, {dynamic body, Map<String, String>? headers}) {
    return request(url: url, method: HttpMethod.post, body: body, headers: headers);
  }

  static Future<ApiResponseModel> put(String url, {dynamic body, Map<String, String>? headers}) {
    return request(url: url, method: HttpMethod.put, body: body, headers: headers);
  }

  static Future<ApiResponseModel> patch(String url, {dynamic body, Map<String, String>? headers}) {
    return request(url: url, method: HttpMethod.patch, body: body, headers: headers);
  }

  static Future<ApiResponseModel> delete(String url, {dynamic body, Map<String, String>? headers}) {
    return request(url: url, method: HttpMethod.delete, body: body, headers: headers);
  }

  ///<<<======================== Multipart Request (Single Image) ==============================>>>

  static Future<ApiResponseModel> multipartRequest({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    HttpMethod method = HttpMethod.post,
    String? imagePath,
    String imageName = 'image',
  }) async {
    try {

      final requestHeaders = _getHeaders(customHeaders: headers, isMultipart: true);

      _logRequest(method, url, body: body, headers: requestHeaders);
      if (imagePath != null) log("📸 Image Path: $imagePath");

      var request = http.MultipartRequest(method.name.toUpperCase(), Uri.parse(url));

      // Add fields
      body.forEach((key, value) {
        if (value is Map || value is List) {
          request.fields[key] = jsonEncode(value);
        } else {
          request.fields[key] = value.toString();
        }
      });

      // Add image if provided
      if (imagePath != null && imagePath.isNotEmpty) {
        File imageFile = File(imagePath);

        if (!await imageFile.exists()) {
          return ApiResponseModel(400, "Image file does not exist", {});
        }

        String mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';

        var multipartFile = await http.MultipartFile.fromPath(
          imageName,
          imagePath,
          contentType: http.MediaType.parse(mimeType),
        );

        request.files.add(multipartFile);
      }

      // Add headers
      request.headers.addAll(requestHeaders);

      // Send request
      var streamedResponse = await request
          .send()
          .timeout(const Duration(seconds: timeOut));

      // Get response
      var response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);

    } catch (e) {
      return _handleError(e);
    }
  }

  ///<<<======================== Multipart Request (Multiple Images) ==============================>>>

  static Future<ApiResponseModel> multipartRequestWithMultipleImages({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    HttpMethod method = HttpMethod.post,
    List<Map<String, String>>? imageList,
  }) async {
    try {

      final requestHeaders = _getHeaders(customHeaders: headers, isMultipart: true);

      _logRequest(method, url, body: body, headers: requestHeaders);
      if (imageList != null) log("📸 Images Count: ${imageList.length}");

      var request = http.MultipartRequest(method.name.toUpperCase(), Uri.parse(url));

      // Add fields
      body.forEach((key, value) {
        if (value is Map) {
          // ✅ Flatten nested Map into dot/bracket notation
          value.forEach((k, v) {
            request.fields['$key[$k]'] = v.toString();
          });
        } else if (value is List) {
          // ✅ Flatten List into indexed bracket notation
          for (int i = 0; i < value.length; i++) {
            request.fields['$key[$i]'] = value[i].toString();
          }
        } else {
          request.fields[key] = value.toString();
        }
      });

      // Add images if provided
      if (imageList != null && imageList.isNotEmpty) {
        for (var image in imageList) {
          String? imagePath = image['imagePath'];
          String? imageName = image['imageName'];

          if (imagePath == null || imageName == null) continue;

          File imageFile = File(imagePath);

          if (!await imageFile.exists()) {
            log("⚠️ Image not found: $imagePath");
            continue;
          }

          String mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';

          var multipartFile = await http.MultipartFile.fromPath(
            imageName,
            imagePath,
            contentType: MediaType.parse(mimeType),
          );

          request.files.add(multipartFile);
          log("✅ Added image: $imageName");
        }
      }

      // Add headers
      request.headers.addAll(requestHeaders);

      // Send request
      var streamedResponse = await request
          .send()
          .timeout(const Duration(seconds: timeOut));

      // Get response
      var response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);

    } catch (e) {
      return _handleError(e);
    }
  }

  ///<<<======================== Download File ==============================>>>

  static Future<ApiResponseModel> downloadFile({
    required String url,
    required String savePath,
    Map<String, String>? headers,
  }) async {
    try {
      final requestHeaders = _getHeaders(customHeaders: headers);
      _logRequest(HttpMethod.get, url, headers: requestHeaders);

      final response = await http
          .get(Uri.parse(url), headers: requestHeaders)
          .timeout(const Duration(seconds: timeOut));

      if (response.statusCode == 200) {
        File file = File(savePath);
        await file.writeAsBytes(response.bodyBytes);

        return ApiResponseModel(
          200,
          'File downloaded successfully',
          {'filePath': savePath},
        );
      } else {
        return ApiResponseModel(
          response.statusCode,
          'Failed to download file',
          {},
        );
      }
    } catch (e) {
      return _handleError(e);
    }
  }
}