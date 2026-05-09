import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saujana/core/db/hive_service.dart';
import 'package:saujana/core/router/app_router.dart';
import 'package:saujana/core/theme/app_colors.dart';
import 'package:saujana/core/theme/app_spacing.dart';
import 'package:saujana/core/theme/app_text_styles.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late List<Map<String, dynamic>> _items;

  @override
  void initState() {
    super.initState();
    _items = HiveService.getAllAssessments();
  }

  void _delete(String id) {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Hapus hasil ini?', style: AppTextStyles.h3()),
        content: Text(
          'Data ini akan dihapus permanen dari perangkatmu.',
          style: AppTextStyles.body(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Hapus',
                style: AppTextStyles.bodyMedium(color: AppColors.severitySevere)),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true) {
        HiveService.deleteAssessment(id);
        setState(() => _items = HiveService.getAllAssessments());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.go(AppRoutes.home),
        ),
        title: Text('Riwayat', style: AppTextStyles.h3()),
      ),
      body: _items.isEmpty
          ? _EmptyState(onStart: () => context.go(AppRoutes.assessment))
          : ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH,
                vertical:   AppSpacing.s4,
              ),
              itemCount:   _items.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: AppSpacing.s3),
              itemBuilder: (context, index) {
                final item = _items[index];
                return _HistoryItem(
                  data:     item,
                  onDelete: () => _delete(item['id'] as String),
                );
              },
            ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  const _HistoryItem({required this.data, required this.onDelete});

  final Map<String, dynamic> data;
  final VoidCallback         onDelete;

  @override
  Widget build(BuildContext context) {
    final score    = data['score'] as int;
    final severity = data['severity'] as String;
    final ts       = DateTime.fromMillisecondsSinceEpoch(data['timestamp'] as int);
    final dayFull  = _dayFull(ts.weekday);
    final dateStr  = '$dayFull, ${ts.day} ${_monthLabel(ts.month)} ${ts.year}';

    final (label, bg, fg) = _badge(severity);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s4, vertical: AppSpacing.s4),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dateStr, style: AppTextStyles.bodyMedium()),
                  const SizedBox(height: AppSpacing.s1),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color:        bg,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                    child: Text(label, style: AppTextStyles.caption(color: fg)),
                  ),
                ],
              ),
            ),
            Text('$score',
                style: AppTextStyles.h2(
                    color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(width: AppSpacing.s3),
            IconButton(
              icon: Icon(Icons.delete_outline, size: 20,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3)),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  (String, Color, Color) _badge(String severity) => switch (severity) {
    'minimal'  => ('Minimal', AppColors.severityMinimalBg,  AppColors.severityMinimal),
    'mild'     => ('Ringan',  AppColors.severityMildBg,     AppColors.severityMild),
    'moderate' => ('Sedang',  AppColors.severityModerateBg, AppColors.severityModerate),
    'severe'   => ('Berat',   AppColors.severitySevereBg,   AppColors.severitySevere),
    _          => ('—',       AppColors.bgSurfaceAlt,        AppColors.textSecondary),
  };

  String _dayFull(int weekday) {
    const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    return days[weekday - 1];
  }

  String _monthLabel(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
                    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    return months[month - 1];
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onStart});
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bar_chart_outlined, size: 48,
                color: colorScheme.onSurface.withValues(alpha: 0.2)),
            const SizedBox(height: AppSpacing.s4),
            Text('Belum ada hasil',
                style: AppTextStyles.h3(
                    color: colorScheme.onSurface.withValues(alpha: 0.4))),
            const SizedBox(height: AppSpacing.s2),
            Text('Lakukan asesmen pertamamu untuk mulai melacak.',
                style: AppTextStyles.body(
                    color: colorScheme.onSurface.withValues(alpha: 0.4)),
                textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.s6),
            ElevatedButton(
              onPressed: onStart,
              child: const Text('Mulai sekarang'),
            ),
          ],
        ),
      ),
    );
  }
}
