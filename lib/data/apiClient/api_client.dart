import 'package:dio/dio.dart';
import 'package:testlogin/core/app_export.dart';
import 'package:testlogin/core/utils/progress_dialog_utils.dart';
import 'package:testlogin/data/models/loginAccount/post_login_account_resp.dart';

import 'network_interceptor.dart';

class ApiClient {
  factory ApiClient() {
    return _apiClient;
  }

  ApiClient._internal();

  var url = "https://seere.somee.com";

  static final ApiClient _apiClient = ApiClient._internal();

  final _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      headers: {"Content-Type": "application/json"}))
    ..interceptors.add(NetworkInterceptor());

  ///method can be used for checking internet connection
  ///returns [bool] based on availability of internet
  Future isNetworkConnected() async {
    if (!await NetworkInfo().isConnected()) {
      throw NoInternetException('No Internet Found!');
    }
  }

  /// is `true` when the response status code is between 200 and 299
  ///
  /// user can modify this method with custom logics based on their API response
  bool _isSuccessCall(Response response) {
    if (response.statusCode != null) {
      return response.statusCode! >= 200 && response.statusCode! <= 299;
    }
    return false;
  }

  /// Performs API call for https://seere.somee.com/api/Account/login
  ///
  /// Sends a POST request to the server's 'https://seere.somee.com/api/Account/login' endpoint
  /// with the provided headers and request data
  /// Returns a [PostLoginAccountResp] object representing the response.
  /// Throws an error if the request fails or an exception occurs.
  Future<PostLoginAccountResp> loginAccount({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.post(
        '$url/api/Account/login',
        data: requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return PostLoginAccountResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? PostLoginAccountResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
