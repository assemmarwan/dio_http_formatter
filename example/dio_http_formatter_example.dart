import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';

void main() async {
  final _dio = Dio();

  _dio.interceptors.add(HttpFormatter());

  await _dio.get('https://example.com');
}
