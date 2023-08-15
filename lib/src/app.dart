import 'package:custom_slider_sample/src/page/custom_slider.dart';
import 'package:custom_slider_sample/src/page/flutter_default_slider.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  void pageChange(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                pageChange(context, const FlutterDefaultSlider());
              },
              child: const Text('플러터 기본 Slider'),
            ),
            ElevatedButton(
              onPressed: () {
                pageChange(context, const ReviewSliderBar());
              },
              child: const Text('Custom Slider'),
            ),
          ],
        ),
      ),
    );
  }
}
