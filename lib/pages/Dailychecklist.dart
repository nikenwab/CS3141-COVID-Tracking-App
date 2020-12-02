import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import './Component2711.dart';
import './Submitbutton.dart';
import 'package:adobe_xd/blend_mask.dart';

class Dailychecklist extends StatefulWidget {
  Dailychecklist({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DailyChecklistState();
  }
}

class _DailyChecklistState extends State<Dailychecklist> {
  List<bool> checked = [false, false, false, false, false, false, false, false, false, false, false];
  List<String> symptoms = ['Fever or chills', 'Cough', 'Shortness of breath or difficulty breathing', 'Fatigue',
    'Muscle or body aches', 'Headache', 'New loss of taste or smell', 'Sore throat', 'Congestion or runny nose',
    'Nausea or vomiting', 'Diarrhea'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        title: const Text('Daily Checklist'),
        backgroundColor: Color(0xFF1BB0B7),
      ),
      body: Stack(
        children: <Widget>[
          Container(),
          Transform.translate(
            offset: Offset(17.0, 86.0),
            child:
            // Adobe XD layer: 'CDC Symptom Guideli…' (group)
            SizedBox(
              width: 349.0,
              height: 205.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 349.0, 205.0),
                    size: Size(349.0, 205.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child:
                    // Adobe XD layer: 'Body Text' (group)
                    Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 116.0, 330.0, 89.0),
                          size: Size(349.0, 205.0),
                          pinLeft: true,
                          pinRight: true,
                          pinBottom: true,
                          fixedHeight: true,
                          child: Text(
                            'Mark all symptoms that you have experienced in the last 24 hours that are not attributable to a known condition:',
                            style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(5.0, 0.0, 344.0, 116.0),
                          size: Size(349.0, 205.0),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          fixedHeight: true,
                          child: SingleChildScrollView(
                              child: Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 16,
                                    color: const Color(0xff000000),
                                    height: 1.8333333333333333,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                      'According to the CDC, people with COVID-19 have had a wide range of symptoms reported – ranging from mild symptoms to severe illness. People with the symptoms listed below may have COVID-19. \n',
                                    ),
                                    TextSpan(
                                      text: '  ',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.left,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
              offset: Offset(20.0, 291.0),
              child:
              // Symptom check boxes group
              Column(
                children: [
                  for (var i = 0; i < 11; i += 1)
                    Row(
                      children: [
                        Checkbox(
                          onChanged: (bool value) {
                            setState(() {
                              checked[i] = value;
                            });
                          },
                          value: checked[i],
                          activeColor: Color(0xFF1BB0B7),
                        ),
                        Text(
                          '${symptoms[i]}',
                          style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.black),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                ],
              )
          ),
          Container(),
        ],
      ),
    );
  }
}

// Reference
// FlatButton(
// child: Text("Go back home"),
// color: Colors.blue,
// onPressed: (){
// Navigator.pop(context);
// }
// ),
