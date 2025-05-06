import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:shape/controller/user_controller.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late UserController userController;

  setUp(() {
    mockHttpClient = MockHttpClient();
    userController = UserController(client: mockHttpClient); // 🔑 aquí lo usamos
  });

  test('debería registrar un usuario correctamente', () async {
    final url = Uri.parse('https://tu-api.com/api/register');

    when(() => mockHttpClient.post(
      url,
      body: any(named: 'body'),
    )).thenAnswer((_) async => http.Response('{"message": "Usuario registrado"}', 200));

    await userController.registerUser(
      'Juan', 'juan123', 'juan@correo.com', 'contraseña', 'contraseña'
    );

    verify(() => mockHttpClient.post(
      url,
      body: {
        'name': 'Juan',
        'nick': 'juan123',
        'email': 'juan@correo.com',
        'password': 'contraseña',
        'password_confirmation': 'contraseña',
      },
    )).called(1);
  });
}
