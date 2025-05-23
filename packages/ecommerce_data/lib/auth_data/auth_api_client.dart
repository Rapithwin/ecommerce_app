import 'package:http/http.dart' as http;

class AuthApiClient {
  AuthApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  final _usersEndpoint = "api/users";
}
