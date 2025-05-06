import 'package:http/http.dart' as http;

class UserController {
  final http.Client client;

  UserController({http.Client? client}) : client = client ?? http.Client();

  Future<void> registerUser(String name, String nick, String email,
      String password, String confirmPassword) async {
    final url = Uri.parse("https://tu-api.com/api/register");

    final response = await client.post(url, body: {
      'name': name,
      'nick': nick,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    });

    print("Código de estado: ${response.statusCode}");
    print("Respuesta: ${response.body}");
  }
}
