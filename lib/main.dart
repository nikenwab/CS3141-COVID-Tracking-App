import 'package:flutter/material.dart';
import 'package:flutter_appmockup/pages/home.dart';
import 'package:flutter_appmockup/pages/user_profile.dart';
import 'package:flutter_appmockup/pages/map.dart';

void main() =>  runApp(myApp());

class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {

  int index = 0;
  List<Widget> list = [
    Home(),
    UserProfile(),
    Map(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Nav Bar"),
        ),
        body: list[index],
        drawer: MyDrawer(onTap: (ctx, i){
          setState(() {
            index = i;
            Navigator.pop(ctx);
          });
        },),
      ),
      //UserProfile(),
    );
  }
}

class MyDrawer extends StatelessWidget {

  final Function onTap;
  MyDrawer({
    this.onTap
});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black54),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/frame_02_delay-0.05s.jpg'),
                          radius: 30,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      'Gilligan The Parrot',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 3,),
                    Text(
                      'Current Status',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      )
                    )
                  ],
                )
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: ()=>onTap(context,0),
            ),
            ListTile(
              leading: Icon(Icons.portrait),
              title: Text('Profile'),
              onTap: ()=>onTap(context,1),
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Map'),
              onTap: ()=>onTap(context,2),
            ),
          ],
        )
      )
    );
  }
}

