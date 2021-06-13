import 'package:famedlysdk/famedlysdk.dart';
import 'package:flutter/material.dart';

import '../matrix.dart';

class Settingsview extends StatefulWidget{
  @override
  _settingsviewstate createState() => _settingsviewstate();

}

class _settingsviewstate extends State<Settingsview>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accounts"),
      ),
      body: ListView(
        children: [
          Card(
            child: Padding(padding: EdgeInsets.all(15),
            child: Center(
                child: Column(
                  children: [
                    _getaccountname(context),
                    _getaccountpic(context),
                    SizedBox(height: 15,),
                    Image.network('https://picsum.photos/250?image=9',width: 700,)
                  ],
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}

Widget _getaccountname(context){
  return FutureBuilder(
      future: (Matrix.of(context).client.getUserProfile(Matrix.of(context).client.userID)),
      builder: (BuildContext context, snapshot){
        print(snapshot.data);
    if(!snapshot.hasData) return CircularProgressIndicator();
    if(snapshot.hasError) return Text("error");
    var name = (snapshot.data as Profile).displayname;
    return Text(
      "$name",
      style: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 30,
    ),);
  });
}
Widget _getaccountpic(context){
  return FutureBuilder(
      future: (Matrix.of(context).client.getAvatarUrl(Matrix.of(context).client.userID)),
      builder: (BuildContext context, snapshot){
        print(snapshot.data);
        if(!snapshot.hasData) return CircularProgressIndicator();
        if(snapshot.hasError) return Text("error");
        print(snapshot.data);
        var name = snapshot.data;
        return Image.network("$name");
      });
}

