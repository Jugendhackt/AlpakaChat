
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';

class Serverloader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (BuildContext context, var i) {
          return Text("$i");
    });
  }
  
}