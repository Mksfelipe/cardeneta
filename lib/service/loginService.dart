import 'package:cardeneta/config/apiConfig.dart';
import 'package:cardeneta/interceptor/DioClient.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  final dio = DioClient().dio;

  LoginService(dio);

  String loginUrl = '${ApiConfig.baseUrl}/auth/signin'; // URL do login

  Future<bool> login(String cpf, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await dio.post(
        loginUrl,
        data: {
          'cpf': cpf,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        prefs.setString('token', response.data['token']);
      }
      // Verifica se a resposta foi bem-sucedida
      return response.statusCode == 200;
    } on DioException catch (e) {
      // Tratar erros
      print('Erro: ${e.response?.data ?? e.message}');
      return false;
    }
  }
}
