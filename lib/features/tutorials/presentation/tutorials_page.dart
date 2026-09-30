import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/persian_digits.dart';
import '../domain/tutorial_video.dart';

class TutorialsPage extends StatelessWidget {
  const TutorialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('آموزش کار با برنامه')),
      body: ListView(
        padding: AppSpacing.page(context),
        children: [
          Text(
            'هر بخش یک ویدیوی کوتاه است. برای پخش ویدیوها به اینترنت نیاز '
            'دارید؛ بقیه برنامه بدون اینترنت کار می‌کند.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          for (var i = 0; i < tutorialVideos.length; i++)
            Card(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  foregroundColor: theme.colorScheme.onPrimaryContainer,
                  child: Text(toPersianDigits('${i + 1}')),
                ),
                title: Text(tutorialVideos[i].title),
                subtitle: Text(tutorialVideos[i].summary),
                trailing: Icon(
                  Icons.play_circle_outline,
                  color: theme.colorScheme.primary,
                ),
                onTap: () => context.push(
                  AppRoutes.tutorialPlayer(tutorialVideos[i].id),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
