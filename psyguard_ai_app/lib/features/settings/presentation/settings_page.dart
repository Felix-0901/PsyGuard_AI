import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/network/dio_provider.dart';
import '../../../core/security/local_settings_service.dart';
import '../../../core/storage/database_provider.dart';
import '../../../core/theme/app_theme.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final aiEnabled = config.isConfigured;

    return Scaffold(
      backgroundColor: PsyGuardTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '設定',
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: PsyGuardTheme.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          children: [
            _sectionTitle('AI 狀態'),
            const SizedBox(height: 12),
            _card(
              child: Row(
                children: [
                  Icon(
                    aiEnabled
                        ? Icons.check_circle_outline_rounded
                        : Icons.offline_bolt_rounded,
                    color: aiEnabled
                        ? const Color(0xFF2E7D32)
                        : PsyGuardTheme.textSecondary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          aiEnabled ? '已啟用 AI 串接' : '離線模式（未設定 API Key）',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: PsyGuardTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          aiEnabled
                              ? '模型：${config.model}'
                              : '目前聊天會使用示範回覆，之後可再補環境變數啟用真實 AI。',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 13,
                            height: 1.5,
                            color: PsyGuardTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _sectionTitle('資料與隱私'),
            const SizedBox(height: 12),
            _card(
              child: Text(
                '第一版資料只儲存在本機（SQLite）。你可以隨時在這裡清除資料。\n'
                '若你之後自行設定 API Key，聊天內容可能會送到第三方 AI 服務進行生成回覆。',
                style: GoogleFonts.nunitoSans(
                  fontSize: 13,
                  height: 1.6,
                  color: PsyGuardTheme.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 18),
            _sectionTitle('重置'),
            const SizedBox(height: 12),
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '清除本機資料',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: PsyGuardTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '將刪除所有聊天、日記、睡眠、趨勢、AI 報告與設定（包含同意狀態）。此操作無法復原。',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 13,
                      height: 1.6,
                      color: PsyGuardTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('確認清除？'),
                              content: const Text('確定要清除所有本機資料與設定嗎？'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('取消'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('清除'),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmed != true) {
                          return;
                        }

                        final db = ref.read(appDatabaseProvider);
                        final settings = ref.read(localSettingsServiceProvider);
                        await db.clearAllData();
                        await settings.clearAll();
                        ref.invalidate(consentAcceptedProvider);
                        if (context.mounted) {
                          context.go('/welcome');
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFB00020),
                        side: const BorderSide(color: Color(0xFFB00020)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: GoogleFonts.nunitoSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      child: const Text('清除資料'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.nunitoSans(
        fontSize: 14,
        fontWeight: FontWeight.w900,
        color: PsyGuardTheme.textPrimary,
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: child,
    );
  }
}

