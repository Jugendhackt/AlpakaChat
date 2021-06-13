import 'package:flutter/material.dart';

import '../matrix.dart';

class AddUser extends StatelessWidget {

  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 100,
      backgroundColor: Colors.grey,
      tooltip: "New Chat",
      onPressed: () {
        showGeneralDialog(context: context,
            barrierLabel: "",
            barrierDismissible: true,
            pageBuilder: (context, a, b) => Dialog(
              //insetPadding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 3, 10, MediaQuery.of(context).size.width / 3, 10),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Gebe die ID des Nutzers ein:"),
                    Container(height: 20),
                    TextField(
                      controller: _usernameController,
                      autocorrect: false,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "@name:server.de",
                          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          border: OutlineInputBorder()
                      ),
                    ),
                    Container(height: 20),
                    ElevatedButton(
                        child: Text("Chat starten"),
                        onPressed: () async {
                          String chatId = await Matrix.of(context).client.startDirectChat(_usernameController.text);
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ),
            ));
      },
      child: Icon(Icons.add),
    );
  }

}