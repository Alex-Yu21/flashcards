import 'package:http/http.dart' as http;

class HttpClient {
  HttpClient([http.Client? real]) : _inner = real ?? http.Client();
  static const timeout = Duration(seconds: 6);

  final http.Client _inner;

  Future<http.Response> get(Uri url) => _inner.get(url).timeout(timeout);

  void close() => _inner.close();
}
