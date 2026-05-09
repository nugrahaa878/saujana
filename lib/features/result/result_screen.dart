import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saujana/core/router/app_router.dart';
import 'package:saujana/core/theme/app_colors.dart';
import 'package:saujana/core/theme/app_spacing.dart';
import 'package:saujana/core/theme/app_text_styles.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.score,
    required this.severity,
    required this.answers,
  });

  final int        score;
  final String     severity;
  final List<int>  answers;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final config      = _severityConfig(severity);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined),
            onPressed: () => context.go(AppRoutes.home),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.s8),

              // Score label
              Text(
                'Skor GAD-7 kamu',
                style: AppTextStyles.caption(
                    color: colorScheme.onSurface.withValues(alpha: 0.5)),
              ),
              const SizedBox(height: AppSpacing.s2),

              // Score number — hero moment
              Text(
                '$score',
                style: AppTextStyles.displayXl(color: colorScheme.onSurface),
              ),
              const SizedBox(height: AppSpacing.s3),

              // Severity badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color:        config.bg,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Text(config.label,
                    style: AppTextStyles.label(color: config.fg)),
              ),
              const SizedBox(height: AppSpacing.s6),

              // Divider
              Divider(color: AppColors.borderSubtle),
              const SizedBox(height: AppSpacing.s6),

              // Interpretation
              Text(
                config.interpretation,
                style: AppTextStyles.bodyLarge(color: colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.s8),

              // Next steps (moderate & severe)
              if (score >= 10) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Langkah selanjutnya',
                      style: AppTextStyles.h3(color: colorScheme.onSurface)),
                ),
                const SizedBox(height: AppSpacing.s4),
                _NextStepCard(
                  icon:  Icons.local_hospital_outlined,
                  title: 'Bicarakan dengan dokter',
                  desc:  'Katakan: "Skor GAD-7 saya $score. Saya ingin mendiskusikannya."',
                ),
                const SizedBox(height: AppSpacing.s3),
                _NextStepCard(
                  icon:  Icons.work_outline,
                  title: 'Cek EAP kantormu',
                  desc:  'Banyak perusahaan menyediakan sesi terapi gratis melalui Employee Assistance Program.',
                ),
                const SizedBox(height: AppSpacing.s3),
                _NextStepCard(
                  icon:  Icons.chat_bubble_outline,
                  title: 'Cari psikolog online',
                  desc:  'Into The Light Indonesia dan Yayasan Pulih menyediakan layanan online yang lebih fleksibel.',
                ),
                const SizedBox(height: AppSpacing.s6),
              ],

              // Crisis line — always visible
              _CrisisLine(),
              const SizedBox(height: AppSpacing.s6),

              // Recheck suggestion
              Text(
                'Cek kembali dalam 2 minggu untuk melihat perkembanganmu.',
                style: AppTextStyles.body(
                    color: colorScheme.onSurface.withValues(alpha: 0.6)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.s4),

              // View history button
              OutlinedButton(
                onPressed: () => context.go(AppRoutes.history),
                child: const Text('Lihat riwayat hasil'),
              ),

              const SizedBox(height: AppSpacing.s3),

              // Disclaimer
              Text(
                'Ini adalah alat skrining, bukan diagnosis klinis.',
                style: AppTextStyles.caption(
                    color: colorScheme.onSurface.withValues(alpha: 0.4)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.s8),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Severity config ──────────────────────────────────────────────────────────

class _SeverityConfig {
  const _SeverityConfig({
    required this.label,
    required this.bg,
    required this.fg,
    required this.interpretation,
  });

  final String label;
  final Color  bg;
  final Color  fg;
  final String interpretation;
}

_SeverityConfig _severityConfig(String severity) => switch (severity) {
  'minimal' => _SeverityConfig(
    label: 'Minimal',
    bg:    AppColors.severityMinimalBg,
    fg:    AppColors.severityMinimal,
    interpretation:
        'Saat ini kondisimu terlihat cukup tenang. Bukan berarti yang kamu rasakan tidak nyata — hanya saja gejala kecemasanmu belum berada di level klinis. Pantau terus dalam 2 minggu ke depan.',
  ),
  'mild' => _SeverityConfig(
    label: 'Ringan',
    bg:    AppColors.severityMildBg,
    fg:    AppColors.severityMild,
    interpretation:
        'Kamu sedang membawa beban kecemasan. Mengingat banyaknya hal yang dikelola kebanyakan orang seusiamu — pekerjaan, keluarga, dan segalanya — ini tidak mengherankan. Layak untuk dipantau. Cek ulang dalam 2 minggu.',
  ),
  'moderate' => _SeverityConfig(
    label: 'Sedang',
    bg:    AppColors.severityModerateBg,
    fg:    AppColors.severityModerate,
    interpretation:
        'Skormu menunjukkan kecemasan yang kemungkinan memengaruhi aktivitas sehari-harimu — bukan sekadar "stres biasa". Ini sinyal yang layak ditindaklanjuti. Berbicara dengan dokter atau psikolog adalah langkah yang masuk akal, dan skormu bisa jadi bahan pembicaraan yang konkret.',
  ),
  'severe' => _SeverityConfig(
    label: 'Berat',
    bg:    AppColors.severitySevereBg,
    fg:    AppColors.severitySevere,
    interpretation:
        'Skor ini mencerminkan tingkat kecemasan yang signifikan. Kamu mungkin sudah berjalan dengan tenaga yang hampir habis. Tolong hubungi seseorang — dokter, psikolog, atau saluran krisis. Kamu tidak harus menanggung ini sendirian.',
  ),
  _ => _SeverityConfig(
    label: '—', bg: AppColors.bgSurfaceAlt, fg: AppColors.textSecondary,
    interpretation: '',
  ),
};

// ── Components ───────────────────────────────────────────────────────────────

class _NextStepCard extends StatelessWidget {
  const _NextStepCard({
    required this.icon,
    required this.title,
    required this.desc,
  });

  final IconData icon;
  final String   title;
  final String   desc;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 24, color: colorScheme.onSurface.withValues(alpha: 0.5)),
            const SizedBox(width: AppSpacing.s4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.bodyMedium()),
                  const SizedBox(height: AppSpacing.s1),
                  Text(desc,
                      style: AppTextStyles.body(
                          color: colorScheme.onSurface.withValues(alpha: 0.6))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CrisisLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:   double.infinity,
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color:        AppColors.severitySevereBg,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Icon(Icons.phone_outlined, size: 20, color: AppColors.severitySevere),
          const SizedBox(width: AppSpacing.s3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Butuh bantuan segera?',
                    style: AppTextStyles.bodyMedium(color: AppColors.severitySevere)),
                Text('Into The Light Indonesia · 119 ext 8',
                    style: AppTextStyles.caption(color: AppColors.severitySevere)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
