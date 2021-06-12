
import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

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
              }
              if(snapshot.hasData){
              }
              var data = snapshot.data;
              return Serverwidget(json.decode("$data"));
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
  Serverwidget(var data);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemBuilder: (BuildContext context, var i){
          return Center(
            child: Card(
              child: Column(
                children: [
                  Text("$data")
                ],
              ),  
            ),
          );
        }
    );
  }

}


class Album {
  final String hostname;
  final String description;
  final String category;

  Album({
    required this.hostname,
    required this.description,
    required this.category,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      hostname: json['hostname'],
      description: json['description'],
      category: json['category'],
    );
  }
}
