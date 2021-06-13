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
              insetPadding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 3, 10, MediaQuery.of(context).size.width / 3, 10),
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Gebe die ID des Nutzers ein:"),
                    TextField(
                      controller: _usernameController,
                    ),
                    Container(height: 30),
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