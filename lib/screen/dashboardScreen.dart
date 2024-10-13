import 'package:cardeneta/models/user.dart';
import 'package:cardeneta/screen/CustomerRegistrationScreen.dart';
import 'package:cardeneta/screen/login.page.dart';
import 'package:cardeneta/service/loginService.dart';
import 'package:cardeneta/service/userService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// Outros imports...

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  User? user;
  Userservice userservice = Userservice(Dio());
  LoginService authService = LoginService(Dio());

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    if (!(await authService.isTokenValid())) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      return;
    }

    try {
      user = await userservice.getUserProfile();
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      print('Erro ao buscar o perfil: $e');
      user = null;
    }
  }

  void _logout() async {
    await authService.logout();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchUserProfile,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(user != null
                  ? '${user!.firstName} ${user!.lastName}'
                  : 'Usuário'),
              accountEmail:
                  Text(user != null ? user!.email : 'Email não disponível'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(user != null ? user!.firstName[0] : '?',
                    style: const TextStyle(fontSize: 40.0)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.group_add),
              title: const Text('Cadastro de Cliente'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerRegistrationScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: user != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Nome: ${user!.firstName} ${user!.lastName}'),
                  Text('Email: ${user!.email}'),
                  Text('CPF: ${user!.cpf}'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _fetchUserProfile,
                    child: const Text('Recarregar Perfil'),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text('Erro ao carregar perfil'),
            ),
    );
  }
}
