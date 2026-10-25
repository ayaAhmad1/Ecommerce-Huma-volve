import 'package:commerce_app/core/constants/api_endpoints.dart';
import 'package:commerce_app/core/network/api_client.dart';
import 'package:commerce_app/core/storage/secure_storage.dart';
import 'package:commerce_app/features/auth/login/screens/models/login_model.dart';

class LoginService {
  ApiClient apiClient;
  LoginService(this.apiClient);
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.loginEndpoint,
      data: {'email': email, 'password': password},
    );
    final Map<String, dynamic> jsonData = response.data;
    final LoginModel modelData = LoginModel.fromJson(jsonData);
    final accessToken = modelData.accessToken;
    if (accessToken == null) {
      throw StateError('Login response is missing an access token.');
    }
    final refreshToken = modelData.refreshToken;
    if (refreshToken == null) {
      throw StateError('Login response is missing a refresh token.');
    }
    await SecureStorage.saveAccessToken(accessToken);
    await SecureStorage.saveRefreshToken(refreshToken);
    return modelData;
  }
}
