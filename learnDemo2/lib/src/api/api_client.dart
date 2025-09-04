// API客户端基础类

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class ApiClient {
  final http.Client _client;
  final String _baseUrl;

  ApiClient({http.Client? client, String? baseUrl}) 
      : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? AppConfig.baseUrl;

  // 发送GET请求
  Future<Map<String, dynamic>> get(String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    final response = await _client.get(
      uri,
      headers: _buildHeaders(headers),
    ).timeout(
      Duration(seconds: AppConfig.apiTimeout),
    );
    return _handleResponse(response);
  }

  // 发送POST请求
  Future<Map<String, dynamic>> post(String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    final response = await _client.post(
      uri,
      headers: _buildHeaders(headers),
      body: json.encode(body),
    ).timeout(
      Duration(seconds: AppConfig.apiTimeout),
    );
    return _handleResponse(response);
  }

  // 发送PUT请求
  Future<Map<String, dynamic>> put(String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    final response = await _client.put(
      uri,
      headers: _buildHeaders(headers),
      body: json.encode(body),
    ).timeout(
      Duration(seconds: AppConfig.apiTimeout),
    );
    return _handleResponse(response);
  }

  // 发送DELETE请求
  Future<Map<String, dynamic>> delete(String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    final response = await _client.delete(
      uri,
      headers: _buildHeaders(headers),
    ).timeout(
      Duration(seconds: AppConfig.apiTimeout),
    );
    return _handleResponse(response);
  }

  // 构建请求URI
  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParameters) {
    final baseUri = Uri.parse(_baseUrl);
    final path = endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
    
    if (queryParameters == null || queryParameters.isEmpty) {
      return baseUri.replace(path: '${baseUri.path}/$path');
    }
    
    return baseUri.replace(
      path: '${baseUri.path}/$path',
      queryParameters: queryParameters.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );
  }

  // 构建请求头
  Map<String, String> _buildHeaders(Map<String, String>? customHeaders) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }
    
    return headers;
  }

  // 处理响应
  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return json.decode(response.body) as Map<String, dynamic>;
      } catch (e) {
        // 处理JSON解析错误
        throw Exception('Response parsing error: $e');
      }
    } else {
      // 处理HTTP错误
      throw Exception('HTTP Error: ${response.statusCode}, ${response.body}');
    }
  }

  // 释放资源
  void dispose() {
    _client.close();
  }
}