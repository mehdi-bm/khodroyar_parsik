import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/persian_digits.dart';
import '../domain/tutorial_video.dart';

class TutorialPlayerPage extends StatelessWidget {
  const TutorialPlayerPage({super.key, required this.videoId});

  final String videoId;

  @override
  Widget build(BuildContext context) {
    final video = tutorialById(videoId);
    if (video == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('این آموزش پیدا نشد.')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(video.title)),
      body: ListView(
        padding: AppSpacing.page(context),
        children: [
          _VideoPlayerCard(url: video.url),
          const SizedBox(height: AppSpacing.lg),
          for (var i = 0; i < video.steps.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    toPersianDigits('${i + 1}.'),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      video.steps[i],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _VideoPlayerCard extends StatefulWidget {
  const _VideoPlayerCard({required this.url});

  final Uri url;

  @override
  State<_VideoPlayerCard> createState() => _VideoPlayerCardState();
}

class _VideoPlayerCardState extends State<_VideoPlayerCard> {
  VideoPlayerController? _controller;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final previous = _controller;
    final controller = VideoPlayerController.networkUrl(widget.url);
    setState(() {
      _controller = controller;
      _failed = false;
    });
    await previous?.dispose();
    try {
      await controller.initialize();
      if (!mounted || _controller != controller) return;
      controller.addListener(_onTick);
      await controller.play();
      setState(() {});
    } catch (_) {
      if (mounted && _controller == controller) setState(() => _failed = true);
    }
  }

  void _onTick() {
    if (!mounted) return;
    if (_controller?.value.hasError ?? false) {
      setState(() => _failed = true);
    } else {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onTick);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = _controller;
    // Recordings are portrait phone screens; cap the height so the steps
    // below stay reachable without much scrolling.
    final maxHeight = MediaQuery.sizeOf(context).height * 0.62;

    Widget child;
    if (_failed) {
      child = SizedBox(
        height: 240,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wifi_off, size: 40, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(height: AppSpacing.sm),
                const Text(
                  'ویدیو بارگیری نشد. اتصال اینترنت را بررسی کنید.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),
                OutlinedButton.icon(
                  onPressed: _load,
                  icon: const Icon(Icons.refresh),
                  label: const Text('تلاش دوباره'),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (controller == null || !controller.value.isInitialized) {
      child = const SizedBox(
        height: 240,
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      final value = controller.value;
      child = Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: AspectRatio(
              aspectRatio: value.aspectRatio,
              child: GestureDetector(
                onTap: () => value.isPlaying ? controller.pause() : controller.play(),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(controller),
                    if (!value.isPlaying)
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(AppSpacing.sm),
                          child: Icon(Icons.play_arrow, size: 48, color: Colors.white),
                        ),
                      ),
                    if (value.isBuffering)
                      const CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
          // Progress runs left-to-right like any media timeline, even in RTL.
          Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                AppSpacing.sm,
                AppSpacing.sm,
                0,
              ),
              child: Row(
                children: [
                  IconButton(
                    tooltip: value.isPlaying ? 'توقف' : 'پخش',
                    onPressed: () =>
                        value.isPlaying ? controller.pause() : controller.play(),
                    icon: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow),
                  ),
                  Text(_format(value.position)),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: VideoProgressIndicator(
                      controller,
                      allowScrubbing: true,
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                      colors: VideoProgressColors(
                        playedColor: theme.colorScheme.primary,
                        bufferedColor: theme.colorScheme.primary.withValues(alpha: 0.3),
                        backgroundColor: theme.colorScheme.surfaceContainerHighest,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(_format(value.duration)),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Card(clipBehavior: Clip.antiAlias, child: child);
  }

  static String _format(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return toPersianDigits('${two(d.inMinutes)}:${two(d.inSeconds % 60)}');
  }
}
