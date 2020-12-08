import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/blend_mask.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XDSymptoms extends StatelessWidget {
  XDSymptoms({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      body: ListView(children: [
        Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color(0xFFFFFFFF),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x32000000),
                  offset: Offset(3, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0),
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    color: Color(0xFF1956B4),
                    constraints: BoxConstraints.expand(
                      height: 60.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'COVID-19 Symptoms',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 22,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            height: 1.3181818181818181,
                            shadows: [
                              Shadow(
                                color: const Color(0xff000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              )
                            ],
                          ),
                        ),
                        Text(
                          'Last Updated: 11/10/2020\nhttps://www.hyperlinkhere.gov',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 12,
                            color: const Color(0xffffffff),
                            fontStyle: FontStyle.italic,
                            height: 1,
                            shadows: [
                              Shadow(
                                color: const Color(0xff000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              )
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                      'People with COVID-19 have had a wide range of symptoms reported – ranging from mild symptoms to severe illness. Symptoms may appear 2-14 days after exposure to the virus. People with these symptoms may have COVID-19:',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 16,
                        color: const Color(0xff000000),
                        height: 1.375,
                      ),
                      textAlign: TextAlign.left,
                    ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '- Fever or chills\n- Cough\n- Shortness of breath or difficulty breathing\n- Fatigue\n- Muscle or body aches\n- Headache\n- New loss of taste or smell\n- Sore throat\n- Congestion or runny nose\n- Nausea or vomiting\n- Diarrhea',
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 18,
                        color: const Color(0xff000000),
                        height: 1.2222222222222223,
                      ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'This list does not include all possible symptoms. CDC will continue to update this list as we learn more about COVID-19.\n',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 16,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            )),
        Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color(0xFFFFFFFF),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x32000000),
                  offset: Offset(3, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0),
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    color: Color(0xFF1956B4),
                    constraints: BoxConstraints.expand(
                      height: 60.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'What is a Close Contact?',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 22,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            height: 1.3181818181818181,
                            shadows: [
                              Shadow(
                                color: const Color(0xff000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              )
                            ],
                          ),
                        ),
                        Text(
                          'Last Updated: 12/7/2020\nhttps://www.hyperlinkhere.gov',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 12,
                            color: const Color(0xffffffff),
                            fontStyle: FontStyle.italic,
                            height: 1,
                            shadows: [
                              Shadow(
                                color: const Color(0xff000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              )
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'As we track who could have contracted COVID-19, it\'s important to know who is considered a close contact. The CDC\'s definition is below.',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 16,
                      color: const Color(0xff000000),
                      height: 1.375,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'A close contact is any person that was within 6 feet for at least a period of 10 to 30 minutes.',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 18,
                      color: const Color(0xff000000),
                      height: 1.2222222222222223,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'You should keep track of your close contacts so that you are aware of who you could have exposed, or who could have exposed you, to COVID-19.',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 16,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            )),
      ]),
    );
  }
}

const String _svg_vivn0c =
    '<svg viewBox="24.1 157.4 343.0 73.6" ><path transform="translate(24.14, 157.37)" d="M 0 0 L 343 0 L 343 73.625244140625 L 0 73.625244140625 L 0 0 Z" fill="#1bb0b7" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

