
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login.dart';

serverloader(var context){
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (BuildContext context){
      return Scaffold(
          appBar: AppBar(
            title: Text("Serverauswahl"),
          ),
          body: FutureBuilder(
            future: getServerjson(),
            builder: (context, snapshot){
              if(snapshot.hasError){
                Text("konnte das Json nicht laden");
              }
              if(snapshot.hasData){
                var data = snapshot.data;
                Map<String, dynamic> parsedjson = jsonDecode("$data");
                return Serverwidget(parsedjson);
              }
              return LinearProgressIndicator();
            },
          ),
        );
      }
    ),
  );
}

Future<String> getServerjson() async{
  return await rootBundle.loadString("servers.json");
}
class Serverwidget extends StatelessWidget{
  var data;
  Serverwidget(this.data);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.values.length,
        itemBuilder: (BuildContext context, var i){
          return Center(
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(data["$i"][0]),
                    subtitle: Text(data["$i"][2]),
                    onTap: (){
                      Navigator.pop(context);
                      print(data["$i"][1]);
                    },
                  )
                ],
              ),
            ),
          );
        }
    );
    /*
    return ListView(
      children: data.entries.map((url) =>
          Text(
              url.value.toString())).toList().cast<Text>(),
    );

*/

  }
}