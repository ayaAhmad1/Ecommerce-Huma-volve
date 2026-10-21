import 'package:commerce_app/core/constants/api_endpoints.dart';
import 'package:commerce_app/core/network/api_client.dart';
import 'package:commerce_app/features/auth/sign_up/screens/models/signup_req_model.dart';
import 'package:commerce_app/features/auth/sign_up/screens/models/signup_res_model.dart';

class SignupServices {
  ApiClient apiClient;
  SignupServices(this.apiClient);

  Future<signupResModel> signUp(SignupReqModel signupReqModel) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.signupEndpoint,
      data: {
        'name': signupReqModel.name,
        'email': signupReqModel.email,
        'password': signupReqModel.password,
        "avatar": "https://cdnb.artstation.com/p/marketplace/presentation_assets/003/430/265/large/file.jpg?1706950304",
      },
    );
    final Map<String, dynamic> jsonData = response.data;
    final signupResModel modelData = signupResModel.fromJson(jsonData);
    return modelData;
  }
}
