import 'package:dio/dio.dart';

import '../../l10n/app_language.dart';

class AiRequestException implements Exception {
  const AiRequestException(this.message);

  final String message;

  @override
  String toString() => message;
}

String userFacingAiError(
  Object? error, {
  AppLanguage language = AppLanguage.zhTw,
}) {
  final isZhTw = language == AppLanguage.zhTw;

  if (error is AiRequestException) {
    return error.message;
  }

  if (error is DioException) {
    final status = error.response?.statusCode;
    return switch (status) {
      400 =>
        isZhTw
            ? 'AI 請求格式不正確，請確認模型與參數設定'
            : 'The AI request format is invalid. Check the model and parameters.',
      401 =>
        isZhTw
            ? 'AI 驗證失敗：API Key 無效、已過期，或不屬於這個服務'
            : 'AI authentication failed. The API key is invalid, expired, or does not belong to this service.',
      403 =>
        isZhTw
            ? 'AI 驗證被拒絕：目前 API Key 沒有使用此服務的權限'
            : 'AI authentication was rejected. This API key does not have permission to use the service.',
      404 =>
        isZhTw
            ? '找不到 AI API 路徑：請確認 Base URL 可直接對應到 `/v1/chat/completions`'
            : 'The AI API path was not found. Make sure the Base URL maps to `/v1/chat/completions`.',
      429 =>
        isZhTw
            ? 'AI 服務目前流量過高或額度不足，請稍後再試'
            : 'The AI service is busy or quota is insufficient. Try again later.',
      int code when code >= 500 =>
        isZhTw
            ? 'AI 服務暫時異常，請稍後再試'
            : 'The AI service is temporarily unavailable. Try again later.',
      _ => _messageForDioType(error, isZhTw: isZhTw),
    };
  }

  if (error is StateError) {
    const prefix = 'Bad state: ';
    final message = error.toString();
    if (message.startsWith(prefix)) {
      return message.substring(prefix.length);
    }
    return message;
  }

  return isZhTw
      ? 'AI 服務目前無法使用，請稍後再試'
      : 'The AI service is currently unavailable. Try again later.';
}

String _messageForDioType(DioException error, {required bool isZhTw}) {
  return switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout =>
      isZhTw
          ? '連線 AI 服務逾時，請確認網路與伺服器狀態'
          : 'The AI service connection timed out. Check the network and server status.',
    DioExceptionType.connectionError || DioExceptionType.badCertificate =>
      isZhTw
          ? '無法連線到 AI 伺服器，請確認網址與憑證設定'
          : 'Cannot connect to the AI server. Check the URL and certificate settings.',
    DioExceptionType.cancel =>
      isZhTw ? 'AI 請求已取消' : 'The AI request was canceled.',
    _ =>
      isZhTw
          ? 'AI 服務目前無法使用，請稍後再試'
          : 'The AI service is currently unavailable. Try again later.',
  };
}
