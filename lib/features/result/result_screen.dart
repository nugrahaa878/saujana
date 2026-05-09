import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saujana/core/router/app_router.dart';
import 'package:saujana/core/theme/app_colors.dart';
import 'package:saujana/core/theme/app_spacing.dart';
import 'package:saujana/core/theme/app_text_styles.dart';

// Short labels matching the 7 GAD-7 questions (in order)
const _questionLabels = [
  'Merasa gugup atau cemas',
  'Tidak bisa berhenti khawatir',
  'Khawatir tentang banyak hal',
  'Sulit untuk bersantai',
  'Gelisah dan susah untuk diam',
  'Mudah kesal atau marah',
  'Takut hal buruk akan terjadi',
];

const _answerLabels = [
  'Tidak sama sekali',
  'Beberapa hari',
  'Lebih dari setengah hari',
  'Hampir setiap hari',
];

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.score,
    required this.severity,
    required this.answers,
  });

  final int       score;
  final String    severity;
  final List<int> answers;

  bool get _isMaxScore => score == 21;
  bool get _isSevere   => score >= 15;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final config      = _severityConfig(severity, score);

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

              // ── Score hero ──────────────────────────────────────────────
              Text(
                'Skor GAD-7 kamu',
                style: AppTextStyles.caption(
                    color: colorScheme.onSurface.withValues(alpha: 0.5)),
              ),
              const SizedBox(height: AppSpacing.s2),
              Text(
                '$score',
                style: AppTextStyles.displayXl(color: colorScheme.onSurface),
              ),
              Text(
                'dari 21',
                style: AppTextStyles.label(
                    color: colorScheme.onSurface.withValues(alpha: 0.35)),
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

              // ── Max-score urgent banner (score = 21) ────────────────────
              if (_isMaxScore) ...[
                _MaxScoreBanner(),
                const SizedBox(height: AppSpacing.s6),
              ],

              // ── Crisis line pinned at top for severe ────────────────────
              if (_isSevere) ...[
                _CrisisLine(),
                const SizedBox(height: AppSpacing.s6),
              ],

              Divider(color: AppColors.borderSubtle),
              const SizedBox(height: AppSpacing.s6),

              // ── Interpretation ──────────────────────────────────────────
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Apa artinya ini?',
                    style: AppTextStyles.h3(color: colorScheme.onSurface)),
              ),
              const SizedBox(height: AppSpacing.s3),
              _InterpretationBlock(config: config),
              const SizedBox(height: AppSpacing.s8),

              // ── Symptom breakdown ───────────────────────────────────────
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Rincian gejalamu',
                    style: AppTextStyles.h3(color: colorScheme.onSurface)),
              ),
              const SizedBox(height: AppSpacing.s2),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Seberapa sering kamu merasakan masing-masing gejala ini selama 2 minggu terakhir.',
                  style: AppTextStyles.caption(
                      color: colorScheme.onSurface.withValues(alpha: 0.5)),
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              _SymptomBreakdown(answers: answers),
              const SizedBox(height: AppSpacing.s8),

              // ── Next steps ──────────────────────────────────────────────
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
                  desc:  'Kamu bisa langsung bilang: "Skor GAD-7 saya $score dari 21. Saya ingin mendiskusikan apa artinya." Itu sudah cukup sebagai pembuka.',
                ),
                const SizedBox(height: AppSpacing.s3),
                _NextStepCard(
                  icon:  Icons.work_outline,
                  title: 'Cek EAP kantormu',
                  desc:  'Banyak perusahaan menyediakan sesi konseling gratis dan rahasia melalui Employee Assistance Program — tapi kebanyakan karyawan tidak tahu bahwa fasilitas ini ada.',
                ),
                const SizedBox(height: AppSpacing.s3),
                _NextStepCard(
                  icon:  Icons.chat_bubble_outline,
                  title: 'Cari psikolog online',
                  desc:  'Into The Light Indonesia dan Yayasan Pulih menyediakan layanan online yang lebih fleksibel dengan jadwal yang bisa disesuaikan — tidak perlu antri panjang di klinik.',
                ),
                const SizedBox(height: AppSpacing.s6),
              ],

              // ── Crisis line at bottom (always visible) ──────────────────
              if (!_isSevere) ...[
                _CrisisLine(),
                const SizedBox(height: AppSpacing.s6),
              ],

              // ── Recheck + actions ───────────────────────────────────────
              Text(
                'Cek kembali dalam 2 minggu untuk melihat apakah ada perubahan.',
                style: AppTextStyles.body(
                    color: colorScheme.onSurface.withValues(alpha: 0.6)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.s4),
              OutlinedButton(
                onPressed: () => context.go(AppRoutes.history),
                child: const Text('Lihat riwayat hasil'),
              ),
              const SizedBox(height: AppSpacing.s3),
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

// ── Severity config ───────────────────────────────────────────────────────────

class _SeverityConfig {
  const _SeverityConfig({
    required this.label,
    required this.bg,
    required this.fg,
    required this.whatItMeans,
    required this.context,
    required this.action,
  });

  final String label;
  final Color  bg;
  final Color  fg;
  final String whatItMeans; // clinical meaning, plain language
  final String context;     // validates their situation (work, life pressure)
  final String action;      // concrete next step
}

_SeverityConfig _severityConfig(String severity, int score) => switch (severity) {
  'minimal' => _SeverityConfig(
    label: 'Minimal',
    bg:    AppColors.severityMinimalBg,
    fg:    AppColors.severityMinimal,
    whatItMeans:
        'Gejala kecemasanmu saat ini berada di bawah ambang klinis. '
        'Skor 0–4 menunjukkan bahwa kamu tidak sedang mengalami kecemasan yang mengganggu fungsi sehari-hari.',
    context:
        'Tapi ingat — tidak ada skor yang "salah". Kamu tetap berhak merasa apa pun yang kamu rasakan. '
        'Jika kamu merasa ada yang tidak beres meski skornya rendah, itu tetap layak diperhatikan.',
    action:
        'Pantau kembali dalam 2 minggu. Kecemasan bisa berfluktuasi, dan melacaknya secara rutin '
        'membantu kamu melihat pola yang mungkin tidak terlihat hari per hari.',
  ),
  'mild' => _SeverityConfig(
    label: 'Ringan',
    bg:    AppColors.severityMildBg,
    fg:    AppColors.severityMild,
    whatItMeans:
        'Skor 5–9 berada di kisaran kecemasan ringan — nyata, bisa dirasakan, '
        'tapi belum sampai mengganggu fungsi utama. Kamu mungkin sudah memperhatikan '
        'beberapa gejala ini tapi belum yakin seberapa signifikannya.',
    context:
        'Bagi yang bekerja 9-5, menanggung tanggung jawab keluarga, atau menjaga orang tua '
        'sambil mengurus kehidupan sendiri — kecemasan ringan sampai sedang sangat umum terjadi. '
        'Ini bukan tanda kelemahan. Ini tanda kamu sedang membawa banyak hal sekaligus.',
    action:
        'Perhatikan pola: kapan gejalanya paling berat? Hari Senin? Sebelum deadline? '
        'Setelah interaksi tertentu? Riwayat di aplikasi ini bisa membantumu melihat pola itu. '
        'Kalau skor ini muncul terus dalam 2 minggu ke depan, pertimbangkan untuk bicara dengan profesional.',
  ),
  'moderate' => _SeverityConfig(
    label: 'Sedang',
    bg:    AppColors.severityModerateBg,
    fg:    AppColors.severityModerate,
    whatItMeans:
        'Skor 10–14 berarti kecemasanmu sudah berada di level yang kemungkinan besar '
        'memengaruhi cara kamu bekerja, tidur, berkonsentrasi, atau berhubungan dengan orang lain. '
        'Ini bukan sekadar "stres biasa" — ini sinyal yang perlu ditanggapi.',
    context:
        'Banyak orang di titik ini sudah lama mencoba mengatasi sendiri — '
        'meyakinkan diri bahwa "ini pasti akan lewat", "orang lain lebih susah dari saya", '
        'atau "saya tidak punya waktu untuk urusan ini". Tapi kecemasan di level ini '
        'cenderung tidak hilang sendiri tanpa ada yang berubah.',
    action:
        'Berbicara dengan dokter atau psikolog adalah langkah paling konkret yang bisa kamu ambil sekarang. '
        'Kamu tidak perlu tahu apa yang akan kamu katakan — skor $score ini sudah cukup '
        'sebagai titik awal pembicaraan yang bermakna.',
  ),
  'severe' => _SeverityConfig(
    label: 'Berat',
    bg:    AppColors.severitySevereBg,
    fg:    AppColors.severitySevere,
    whatItMeans:
        'Skor 15–21 mencerminkan kecemasan yang berat — meresap ke hampir semua aspek '
        'keseharianmu dan kemungkinan sudah berlangsung cukup lama. '
        'Di level ini, kecemasan bukan lagi "latar belakang" — ia aktif memengaruhi cara kamu berpikir, '
        'tidur, bekerja, dan merasa aman.',
    context:
        'Kamu mungkin sudah lama menjalankan ini sendirian, meyakinkan diri bahwa kamu baik-baik saja '
        'atau bahwa orang lain punya beban yang lebih berat. '
        'Tapi tubuh dan pikiranmu sudah bicara melalui jawaban yang kamu berikan tadi. '
        'Kamu tidak harus terus begini.',
    action:
        'Tolong hubungi seseorang hari ini — dokter, psikolog, orang yang kamu percaya, '
        'atau saluran krisis di bawah ini. Kamu tidak perlu "cukup parah" untuk layak mendapat bantuan. '
        'Skor $score sudah lebih dari cukup.',
  ),
  _ => _SeverityConfig(
    label: '—', bg: AppColors.bgSurfaceAlt, fg: AppColors.textSecondary,
    whatItMeans: '', context: '', action: '',
  ),
};

// ── Widgets ───────────────────────────────────────────────────────────────────

class _InterpretationBlock extends StatelessWidget {
  const _InterpretationBlock({required this.config});
  final _SeverityConfig config;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dimText = colorScheme.onSurface.withValues(alpha: 0.75);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InterpRow(
          icon:  Icons.info_outline,
          color: config.fg,
          text:  config.whatItMeans,
          dimText: dimText,
        ),
        const SizedBox(height: AppSpacing.s4),
        _InterpRow(
          icon:  Icons.people_outline,
          color: config.fg,
          text:  config.context,
          dimText: dimText,
        ),
        const SizedBox(height: AppSpacing.s4),
        _InterpRow(
          icon:  Icons.arrow_circle_right_outlined,
          color: config.fg,
          text:  config.action,
          dimText: dimText,
        ),
      ],
    );
  }
}

