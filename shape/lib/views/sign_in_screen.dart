import 'package:flutter/material.dart';
import '../controller/user_controller.dart';

class SignInScreen extends StatefulWidget {
  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final _nameController = TextEditingController();
  final _nickController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cPasswordController = TextEditingController();
  final _userController = UserController();

  FocusNode _nameFocusNode = FocusNode();
  FocusNode _nickFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _cPasswordFocusNode = FocusNode();

  String? selectedStage;

  final List<String> stages = [
    "¿En qué etapa estás?",
    "Aún no tengo una idea",
    "Tengo una idea",
    "Mi idea está en marcha"
  ];

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _nickFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _cPasswordFocusNode.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white70),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white38),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(color: Colors.white),
        title: Text("Registro", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              focusNode: _nameFocusNode,
              controller: _nameController,
              style: TextStyle(color: Colors.white),
              decoration: inputDecoration("Nombre"),
            ),
            TextField(
              focusNode: _nickFocusNode,
              controller: _nickController,
              style: TextStyle(color: Colors.white),
              decoration: inputDecoration("Nick"),
            ),
            TextField(
              focusNode: _emailFocusNode,
              controller: _emailController,
              style: TextStyle(color: Colors.white),
              decoration: inputDecoration("Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              focusNode: _passwordFocusNode,
              controller: _passwordController,
              style: TextStyle(color: Colors.white),
              decoration: inputDecoration("Contraseña"),
              obscureText: true,
            ),
            TextField(
              focusNode: _cPasswordFocusNode,
              controller: _cPasswordController,
              style: TextStyle(color: Colors.white),
              decoration: inputDecoration("Confirmar Contraseña"),
              obscureText: true,
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              dropdownColor: Colors.black,
              value: selectedStage,
              isExpanded: true,
              hint: Text("¿En qué etapa estás?", style: TextStyle(color: Colors.white70)),
              items: stages.map((String stage) {
                return DropdownMenuItem<String>(
                  value: stage,
                  child: Text(stage, style: TextStyle(color: Colors.white)),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Registrarse", style: TextStyle(fontSize: 16)),
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
