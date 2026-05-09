import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saujana/core/db/hive_service.dart';
import 'package:saujana/core/router/app_router.dart';
import 'package:saujana/core/theme/app_colors.dart';
import 'package:saujana/core/theme/app_spacing.dart';
import 'package:saujana/core/theme/app_text_styles.dart';

const _questions = [
  'Merasa gugup, cemas, atau sangat tegang',
  'Tidak mampu menghentikan atau mengendalikan rasa khawatir',
  'Terlalu banyak khawatir tentang berbagai hal',
  'Sulit untuk bersantai',
  'Sangat gelisah sehingga sulit untuk duduk diam',
  'Mudah merasa kesal atau mudah marah',
  'Merasa takut seolah-olah sesuatu yang buruk akan terjadi',
];

const _options = [
  'Tidak sama sekali',
  'Beberapa hari',
  'Lebih dari setengah hari',
  'Hampir setiap hari',
];

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int _current = 0;
  final List<int?> _answers = List.filled(7, null);

  void _selectAnswer(int value) {
    setState(() => _answers[_current] = value);
  }

  void _next() {
    if (_current < 6) {
      setState(() => _current++);
    } else {
      _submit();
    }
  }

  void _back() {
    if (_current > 0) setState(() => _current--);
  }

  void _submit() {
    final answers  = _answers.map((a) => a ?? 0).toList();
    final score    = HiveService.computeScore(answers);
    final severity = HiveService.computeSeverity(score);

    HiveService.saveAssessment(answers: answers, score: score, severity: severity);

    context.go(AppRoutes.result, extra: {
      'score':    score,
      'severity': severity,
      'answers':  answers,
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final selected    = _answers[_current];
    final isLast      = _current == 6;

    return Scaffold(
      appBar: AppBar(
        leading: _current > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                onPressed: _back,
              )
            : IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () => context.go(AppRoutes.home),
              ),
        title: Text(
          'Pertanyaan ${_current + 1} dari 7',
          style: AppTextStyles.caption(color: colorScheme.onSurface.withValues(alpha: 0.6)),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar
            _ProgressBar(current: _current),
            const SizedBox(height: AppSpacing.s6),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Preamble (shown once, stays visible)
                    Text(
                      'Selama 2 minggu terakhir, seberapa sering kamu terganggu oleh:',
                      style: AppTextStyles.caption(
                          color: colorScheme.onSurface.withValues(alpha: 0.5)),
                    ),
                    const SizedBox(height: AppSpacing.s4),

                    // Question
                    Text(
                      _questions[_current],
                      style: AppTextStyles.bodyLarge(color: colorScheme.onSurface),
                    ),
                    const SizedBox(height: AppSpacing.s6),

                    // Answer options
                    ..._options.asMap().entries.map((entry) {
                      final idx      = entry.key;
                      final label    = entry.value;
                      final isChosen = selected == idx;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.s3),
                        child: _AnswerOption(
                          label:     label,
                          isChosen:  isChosen,
                          onTap:     () => _selectAnswer(idx),
                        ),
                      );
                    }),
                    const SizedBox(height: AppSpacing.s8),
                  ],
                ),
              ),
            ),

            // Next button — pinned to bottom
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenH, 0, AppSpacing.screenH, AppSpacing.s6),
              child: ElevatedButton(
                onPressed: selected != null ? _next : null,
                child: Text(isLast ? 'Lihat hasilku' : 'Lanjut'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.current});
  final int current;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
      child: Row(
        children: List.generate(7, (i) {
          Color color;
          if (i < current) {
            color = AppColors.actionDefault;
          } else if (i == current) {
            color = AppColors.actionDefault.withValues(alpha: 0.5);
          } else {
            color = AppColors.borderSubtle;
          }
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: i < 6 ? 4 : 0),
              height: 4,
              decoration: BoxDecoration(
                color:        color,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _AnswerOption extends StatelessWidget {
  const _AnswerOption({
    required this.label,
    required this.isChosen,
    required this.onTap,
  });

  final String   label;
  final bool     isChosen;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve:    Curves.easeOut,
      decoration: BoxDecoration(
        color:        isChosen ? AppColors.actionSubtle : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: isChosen ? AppColors.actionDefault : AppColors.borderSubtle,
          width: isChosen ? 2 : 1.5,
        ),
      ),
      child: InkWell(
        onTap:        onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s6, vertical: AppSpacing.s4),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width:  20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:  isChosen ? AppColors.actionDefault : Colors.transparent,
                  border: Border.all(
                    color: isChosen ? AppColors.actionDefault : AppColors.borderDefault,
                    width: 2,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.s4),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.body(
                    color: isChosen ? AppColors.actionDefault : colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
