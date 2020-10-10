import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String statusStr = 'Negative';
  bool status = false;

  void _checkStatus() {
    if (status == false) {
      statusStr = 'Positive';
      status = true;
    } else {
      statusStr = 'Negative';
      status = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/frame_02_delay-0.05s.jpg'),
              radius: 30,
            ),
            SizedBox(height: 20),
            Text(
              'Name',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Gilligan The Parrot',
              style: TextStyle(
                color: Colors.blueAccent,
                letterSpacing: 1.5,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Current Status',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '$statusStr',
              style: TextStyle(
                color: Colors.blueAccent,
                letterSpacing: 1.5,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            RaisedButton.icon(
              onPressed: () {
                setState(() {
                  _checkStatus();
                });
              },
              icon: Icon(
                Icons.warning,
              ),
              label: Text(
                'Update',
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1.5,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