class _InterpRow extends StatelessWidget {
  const _InterpRow({
    required this.icon,
    required this.color,
    required this.text,
    required this.dimText,
  });

  final IconData icon;
  final Color    color;
  final String   text;
  final Color    dimText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(icon, size: 18, color: color.withValues(alpha: 0.7)),
        ),
        const SizedBox(width: AppSpacing.s3),
        Expanded(
          child: Text(text, style: AppTextStyles.body(color: dimText)),
        ),
      ],
    );
  }
}

class _SymptomBreakdown extends StatelessWidget {
  const _SymptomBreakdown({required this.answers});
  final List<int> answers;

  @override
  Widget build(BuildContext context) {
    // Sort by score descending for readability — highest symptom first
    final indexed = List.generate(7, (i) => (index: i, score: answers[i]))
      ..sort((a, b) => b.score.compareTo(a.score));

    return Column(
      children: indexed.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.s3),
          child: _SymptomRow(
            label:     _questionLabels[item.index],
            answer:    item.score,
            isHighest: item.score >= 2,
          ),
        );
      }).toList(),
    );
  }
}

class _SymptomRow extends StatelessWidget {
  const _SymptomRow({
    required this.label,
    required this.answer,
    required this.isHighest,
  });

  final String label;
  final int    answer;
  final bool   isHighest;

