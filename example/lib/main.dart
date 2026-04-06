import 'package:flutter/material.dart';
import 'package:inner_shadow_flutter/inner_shadow_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InnerShadow Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const InnerShadowDemoPage(),
    );
  }
}

class InnerShadowDemoPage extends StatefulWidget {
  const InnerShadowDemoPage({super.key});

  @override
  State<InnerShadowDemoPage> createState() => _InnerShadowDemoPageState();
}

class _InnerShadowDemoPageState extends State<InnerShadowDemoPage> {
  double _blur = 10;
  double _offsetX = 10;
  double _offsetY = 10;
  Color _shadowColor = Colors.black38;

  final List<Color> _colorOptions = [
    Colors.black38,
    Colors.blue.withOpacity(0.5),
    Colors.red.withOpacity(0.4),
    Colors.green.withOpacity(0.4),
    Colors.purple.withOpacity(0.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InnerShadow Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Preview ---
            Center(
              child: InnerShadow(
                blur: _blur,
                color: _shadowColor,
                offset: Offset(_offsetX, _offsetY),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Inner\nShadow',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // --- Controls ---
            _buildLabel('Blur: ${_blur.toStringAsFixed(1)}'),
            Slider(
              value: _blur,
              min: 0,
              max: 30,
              onChanged: (v) => setState(() => _blur = v),
            ),

            const SizedBox(height: 12),

            _buildLabel('Offset X: ${_offsetX.toStringAsFixed(1)}'),
            Slider(
              value: _offsetX,
              min: -30,
              max: 30,
              onChanged: (v) => setState(() => _offsetX = v),
            ),

            const SizedBox(height: 12),

            _buildLabel('Offset Y: ${_offsetY.toStringAsFixed(1)}'),
            Slider(
              value: _offsetY,
              min: -30,
              max: 30,
              onChanged: (v) => setState(() => _offsetY = v),
            ),

            const SizedBox(height: 20),

            _buildLabel('Shadow Color'),
            const SizedBox(height: 8),
            Row(
              children: _colorOptions.map((color) {
                final selected = color == _shadowColor;
                return GestureDetector(
                  onTap: () => setState(() => _shadowColor = color),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected ? Colors.deepPurple : Colors.grey,
                        width: selected ? 3 : 1,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 40),

            // --- Code snippet ---
            _buildLabel('Code'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _buildCode(),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.greenAccent,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _buildCode() {
    return '''InnerShadow(
  blur: ${_blur.toStringAsFixed(1)},
  color: Color(0x${_shadowColor.value.toRadixString(16).padLeft(8, '0')}),
  offset: Offset(
    ${_offsetX.toStringAsFixed(1)},
    ${_offsetY.toStringAsFixed(1)},
  ),
  child: YourWidget(),
)''';
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
    );
  }
}
