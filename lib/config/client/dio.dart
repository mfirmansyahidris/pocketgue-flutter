import 'package:dio/dio.dart';
import 'package:pocketgue/config/config.dart';

const baseUrl = "https://pokeapi.co/api/v2";

Dio get dio {

  return Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    receiveTimeout: 120000,
    connectTimeout: 120000,
    validateStatus: (int? status) {
      return status! > 0;
    },
  ),
  )..interceptors.add(DioInterceptor());
}