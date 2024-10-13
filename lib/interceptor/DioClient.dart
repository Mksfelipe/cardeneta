import 'package:cardeneta/config/apiConfig.dart';
import 'package:cardeneta/interceptor/ApiInterceptor.dart';
import 'package:dio/dio.dart';

class DioClient {
  // A instância privada do Dio
  static final DioClient _instance = DioClient._internal();

  // Instância do Dio
  late final Dio dio;

  // Construtor privado
  DioClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl, // Defina a URL base
    ));

    // Adicione interceptores, se necessário
    dio.interceptors.add(ApiInterceptor());
  }

  // Método para acessar a instância do Dio
  factory DioClient() {
    return _instance;
  }
}
