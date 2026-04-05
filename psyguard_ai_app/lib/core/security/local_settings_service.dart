import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localSettingsServiceProvider = Provider<LocalSettingsService>((ref) {
  return LocalSettingsService(const FlutterSecureStorage());
});

final consentAcceptedProvider = FutureProvider<bool>((ref) async {
  return ref.read(localSettingsServiceProvider).getConsentAccepted();
});

class LocalSettingsService {
  LocalSettingsService(this._storage);

  final FlutterSecureStorage _storage;

  static const _lastExportPathKey = 'last_export_path';
  static const _consentAcceptedKey = 'consent_accepted';
  static const _consentAcceptedAtKey = 'consent_accepted_at';
  static const _consentVersionKey = 'consent_version';

  Future<void> setLastExportPath(String path) {
    return _storage.write(key: _lastExportPathKey, value: path);
  }

  Future<String?> getLastExportPath() {
    return _storage.read(key: _lastExportPathKey);
  }

  Future<void> setConsentAccepted({required int version}) async {
    await _storage.write(key: _consentAcceptedKey, value: 'true');
    await _storage.write(
      key: _consentAcceptedAtKey,
      value: DateTime.now().toIso8601String(),
    );
    await _storage.write(key: _consentVersionKey, value: version.toString());
  }

  Future<bool> getConsentAccepted() async {
    final value = await _storage.read(key: _consentAcceptedKey);
    return value == 'true';
  }

  Future<void> clearAll() {
    return _storage.deleteAll();
  }
}
