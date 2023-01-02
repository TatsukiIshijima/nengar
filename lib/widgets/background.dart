import 'package:flutter/material.dart';
import 'package:nengar/gen/colors.gen.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            for (int i = 0; i < 10; i++)
              Expanded(
                flex: 1,
                child: Container(
                  color: i % 2 == 0
                      ? ColorName.primaryTextColor
                      : ColorName.secondaryColor,
                ),
              ),
          ],
        ),
        child
      ],
    );
  }
}
