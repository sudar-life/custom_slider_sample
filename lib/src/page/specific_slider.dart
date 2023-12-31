import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpecificSliderBar extends StatefulWidget {
  const SpecificSliderBar({super.key});

  @override
  State<SpecificSliderBar> createState() => _SpecificSliderBarState();
}

class _SpecificSliderBarState extends State<SpecificSliderBar> {
  final _parentKey = GlobalKey();
  double position = 7;
  double minX = 7;
  double width = 0;
  double value = 0.0;
  double level = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var parentContext = _parentKey.currentContext;
      if (parentContext != null) {
        var parentBox = parentContext.findRenderObject() as RenderBox?;
        width = parentBox!.size.width - 7;
      }
    });
  }

  void updatePointer(double pointer) {
    _setPosition(pointer.clamp(minX, width));
    _setLevel();
    _setValue();
    _update();
  }

  void _setPosition(double value) {
    position = value;
  }

  void _setLevel() {
    level = position / width;
  }

  void _setValue() {
    value = level * 10;
  }

  void _update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    var transformColor = Color.lerp(
        const Color.fromARGB(255, 141, 20, 2), const Color(0xffF4AA2B), level);
    return Scaffold(
      appBar: AppBar(title: const Text('Specific Slider')),
      body: Center(
        child: SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  value.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 23,
                      color: transformColor,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Listener(
                    behavior: HitTestBehavior.translucent,
                    onPointerDown: (event) {
                      updatePointer(event.localPosition.dx);
                    },
                    child: Stack(
                      children: [
                        Container(
                          key: _parentKey,
                          margin: const EdgeInsets.only(top: 9),
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xff434343),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 9),
                          height: 16,
                          width: position,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: transformColor,
                          ),
                          child: Positioned.fill(
                            child: Image.asset(
                              'assets/images/pattern.png',
                              repeat: ImageRepeat.repeat,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: position - 11,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              updatePointer(details.delta.dx + position);
                            },
                            child: SvgPicture.asset(
                              'assets/svg/icons/icon_star.svg',
                              width: 35,
                              colorFilter: const ColorFilter.mode(
                                  Colors.red, BlendMode.srcIn),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
