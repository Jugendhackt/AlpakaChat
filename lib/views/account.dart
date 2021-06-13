import 'package:famedlysdk/famedlysdk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

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
                child: Row(
                  children: [
                    _getaccountpic(context),
                  ],
                ),
              )
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: Text("Mitwirkende:"),
                  subtitle: Text("Felix \n beppo \n Louis \n Konrad"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _getaccountpic(context){
  return FutureBuilder(
      future: ((Matrix.of(context).client.getProfileFromUserId(Matrix.of(context).client.userID))),
      builder: (BuildContext context, snapshot){
        print(snapshot.data);
        if(!snapshot.hasData) return CircularProgressIndicator();
        if(snapshot.hasError) return Text("error");
        final displayname = (snapshot.data as Profile).displayname;
        final avatar_url = (snapshot.data as Profile).avatarUrl.getThumbnail(Matrix.of(context).client, width: 20 * MediaQuery.of(context).devicePixelRatio, height: 20 * MediaQuery.of(context).devicePixelRatio,);
        print("$avatar_url");
        return Row(
          children: [
            Image.network("$avatar_url"),
            SizedBox(width: 30,),
            Text(
              "$displayname",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),)
            ],
          );
        }
      );
}

