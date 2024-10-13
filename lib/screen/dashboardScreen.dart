import 'package:cardeneta/models/user.dart';
import 'package:cardeneta/service/userService.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  User? user; // User pode ser nulo inicialmente
  bool isLoading = true; // Para mostrar carregando enquanto obtém os dados
  Userservice userservice = Userservice(Dio()); // Instância do UserService

  @override
  void initState() {
    super.initState();
    _fetchUserProfile(); // Chama o método para buscar o perfil do usuário
  }

  Future<void> _fetchUserProfile() async {
    try {
      user = await userservice.getUserProfile(); // Chama o método assíncrono
    } catch (e) {
      print('Erro ao buscar o perfil: $e'); // Log do erro
    } finally {
      // Atualiza o estado para não carregando
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            ) // Mostra carregando
          : user != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Nome: ${user!.firstName} ${user!.lastName}'),
                      Text('Email: ${user!.email}'),
                      Text('CPF: ${user!.cpf}'),
                      Text(
                          'Saldo: ${user!.account.balance.toStringAsFixed(2)}'),
                    ],
                  ),
                )
              : const Center(
                  child: Text('Erro ao carregar perfil'),
                ), // Caso ocorra um erro
    );
  }
}
