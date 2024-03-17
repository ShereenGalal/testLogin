import 'package:testlogin/data/models/loginAccount/post_login_account_resp.dart';

import '../apiClient/api_client.dart';

/// Repository class for managing API requests.
///
/// This class provides a simplified interface for making the
/// API request using the [ApiClient] instance
class Repository {
  final _apiClient = ApiClient();

  Future<PostLoginAccountResp> loginAccount({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.loginAccount(
      headers: headers,
      requestData: requestData,
    );
  }
}
