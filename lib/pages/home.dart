import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:hotspot_app/DB/location.dart';
import 'package:hotspot_app/main.dart';

bool termsAccepted = true;



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  MaterialButton _showTerms(BuildContext context) {
    if (!termsAccepted) {
      return MaterialButton(
          height: 50,
          child: Text("View Terms"),
          color: Colors.amber,
          onPressed: () {
            showPopupWindow(
              context,
              gravity: KumiPopupGravity.center,
              //curve: Curves.elasticOut,
              bgColor: Colors.grey.withOpacity(0.5),
              clickOutDismiss: true,
              clickBackDismiss: true,
              customAnimation: false,
              customPop: false,
              customPage: false,
              //targetRenderBox: (btnKey.currentContext.findRenderObject() as RenderBox),
              //needSafeDisplay: true,
              underStatusBar: false,
              underAppBar: true,
              offsetX: 0,
              offsetY: 0,
              duration: Duration(milliseconds: 200),
              /*
              onShowStart: (pop) {
                print("showStart");
              },
              onShowFinish: (pop) {
                print("showFinish");
              },
              onDismissStart: (pop) {
                print("dismissStart");
              },
              onDismissFinish: (pop) {
                print("dismissFinish");
              },
              onClickOut: (pop){
                print("onClickOut");
              },
              onClickBack: (pop){
                print("onClickBack");
              },
              */
              childFun: (pop) {
                return Container(

                    key: GlobalKey(),
                    padding: EdgeInsets.all(10),
                    height: 600,
                    width: 300,
                    color: Colors.white,

                    child: Scaffold(

                        appBar: AppBar(
                          title: Text('Terms of Usage'),
                          centerTitle: true,
                          backgroundColor: Colors.redAccent,
                        ),

                      body: Padding(

                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),

                        child: Column (
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[

                            Container(
                              alignment: Alignment.topCenter,
                                child: SizedBox(
                                    child: Text("This is a bunch of text!\n"
                                        "This is a bunch of text!\n"
                                        "This is a bunch of text!\n"
                                        "This is a bunch of text!\n"
                                        "This is a bunch of text!\n"
                                        "This is a bunch of text!\n"
                                        "This is a bunch of text!\n"
                                        "This is a bunch of text!\n"
                                    ),
                                )
                            ),

                              Container(
                                alignment: Alignment.bottomCenter,
                                child: MaterialButton(
                                  height: 50,
                                    child: Text("Accept"),

                                  onPressed: () {
                                    setState(() {
                                      termsAccepted = true;
                                    });
                                  },
                                ),

                              )
                            ,
                            FutureBuilder(
                              future: dbManager.getLocationList(),
                              builder: (context,snapshot){
                                if(snapshot.hasData) {
                                  locationList = snapshot.data;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: locationList == null ?0 : locationList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      Location lo = locationList[index];
                                      return Card(
                                        child: Row(
                                          children: <Widget>[
                                            Text('Latitude: ${lo.latitude}'),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                                return new CircularProgressIndicator();
                              },

                            ),

                          ]
                        )
                      )
                    ),
                );
              },
            );
          }
      );

    } else {

      return MaterialButton(
          height: 50,
          child: Text("Terms accepted!"),
          color: Colors.amber,
          onPressed: () {
            setState(() {
              _showTerms(context);
            });
            termsAccepted = false;
          }
      );

    }
  }

  KumiPopupWindow popupWindow;

  Widget build(BuildContext context) {
    return Column(
      children: [ Container(
        alignment: Alignment.topCenter,
          child: Text(
              'Home',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600
            )
          )
        ),
        _showTerms(context)
      ]
    );
  }

}

