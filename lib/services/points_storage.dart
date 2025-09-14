import 'package:shared_preferences/shared_preferences.dart';

class PointsStorage {
  static const _kKey = 'inova_points';

  /// Retorna os pontos atuais. Default = 280 (primeiro uso).
  static Future<int> getPoints() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kKey) ?? 280;
  }

  /// Persiste os pontos.
  static Future<void> setPoints(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kKey, value);
  }

  /// Opcional: reset para testes.
  static Future<void> reset([int value = 280]) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kKey, value);
  }
}
