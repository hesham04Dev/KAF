import 'package:flutter/material.dart';

class IsRtlBackIcon extends StatelessWidget {
  bool isRtl;
  IsRtlBackIcon({super.key, this.isRtl = false});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        origin: Offset.zero,
        angle: isRtl ? 3.14 : 0,
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
        ));
  }
}
