import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saujana/core/db/hive_service.dart';
import 'package:saujana/core/router/app_router.dart';
import 'package:saujana/core/theme/app_colors.dart';
import 'package:saujana/core/theme/app_spacing.dart';
import 'package:saujana/core/theme/app_text_styles.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.s12),

              // Icon placeholder
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.actionSubtle,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(Icons.self_improvement_outlined,
                    size: 32, color: AppColors.actionDefault),
              ),
              const SizedBox(height: AppSpacing.s8),

              Text(
                'Cek kondisi\nkecemasanmu',
                style: AppTextStyles.h1(color: colorScheme.onSurface),
              ),
              const SizedBox(height: AppSpacing.s4),

              Text(
                'GAD-7 adalah alat skrining kecemasan yang telah divalidasi secara klinis. '
                'Tujuh pertanyaan singkat, skor yang jelas, dan langkah selanjutnya yang konkret.',
                style: AppTextStyles.bodyLarge(color: colorScheme.onSurface.withValues(alpha: 0.7)),
              ),
              const SizedBox(height: AppSpacing.s4),

              // Time estimate chip
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.actionSubtle,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Text(
                  'Hanya sekitar 2 menit',
                  style: AppTextStyles.label(color: AppColors.actionDefault),
                ),
              ),

              const Spacer(),

              // Privacy note
              Row(
                children: [
                  Icon(Icons.lock_outline, size: 14,
                      color: colorScheme.onSurface.withValues(alpha: 0.4)),
                  const SizedBox(width: AppSpacing.s1),
                  Text(
                    'Jawabanmu tersimpan di perangkat ini. Selalu.',
                    style: AppTextStyles.caption(
                        color: colorScheme.onSurface.withValues(alpha: 0.4)),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s4),

              ElevatedButton(
                onPressed: () async {
                  await HiveService.markOnboardingSeen();
                  if (context.mounted) context.go(AppRoutes.assessment);
                },
                child: const Text('Mulai'),
              ),
              const SizedBox(height: AppSpacing.s6),
            ],
          ),
        ),
      ),
    );
  }
}
