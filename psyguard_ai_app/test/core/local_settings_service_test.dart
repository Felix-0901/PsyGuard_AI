import 'package:flutter_test/flutter_test.dart';
import 'package:psyguard_ai_app/core/security/local_settings_service.dart';

void main() {
  group('normalizeTtsSpeechRate', () {
    test('clamps values below the minimum', () {
      expect(normalizeTtsSpeechRate(0.1), minTtsSpeechRate);
    });

    test('clamps values above the maximum', () {
      expect(normalizeTtsSpeechRate(1.5), maxTtsSpeechRate);
    });

    test('rounds to two decimal places within the valid range', () {
      expect(normalizeTtsSpeechRate(0.556), 0.56);
    });
  });
}
