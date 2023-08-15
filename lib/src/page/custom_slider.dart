import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviewSliderBar extends StatefulWidget {
  final double initValue;
  const ReviewSliderBar({super.key, this.initValue = 0});

  @override
  State<ReviewSliderBar> createState() => _ReviewSliderBarState();
}

class _ReviewSliderBarState extends State<ReviewSliderBar> {
  GlobalKey _parentKey = GlobalKey();
  double position = 7;
  double minX = 7;
  double width = 0;
  double value = 0.0;
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

  @override
  void didUpdateWidget(ReviewSliderBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    initValue();
  }

  void initValue() {
    setState(() {
      position = widget.initValue * width / 10;
      value = widget.initValue;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Slider')),
      body: Center(
        child: SizedBox(
          height: 45,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  value.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xffF4AA2B),
                  ),
                ),
                Expanded(
                  child: Listener(
                    behavior: HitTestBehavior.translucent,
                    onPointerDown: (event) {
                      setState(() {
                        position = event.localPosition.dx.clamp(minX, width);
                        value = position / width * 10;
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          key: _parentKey,
                          margin: const EdgeInsets.only(top: 9),
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xff434343),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 9),
                          height: 5,
                          width: position,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xffF4AA2B),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: position - 11,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              setState(() {
                                position = (details.delta.dx + position)
                                    .clamp(minX, width);
                                value = position / width * 10;
                              });
                            },
                            child: SvgPicture.asset(
                              'assets/svg/icons/icon_star.svg',
                              width: 22,
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
