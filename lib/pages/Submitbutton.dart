import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class Submitbutton extends StatelessWidget {
  Submitbutton({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 148.0, 48.0),
          size: Size(148.0, 48.0),
          pinLeft: true,
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: const Color(0xffffffff),
              border: Border.all(width: 2.0, color: const Color(0xff000000)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(5, 5),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(40.0, 15.0, 68.0, 20.0),
          size: Size(148.0, 48.0),
          fixedWidth: true,
          fixedHeight: true,
          child: Text(
            'SUBMIT',
            style: TextStyle(
              fontFamily: 'Arial',
              fontSize: 18,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w700,
              height: 1.6666666666666667,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
