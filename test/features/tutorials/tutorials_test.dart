import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/tutorials/domain/tutorial_video.dart';
import 'package:caryar/features/tutorials/presentation/tutorial_player_page.dart';
import 'package:caryar/features/tutorials/presentation/tutorials_page.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    home: Directionality(textDirection: TextDirection.rtl, child: child),
  );

  test('every chapter has a unique id and an https mp4 url', () {
    final ids = tutorialVideos.map((v) => v.id).toSet();
    expect(ids, hasLength(tutorialVideos.length));
    for (final video in tutorialVideos) {
      expect(video.url.scheme, 'https');
      expect(video.url.path, endsWith('.mp4'));
      expect(video.steps, isNotEmpty);
      expect(tutorialById(video.id), same(video));
    }
  });

  testWidgets('chapter list shows every tutorial with Persian numbering', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const TutorialsPage()));

    for (final video in tutorialVideos.take(3)) {
      expect(find.text(video.title), findsOneWidget);
    }
    expect(find.text('۱'), findsOneWidget);
  });

  testWidgets('player page shows the chapter steps under the video', (
    tester,
  ) async {
    final video = tutorialVideos.first;
    await tester.pumpWidget(wrap(TutorialPlayerPage(videoId: video.id)));
    await tester.pump();

    expect(find.text(video.title), findsOneWidget);
    expect(find.text(video.steps.first), findsOneWidget);
  });

  testWidgets('unknown chapter id shows a not-found message', (tester) async {
    await tester.pumpWidget(wrap(const TutorialPlayerPage(videoId: 'nope')));

    expect(find.text('این آموزش پیدا نشد.'), findsOneWidget);
  });
}
