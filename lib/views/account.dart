import 'package:flutter/material.dart';

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
            child: Padding(padding: EdgeInsets.all(20),
            child: Center(
                child: Column(
                  children: [
                    Text(
                      "Accountname",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Image.network('https://picsum.photos/250?image=9')

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

/*_getaccountname(){
  return FutureBuilder(builder: builder)
}*/