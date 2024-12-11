import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:restaurantapp/utils/settings/app_settings.dart';

bool refreshFailed = false;
Completer<void>? refreshCompleter;
bool logoutDialogVisible = false;

class ApiClient {
  static const bool isDebug = true;
  static final ApiClient _singleton = ApiClient._internal();


  Dio dio = Dio(
    BaseOptions(
      baseUrl: AppSettings.BASE_URL,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  static const int maxRetryAttempts = 1;

  ApiClient._internal() {
    initApiClient();
  }

  factory ApiClient() => _singleton;

  static ApiClient get shared => _singleton;

  void initApiClient() {
    if (isDebug) {
      dio.interceptors.add(PrettyDioLogger(
        request: isDebug,
        requestHeader: isDebug,
        requestBody: isDebug,
        responseBody: isDebug,
        responseHeader: isDebug,
        error: isDebug,
        compact: isDebug,
      ));
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          var connectivityResult = await Connectivity().checkConnectivity();
          if (connectivityResult == ConnectivityResult.none) {
            print('No Internet Connection');
            return handler.reject(
              DioException(
                requestOptions: options,
                error: 'No Internet Connection',
                type: DioExceptionType.cancel,
              ),
              true,
            );
          } else {
            options.headers['Content-Type'] = 'application/json';

            print('Headers: ${options.headers}');
            return handler.next(options);
          }
        },
        onError: (DioException e, handler) async {
          print("Error: ${e.response?.statusCode}");
        },
      ),
    );
  }}
