import 'package:flutter/material.dart';
// import 'package:adobe_xd/pinned.dart';
// import './Component2711.dart';
// import './Submitbutton.dart';
// import 'package:adobe_xd/blend_mask.dart';

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
  List<bool> checked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<String> symptoms = [
    'Fever or chills',
    'Cough',
    'Shortness of breath or difficulty breathing',
    'Fatigue',
    'Muscle or body aches',
    'Headache',
    'New loss of taste or smell',
    'Sore throat',
    'Congestion or runny nose',
    'Nausea or vomiting',
    'Diarrhea'
  ];

  var lastSubmitted = new DateTime.utc(2020, 12, 1);

  createAlertDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text('Daily Symptom Form'),
          content: Text(
            'Your form has been successfully submitted.',
            style: TextStyle(
              fontSize: 12.0
            ),
          ),
          actions: <Widget> [
            TextButton(
              child: Text('Okay'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF1956B4)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]
        );
    });
  }

  createResubmitDialog(BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
              title: Text('Daily Symptom Form'),
              content: Text(
                'You have already submitted this form today. Please resubmit tomorrow.',
                style: TextStyle(
                    fontSize: 12.0
                ),
              ),
              actions: <Widget> [
                TextButton(
                  child: Text('Okay'),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF1956B4)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          SizedBox(
            child: Text(
              'According to the CDC, people with COVID-19 have had a wide range of symptoms reported – ranging from mild symptoms to severe illness. People with the symptoms listed below may have COVID-19. \n',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(
              child: Text(
            'Mark all symptoms that you have experienced in the last 24 hours that are not attributable to a known condition:',
            style: TextStyle(
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Arial',
            ),
          )),
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
                  activeColor: Color(0xFF1956B4),
                ),
                Text(
                  '${symptoms[i]}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.black),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          RaisedButton(
            onPressed: () {
              setState(() {
                for (var i = 0; i < 11; i += 1)
                  checked[i] = false;
              });
              var currTime = new DateTime.now();
              if(currTime.month == lastSubmitted.month && currTime.day == lastSubmitted.day && currTime.year == lastSubmitted.year) {
                createResubmitDialog(context);
              } else {
                setState(() {
                  lastSubmitted = currTime;
                });
                createAlertDialog(context);
              }
            },
            child: Text('Submit'),
            color: Color(0xFF1956B4),
            textColor: Color(0xFFFFFFFF),
          )
        ],
      ),
    );
  }
}

