import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saujana/core/db/hive_service.dart';
import 'package:saujana/core/router/app_router.dart';
import 'package:saujana/core/theme/app_colors.dart';
import 'package:saujana/core/theme/app_spacing.dart';
import 'package:saujana/core/theme/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final latest = HiveService.getLatestAssessment();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Saujana', style: AppTextStyles.h3()),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.s8),
              Text(
                'Bagaimana perasaanmu\nminggu ini?',
                style: AppTextStyles.h1(color: colorScheme.onSurface),
              ),
              const SizedBox(height: AppSpacing.s6),

              // Last result card
              if (latest != null) ...[
                _LastResultCard(data: latest),
                const SizedBox(height: AppSpacing.s6),
              ],

              const Spacer(),

              // Primary CTA
              ElevatedButton(
                onPressed: () => context.push(AppRoutes.assessment),
                child: const Text('Mulai Asesmen'),
              ),
              const SizedBox(height: AppSpacing.s3),

              // History link
              if (latest != null)
                TextButton(
                  onPressed: () => context.push(AppRoutes.history),
                  child: const Text('Lihat semua hasil →'),
                ),

              const SizedBox(height: AppSpacing.s6),
            ],
          ),
        ),
      ),
    );
  }
}

class _LastResultCard extends StatelessWidget {
  const _LastResultCard({required this.data});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final score    = data['score'] as int;
    final severity = data['severity'] as String;
    final ts       = DateTime.fromMillisecondsSinceEpoch(data['timestamp'] as int);
    final dayLabel = _dayLabel(ts.weekday);
    final dateStr  = '$dayLabel, ${ts.day} ${_monthLabel(ts.month)} ${ts.year}';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s6),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hasil terakhir', style: AppTextStyles.caption(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5))),
                  const SizedBox(height: AppSpacing.s1),
                  Text(dateStr, style: AppTextStyles.bodyMedium()),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('$score', style: AppTextStyles.h2()),
                const SizedBox(height: AppSpacing.s1),
                _SeverityBadge(severity: severity),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _dayLabel(int weekday) {
    const days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    return days[weekday - 1];
  }

  String _monthLabel(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    return months[month - 1];
  }
}

class _SeverityBadge extends StatelessWidget {
  const _SeverityBadge({required this.severity});
  final String severity;

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (severity) {
      'minimal'  => ('Minimal',  AppColors.severityMinimalBg,  AppColors.severityMinimal),
      'mild'     => ('Ringan',   AppColors.severityMildBg,     AppColors.severityMild),
      'moderate' => ('Sedang',   AppColors.severityModerateBg, AppColors.severityModerate),
      'severe'   => ('Berat',    AppColors.severitySevereBg,   AppColors.severitySevere),
      _          => ('—',        AppColors.bgSurfaceAlt,       AppColors.textSecondary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color:        bg,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(label, style: AppTextStyles.label(color: fg)),
    );
  }
}
