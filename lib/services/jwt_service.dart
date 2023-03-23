import 'package:jwt_decoder/jwt_decoder.dart';

class JWTService {
  Map<String, dynamic> decodeToken(String token) {
    return JwtDecoder.decode(token);
  }

  DateTime getTokenExpiry(String token) {
    return JwtDecoder.getExpirationDate(token);
  }

  bool getTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }
}
