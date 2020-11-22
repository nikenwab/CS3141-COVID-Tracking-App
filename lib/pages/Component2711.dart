import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class Component2711 extends StatelessWidget {
  Component2711({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 30.0, 30.0),
          size: Size(30.0, 30.0),
          pinLeft: true,
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color(0xffffffff),
              border: Border.all(width: 1.0, color: const Color(0xff1bb0b7)),
            ),
          ),
        ),
      ],
    );
  }
}