  Color _barColor(int step) {
    if (step > answer) return AppColors.borderSubtle;
    return switch (answer) {
      0 => AppColors.severityMinimal,
      1 => AppColors.severityMild,
      2 => AppColors.severityModerate,
      3 => AppColors.severitySevere,
      _ => AppColors.borderSubtle,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s3),
      decoration: BoxDecoration(
        color: isHighest
            ? _barColor(answer).withValues(alpha: 0.07)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(
          color: isHighest
              ? _barColor(answer).withValues(alpha: 0.25)
              : AppColors.borderSubtle,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.body(
                    color: isHighest
                        ? colorScheme.onSurface
                        : colorScheme.onSurface.withValues(alpha: 0.65),
                  ),
                ),
                const SizedBox(height: AppSpacing.s2),
                Text(
                  _answerLabels[answer],
                  style: AppTextStyles.caption(
                      color: _barColor(answer).withValues(alpha: 0.9)),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.s4),
          // 4-segment dot indicator (0–3)
          Row(
            children: List.generate(4, (step) {
              final filled = step <= answer;
              return Container(
                width:  8,
                height: 8,
                margin: const EdgeInsets.only(left: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: filled
                      ? _barColor(answer)
                      : AppColors.borderSubtle,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _MaxScoreBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:   double.infinity,
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color:        AppColors.severitySevereBg,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border:       Border.all(
          color: AppColors.severitySevere.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded,
                  size: 18, color: AppColors.severitySevere),
              const SizedBox(width: AppSpacing.s2),
              Text(
                'Skor maksimum',
                style: AppTextStyles.bodyMedium(color: AppColors.severitySevere),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s2),
          Text(
            'Kamu menjawab "Hampir setiap hari" untuk ketujuh pertanyaan. '
            'Ini skor tertinggi yang mungkin — dan mencerminkan beban yang sangat berat. '
            'Tolong jangan hadapi ini sendirian. Hubungi bantuan hari ini.',
            style: AppTextStyles.body(
                color: AppColors.severitySevere.withValues(alpha: 0.9)),
          ),
        ],
      ),
    );
  }
}

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
            Icon(icon, size: 24,
                color: colorScheme.onSurface.withValues(alpha: 0.45)),
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
                    style:
                        AppTextStyles.bodyMedium(color: AppColors.severitySevere)),
                Text('Into The Light Indonesia · 119 ext 8',
                    style:
                        AppTextStyles.caption(color: AppColors.severitySevere)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
