import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:kapil_add_to_app_flutter/injection_container.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RequestInterceptor extends QueuedInterceptor {
  RequestInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    final isNetworkAvailable = connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;

    if (!isNetworkAvailable) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
        ),
      );
    }

    if (kDebugMode) {
      print(options.data.toString());
    }
    final headerOptions = _generateHeaderOptions(options);
    return handler.next(headerOptions);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(response.toString());
    }
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    //TODO(kaxp): Update the onError

    // When client_id of seatgeek is invalid
    if (err.response?.statusCode == HttpStatus.forbidden) {
      // We can decide/handle the UI/UX flow here, when client_id is invalid.
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          type: DioExceptionType.badCertificate,
        ),
      );
    }

    return handler.next(err);
  }

  RequestOptions _generateHeaderOptions(RequestOptions options) {
    final advisorCode = sdkInitResponse.advisorCode;
    final clientSecret = sdkInitResponse.clientSecret;
    final agentMobile = sdkInitResponse.agentMobile;
    final agentName = sdkInitResponse.agentName;
    final agentEmail = sdkInitResponse.agentEmail;

    final DateTime now = DateTime.now();
    final timeInMs = now.millisecondsSinceEpoch.toString();

    final String input =
        timeInMs + clientSecret + timeInMs + advisorCode + timeInMs;
    final String md5Input = md5.convert(utf8.encode(input)).toString();
    final String signatureMd =
        md5.convert(utf8.encode(md5Input)).toString() + md5Input;
    final String signature =
        md5.convert(utf8.encode(signatureMd)).toString() + signatureMd;

    options.headers.addAll({
      'Accept': 'application/json',
      'content-type': 'application/json',
      'ucode': advisorCode,
      'signature': signature,
      'tcode': timeInMs,
      'agentMobile': agentMobile,
      'agentName': agentName,
      'agentEmail': agentEmail,
    });

    return options;
  }
}
