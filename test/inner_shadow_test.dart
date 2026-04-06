import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inner_shadow_flutter/inner_shadow_flutter.dart';

void main() {
  group('InnerShadow', () {
    testWidgets('renders child widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InnerShadow(
              child: SizedBox(
                width: 100,
                height: 100,
                key: Key('inner-child'),
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('inner-child')), findsOneWidget);
    });

    testWidgets('renders with default properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InnerShadow(
              child: SizedBox(width: 100, height: 100),
            ),
          ),
        ),
      );

      final widget = tester.widget<InnerShadow>(find.byType(InnerShadow));
      expect(widget.blur, 10.0);
      expect(widget.color, Colors.black38);
      expect(widget.offset, const Offset(10, 10));
    });

    testWidgets('renders with custom properties', (WidgetTester tester) async {
      const customColor = Colors.red;
      const customBlur = 5.0;
      const customOffset = Offset(4, 4);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InnerShadow(
              blur: customBlur,
              color: customColor,
              offset: customOffset,
              child: SizedBox(width: 100, height: 100),
            ),
          ),
        ),
      );

      final widget = tester.widget<InnerShadow>(find.byType(InnerShadow));
      expect(widget.blur, customBlur);
      expect(widget.color, customColor);
      expect(widget.offset, customOffset);
    });

    testWidgets('renders without child', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InnerShadow(),
          ),
        ),
      );

      expect(find.byType(InnerShadow), findsOneWidget);
    });

    testWidgets('updates when properties change', (WidgetTester tester) async {
      double blur = 10;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return GestureDetector(
                  key: const Key('toggle-shadow'),
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => blur = 20),
                  child: InnerShadow(
                    blur: blur,
                    child: const SizedBox(width: 100, height: 100),
                  ),
                );
              },
            ),
          ),
        ),
      );

      expect(
        tester.widget<InnerShadow>(find.byType(InnerShadow)).blur,
        10.0,
      );

      await tester.tap(find.byKey(const Key('toggle-shadow')));
      await tester.pump();

      expect(
        tester.widget<InnerShadow>(find.byType(InnerShadow)).blur,
        20.0,
      );
    });
  });
}
