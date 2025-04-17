import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> login(String username, String password) async {
  final response = await http.post(
    Uri.parse('https://kryss.pythonanywhere.com/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data['access_token'];
  } else {
    throw Exception('Error al iniciar sesión: ${response.statusCode} ${response.reasonPhrase}');
  }
}

Future<void> fetchData(String token) async {
  final response = await http.get(
    Uri.parse('https://kryss.pythonanywhere.com/api/personajes'),
    headers: <String, String>{
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(data);
  } else {
    print('Error al cargar los datos: ${response.statusCode} ${response.reasonPhrase}');
    print('Response body: ${response.body}');
    throw Exception('Error al cargar los datos: ${response.statusCode} ${response.reasonPhrase}');
  }
}