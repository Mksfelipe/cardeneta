import 'package:cardeneta/config/apiConfig.dart';
import 'package:cardeneta/interceptor/DioClient.dart';
import 'package:cardeneta/models/user.dart';
import 'package:dio/dio.dart';

class Userservice {
  final dio = DioClient().dio;

  Userservice(dio);

  String url = '${ApiConfig.baseUrl}/user/profile'; // URL do login

  Future<User?> getUserProfile() async {
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      }
    } on DioException catch (e) {
      print('Erro ao obter perfil: ${e.response?.data ?? e.message}');
    }
    return null; // Retorne null se falhar
  }
}