// Stack(
//   children: <Widget>[
//     Transform.translate(
//       offset: Offset(16.0, 63.0),
//       child:
//           // Adobe XD layer: 'CDC Symptom Guideli…' (group)
//           SizedBox(
//         width: 343.0,
//         height: 610.0,
//         child: Stack(
//           children: <Widget>[
//             Pinned.fromSize(
//               bounds: Rect.fromLTWH(0.0, 0.0, 343.0, 610.0),
//               size: Size(343.0, 610.0),
//               pinLeft: true,
//               pinRight: true,
//               pinTop: true,
//               pinBottom: true,
//               child:
//                   // Adobe XD layer: 'White rectangle' (shape)
//                   Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15.0),
//                   color: const Color(0xffffffff),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0x29000000),
//                       offset: Offset(3, 3),
//                       blurRadius: 6,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Pinned.fromSize(
//               bounds: Rect.fromLTWH(0.0, 16.4, 343.0, 73.6),
//               size: Size(343.0, 610.0),
//               pinLeft: true,
//               pinRight: true,
//               pinTop: true,
//               fixedHeight: true,
//               child:
//                   // Adobe XD layer: 'Header' (group)
//                   Stack(
//                 children: <Widget>[
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(0.0, 0.0, 343.0, 73.6),
//                     size: Size(343.0, 73.6),
//                     pinLeft: true,
//                     pinRight: true,
//                     pinTop: true,
//                     pinBottom: true,
//                     child: SvgPicture.string(
//                       _svg_vivn0c,
//                       allowDrawingOutsideViewBox: true,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(28.0, 38.6, 160.0, 26.0),
//                     size: Size(343.0, 73.6),
//                     pinLeft: true,
//                     pinBottom: true,
//                     fixedWidth: true,
//                     fixedHeight: true,
//                     child: Text(
//                       'Last Updated: MM/DD/YYYY\nhttps://www.hyperlinkhere.gov',
//                       style: TextStyle(
//                         fontFamily: 'Arial',
//                         fontSize: 12,
//                         color: const Color(0xffffffff),
//                         fontStyle: FontStyle.italic,
//                         height: 1,
//                         shadows: [
//                           Shadow(
//                             color: const Color(0xff000000),
//                             offset: Offset(0, 3),
//                             blurRadius: 6,
//                           )
//                         ],
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(28.0, 6.6, 220.0, 25.0),
//                     size: Size(343.0, 73.6),
//                     pinLeft: true,
//                     pinTop: true,
//                     fixedWidth: true,
//                     fixedHeight: true,
//                     child: Text(
//                       'COVID-19 Symptoms',
//                       style: TextStyle(
//                         fontFamily: 'Arial',
//                         fontSize: 22,
//                         color: const Color(0xffffffff),
//                         fontWeight: FontWeight.w700,
//                         height: 1.3181818181818181,
//                         shadows: [
//                           Shadow(
//                             color: const Color(0xff000000),
//                             offset: Offset(0, 3),
//                             blurRadius: 6,
//                           )
//                         ],
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Pinned.fromSize(
//               bounds: Rect.fromLTWH(15.0, 102.0, 314.0, 500.0),
//               size: Size(343.0, 610.0),
//               pinLeft: true,
//               pinRight: true,
//               pinBottom: true,
//               fixedHeight: true,
//               child:
//                   // Adobe XD layer: 'Body Text' (group)
//                   Stack(
//                 children: <Widget>[
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(0.0, 429.0, 314.0, 71.0),
//                     size: Size(314.0, 500.0),
//                     pinLeft: true,
//                     pinRight: true,
//                     pinBottom: true,
//                     fixedHeight: true,
//                     child: Text(
//                       'This list does not include all possible symptoms. CDC will continue to update this list as we learn more about COVID-19.\n',
//                       style: TextStyle(
//                         fontFamily: 'Arial',
//                         fontSize: 16,
//                         color: const Color(0xff000000),
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(0.0, 156.0, 314.0, 258.0),
//                     size: Size(314.0, 500.0),
//                     pinLeft: true,
//                     pinRight: true,
//                     fixedHeight: true,
//                     child: SingleChildScrollView(
//                         child: Text(
//                       '- Fever or chills\n- Cough\n- Shortness of breath or difficulty breathing\n- Fatigue\n- Muscle or body aches\n- Headache\n- New loss of taste or smell\n- Sore throat\n- Congestion or runny nose\n- Nausea or vomiting\n- Diarrhea',
//                       style: TextStyle(
//                         fontFamily: 'Arial',
//                         fontSize: 18,
//                         color: const Color(0xff000000),
//                         height: 1.2222222222222223,
//                       ),
//                       textAlign: TextAlign.left,
//                     )),
//                   ),
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(0.0, 0.0, 314.0, 141.0),
//                     size: Size(314.0, 500.0),
//                     pinLeft: true,
//                     pinRight: true,
//                     pinTop: true,
//                     fixedHeight: true,
//                     child: Text(
//                       'People with COVID-19 have had a wide range of symptoms reported – ranging from mild symptoms to severe illness. Symptoms may appear 2-14 days after exposure to the virus. People with these symptoms may have COVID-19:',
//                       style: TextStyle(
//                         fontFamily: 'Arial',
//                         fontSize: 16,
//                         color: const Color(0xff000000),
//                         height: 1.375,
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//     Container(),
//     // Adobe XD layer: 'Page title' (group)
//     SizedBox(
//       width: 0.0,
//       height: 0.0,
//       child: Stack(
//         children: <Widget>[],
//       ),
//     ),
//   ],
// ),
