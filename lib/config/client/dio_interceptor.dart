import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pocketgue/utils/utils.dart';


class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logs(
      // ignore: unnecessary_null_comparison
      "REQUEST ► ︎ ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"${options.baseUrl}${options.path}"}",
    );
    debugPrint("Headers:");
    options.headers.forEach((k, v) => debugPrint('► $k: $v'));
    debugPrint("❖ QueryParameters :");
    try {
      options.queryParameters.forEach((k, v) => debugPrint('► $k: $v'));
    } catch (e) {
      debugPrint("Error : $e");
    }
    if (options.data != null) {
      try {
        const JsonEncoder encoder = JsonEncoder.withIndent('  ');
        final String prettyJson = encoder.convert(options.data);
        debugPrint("Body: $prettyJson");
      } catch (e) {
        logs("Error Dio Interceptor $e");
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logs(
      "<-- ${err.message} ${err.response?.requestOptions != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL'}",
    );
    logs(
      "${err.response != null ? err.response!.data : 'Unknown Error'}",
    );
    logs("<-- End error");
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logs(
      // ignore: unnecessary_null_comparison
      "◀ ︎RESPONSE ${response.statusCode} ${response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL'}",
    );
    debugPrint("Headers:");
    response.headers.forEach((k, v) => debugPrint('$k: $v'));

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String prettyJson = encoder.convert(response.data);
    debugPrint("Response: $prettyJson");
    logs("◀ END REQUEST ► ︎");
    super.onResponse(response, handler);
  }
}
