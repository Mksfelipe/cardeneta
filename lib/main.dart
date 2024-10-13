import 'package:cardeneta/interceptor/ApiInterceptor.dart';
import 'package:cardeneta/screen/dashboardScreen.dart';
import 'package:cardeneta/screen/login.page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  final dio = Dio();
  dio.interceptors.add(ApiInterceptor());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Desktop App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/dashboard': (context) =>
            DashboardScreen(), // Adicionar a rota para a tela de Dashboard
      },
    );
  }
}
