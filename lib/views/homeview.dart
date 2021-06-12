import 'package:alpaka_chat/views/appstate.dart';
import 'package:famedlysdk/famedlysdk.dart';
import 'package:flutter/material.dart';

import '../matrix.dart';
import 'chatpage.dart';

class Homeview extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _homeview();
}

class _homeview extends State<Homeview>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deine Chats"),
        centerTitle: true,
        leading: IconButton(
              tooltip: "Your Account",
              alignment: Alignment.centerRight,
              icon: Icon(Icons.account_circle),
              onPressed: (){},
            ),
          actions: [
            IconButton(
                tooltip: "Settings",
                alignment: Alignment.centerRight,
                icon: Icon(Icons.settings),
                onPressed: () {}
            ),
            IconButton(
              tooltip: "Logout",
              alignment: Alignment.centerLeft,
              onPressed: () {
                Matrix.of(context).logout();
                AppStateManager.of(context).setLoggedIn(false);
              },
              icon: Icon(Icons.exit_to_app),
            )
          ]
        ),
      floatingActionButton: FloatingActionButton(
        elevation: 100,
        backgroundColor: Colors.grey,
        tooltip: "New Chat",
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: Matrix.of(context).client.getJoinedRooms(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text(snapshot.error.toString());
          if (!snapshot.hasData) return CircularProgressIndicator();
          return StreamBuilder(
            stream: Matrix.of(context).client.onRoomUpdate.stream,
            builder: (context, snap2) => ListView(
              children: (snapshot.data! as List<String>).map((id) {
                Room room = Matrix.of(context).client.getRoomById(id);
                if (room == null) return Container();
                return ListTile(
                  leading: Icon(room.isUnread ? Icons.notification_important : Icons.account_box),
                  title: Text(room.displayname),
                  subtitle: Text(room.lastEvent.body),
                  onTap: () {
                    Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context) => ChatPage(room),
                    ));
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}