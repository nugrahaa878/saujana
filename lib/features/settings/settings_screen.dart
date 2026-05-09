import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saujana/core/db/hive_service.dart';
import 'package:saujana/core/router/app_router.dart';
import 'package:saujana/core/theme/app_colors.dart';
import 'package:saujana/core/theme/app_spacing.dart';
import 'package:saujana/core/theme/app_text_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.go(AppRoutes.home),
        ),
        title: Text('Pengaturan', style: AppTextStyles.h3()),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenH,
            vertical: AppSpacing.s4,
          ),
          children: [
            _SectionLabel('Privasi'),
            const SizedBox(height: AppSpacing.s2),
            Card(
              child: Column(
                children: [
                  _SettingsTile(
                    icon:  Icons.lock_outline,
                    title: 'Kebijakan privasi',
                    subtitle: 'Data tidak pernah meninggalkan perangkatmu',
                    onTap: () => _showPrivacySheet(context),
                  ),
                  Divider(
                    height: 1,
                    indent: AppSpacing.s6 + 24 + AppSpacing.s3,
                    color: AppColors.borderSubtle,
                  ),
                  _SettingsTile(
                    icon:     Icons.delete_outline,
                    title:    'Hapus semua data',
                    subtitle: 'Menghapus seluruh riwayat asesmen secara permanen',
                    iconColor: AppColors.severitySevere,
                    onTap:    () => _confirmDeleteAll(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s8),
            _SectionLabel('Tentang'),
            const SizedBox(height: AppSpacing.s2),
            Card(
              child: _SettingsTile(
                icon:  Icons.info_outline,
                title: 'Tentang GAD-7',
                subtitle: 'Spitzer et al., 2006 · Arch Intern Med',
                onTap: () => _showAboutSheet(context),
              ),
            ),
            const SizedBox(height: AppSpacing.s8),
            Center(
              child: Text(
                'Saujana v0.1.0\nSemua data tersimpan hanya di perangkat ini.',
                style: AppTextStyles.caption(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.35)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteAll(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Hapus semua data?', style: AppTextStyles.h3()),
        content: Text(
          'Seluruh riwayat asesmen akan dihapus permanen. Tindakan ini tidak dapat dibatalkan.',
          style: AppTextStyles.body(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Hapus semua',
                style: AppTextStyles.bodyMedium(color: AppColors.severitySevere)),
          ),
        ],
      ),
    ).then((confirmed) async {
      if (confirmed == true) {
        await HiveService.deleteAllData();
        if (context.mounted) context.go(AppRoutes.onboarding);
      }
    });
  }

  void _showPrivacySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(AppSpacing.s6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderDefault,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.s6),
            Text('Kebijakan Privasi', style: AppTextStyles.h3()),
            const SizedBox(height: AppSpacing.s4),
            Text(
              'Saujana tidak memiliki server, tidak ada login, dan tidak ada koneksi jaringan. '
              'Semua data asesmen tersimpan hanya di perangkat ini menggunakan database lokal.\n\n'
              'Tidak ada data yang dikirim ke pihak ketiga — tidak ada analitik, tidak ada iklan, tidak ada laporan crash otomatis.\n\n'
              'Menghapus aplikasi akan menghapus semua datamu.',
              style: AppTextStyles.body(),
            ),
            const SizedBox(height: AppSpacing.s6),
          ],
        ),
      ),
    );
  }

  void _showAboutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(AppSpacing.s6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderDefault,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.s6),
            Text('Tentang GAD-7', style: AppTextStyles.h3()),
            const SizedBox(height: AppSpacing.s4),
            Text(
              'GAD-7 (Generalized Anxiety Disorder 7-item scale) adalah alat skrining kecemasan yang '
              'dikembangkan oleh Spitzer, Kroenke, Williams, dan Löwe (2006) dan telah divalidasi secara klinis.\n\n'
              'Alat ini digunakan untuk mendeteksi dan mengukur tingkat keparahan gangguan kecemasan umum. '
              'Saujana menggunakan rumusan pertanyaan dan skala jawaban yang verbatim sesuai instrumen aslinya.\n\n'
              'Saujana adalah alat skrining, bukan pengganti diagnosis klinis.',
              style: AppTextStyles.body(),
            ),
            const SizedBox(height: AppSpacing.s6),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: AppTextStyles.label(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4)),
      );
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor,
  });

  final IconData     icon;
  final String       title;
  final String       subtitle;
  final VoidCallback onTap;
  final Color?       iconColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap:        onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s4, vertical: AppSpacing.s4),
        child: Row(
          children: [
            Icon(icon, size: 24,
                color: iconColor ?? colorScheme.onSurface.withValues(alpha: 0.5)),
            const SizedBox(width: AppSpacing.s3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.bodyMedium()),
                  Text(subtitle,
                      style: AppTextStyles.caption(
                          color: colorScheme.onSurface.withValues(alpha: 0.5))),
                ],
              ),
            ),
            Icon(Icons.chevron_right, size: 20,
                color: colorScheme.onSurface.withValues(alpha: 0.3)),
          ],
        ),
      ),
    );
  }
}
