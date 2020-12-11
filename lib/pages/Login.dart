import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatelessWidget {
  Login({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1956b4),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(3.0, 22.0),
            child:
                // Adobe XD layer: 'HotSpot! 2 (1)' (shape)
                Container(
              width: 384.0,
              height: 384.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(40.0, 624.0),
            child:
                // Adobe XD layer: 'Login' (group)
                SizedBox(
              width: 295.0,
              height: 48.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 295.0, 48.0),
                    size: Size(295.0, 48.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(
                            width: 2.0, color: const Color(0xff2699fb)),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(93.0, 19.0, 110.0, 11.0),
                    size: Size(295.0, 48.0),
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'CREATE AN ACCOUNT',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 10,
                        color: const Color(0xff2699fb),
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(40.0, 546.0),
            child:
                // Adobe XD layer: 'Continue' (group)
                SizedBox(
              width: 295.0,
              height: 48.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 295.0, 48.0),
                    size: Size(295.0, 48.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: const Color(0xff2699fb),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(118.0, 18.0, 58.0, 12.0),
                    size: Size(295.0, 48.0),
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'CONTINUE',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 11,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                        height: 1.1818181818181819,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(40.0, 304.0),
            child:
                // Adobe XD layer: 'Inputs' (none)
                SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 24,
                children: [
                  {
                    'text': 'johndoe@mail.com',
                  },
                  {
                    'text': '●●●●●●●',
                  }
                ].map((map) {
                  final text = map['text'];
                  return
                      // Adobe XD layer: 'inputs' (group)
                      SizedBox(
                    width: 295.0,
                    height: 48.0,
                    child: Stack(
                      children: <Widget>[
                        SvgPicture.string(
                          _svg_ktgyhw,
                          allowDrawingOutsideViewBox: true,
                        ),
                        Transform.translate(
                          offset: Offset(24.0, 16.0),
                          child: Text(
                            text,
                            style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 14,
                              color: const Color(0xff2699fb),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(175.0, 512.0),
            child:
                // Adobe XD layer: 'Divider' (shape)
                Container(
              width: 24.0,
              height: 4.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: const Color(0xffbce0fd),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_ktgyhw =
    '<svg viewBox="40.0 209.0 295.0 48.0" ><path transform="translate(40.0, 209.0)" d="M 24 0 L 271 0 C 284.2548217773438 0 295 10.74516487121582 295 24 C 295 37.25483703613281 284.2548217773438 48 271 48 L 24 48 C 10.74516487121582 48 0 37.25483703613281 0 24 C 0 10.74516487121582 10.74516487121582 0 24 0 Z" fill="#ffffff" stroke="#bce0fd" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
