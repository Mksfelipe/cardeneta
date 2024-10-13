import 'package:flutter/material.dart';

class CustomerRegistrationScreen extends StatefulWidget {
  @override
  _CustomerRegistrationScreenState createState() =>
      _CustomerRegistrationScreenState();
}

class _CustomerRegistrationScreenState
    extends State<CustomerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos de texto
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  // Função para salvar o cliente
  void _saveCustomer() {
    if (_formKey.currentState!.validate()) {
      // Implementação da lógica para salvar o cliente
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final email = _emailController.text;
      final cpf = _cpfController.text;

      print("Nome: $firstName $lastName");
      print("Email: $email");
      print("CPF: $cpf");

      // Aqui, você pode enviar os dados para o back-end ou serviço de API

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente cadastrado com sucesso!')),
      );

      // Limpa os campos após salvar
      _firstNameController.clear();
      _lastNameController.clear();
      _emailController.clear();
      _cpfController.clear();
    }
  }

  // Função para cancelar o cadastro e limpar os campos
  void _cancel() {
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _cpfController.clear();
    Navigator.pop(context); // Retorna para a tela anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo de Nome
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),

              // Campo de Sobrenome
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Sobrenome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o sobrenome';
                  }
                  return null;
                },
              ),

              // Campo de Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor, insira um email válido';
                  }
                  return null;
                },
              ),

              // Campo de CPF
              TextFormField(
                controller: _cpfController,
                decoration: const InputDecoration(labelText: 'CPF'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o CPF';
                  }
                  if (value.length != 11) {
                    return 'O CPF deve ter 11 dígitos';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Botões de ação
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _saveCustomer,
                    child: const Text('Salvar'),
                  ),
                  ElevatedButton(
                    onPressed: _cancel,
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
