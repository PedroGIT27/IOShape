import 'package:flutter/material.dart';
import '../controller/user_controller.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _nameController = TextEditingController();
  final _nickController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cPasswordController = TextEditingController();
final _userController = UserController();

  String? selectedStage;

  final List<String> stages = [
    "¿En qué etapa estás?",
    "Aún no tengo una idea",
    "Tengo una idea",
    "Mi idea está en marcha"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Registro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: _nickController,
              decoration: InputDecoration(labelText: "Nick"),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Contraseña"),
              obscureText: true,
            ),
            TextField(
              controller: _cPasswordController,
              decoration: InputDecoration(labelText: "Confirmar Contraseña"),
              obscureText: true,
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedStage,
              isExpanded: true,
              hint: Text("¿En qué etapa estás?"),
              items: stages.map((String stage) {
                return DropdownMenuItem<String>(
                  value: stage,
                  child: Text(stage),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedStage = value;
                });
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text("Registrarse"),
              onPressed: () {
                final name = _nameController.text.trim();
                final nick = _nickController.text.trim();
                final email = _emailController.text.trim();
                final password = _passwordController.text;
                final cPassword = _cPasswordController.text;

                if (name.isNotEmpty &&
                    nick.isNotEmpty &&
                    email.isNotEmpty &&
                    password.isNotEmpty &&
                    cPassword.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Revise su email para la verificación"),
                  ));
                  _userController.registerUser(
                      name, nick, email, password, cPassword);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Por favor, completa todos los campos"),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
