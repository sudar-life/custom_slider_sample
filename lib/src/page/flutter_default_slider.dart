import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class FlutterDefaultSlider extends StatefulWidget {
  const FlutterDefaultSlider({super.key});

  @override
  State<FlutterDefaultSlider> createState() => _FlutterDefaultSliderState();
}

class _FlutterDefaultSliderState extends State<FlutterDefaultSlider> {
  double sliderValue = 0;
  ui.Image? customImage;

  Future<ui.Image> load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  @override
  void initState() {
    super.initState();
    load('assets/images/icon_star.png').then((image) {
      setState(() {
        customImage = image;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('플러터 기본 Slider')),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: Stack(
            children: [
              Positioned(
                left: 25,
                top: 5,
                child: Text(
                  sliderValue.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xffF4AA2B),
                  ),
                ),
              ),
              if (customImage != null)
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 5.0,
                    activeTrackColor: const Color(0xffF4AA2B),
                    inactiveTrackColor: const Color(0xff434343),
                    thumbShape: SliderThumbImage(customImage!),
                  ),
                  child: Slider(
                    value: sliderValue,
                    min: 0.0,
                    max: 10.0,
                    onChanged: (double newValue) {
                      setState(
                        () {
                          sliderValue = newValue;
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliderThumbImage extends SliderComponentShape {
  final ui.Image image;

  SliderThumbImage(this.image);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(0, 0);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;
    final imageWidth = image.width;
    final imageHeight = image.height;

    Offset imageOffset = Offset(
      center.dx - (imageWidth / 2),
      center.dy - (imageHeight / 2),
    );

    Paint paint = Paint()..filterQuality = FilterQuality.high;

    canvas.drawImage(image, imageOffset, paint);
  }
}
