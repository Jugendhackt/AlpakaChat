import 'package:alpaka_chat/views/adduser.dart';
import 'package:alpaka_chat/views/appstate.dart';
import 'package:famedlysdk/famedlysdk.dart';
import 'package:flutter/material.dart';

import '../matrix.dart';
import 'account.dart';
import 'chatpage.dart';

class Homeview extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _homeview();
}

class _homeview extends State<Homeview>{

  final List<String> roomIds = [];

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
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settingsview()),
              ),
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
      floatingActionButton: AddUser(),
      body: FutureBuilder(
        future: Matrix.of(context).client.getJoinedRooms(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text(snapshot.error.toString());
          if (!snapshot.hasData) return CircularProgressIndicator();
          if (roomIds.isEmpty) roomIds.addAll(snapshot.data as List<String>);
          return StreamBuilder(
            stream: Matrix.of(context).client.onRoomUpdate.stream,
            builder: (context, snap2) {
              if (snap2.hasData && !roomIds.contains((snap2.data as RoomUpdate).id)) roomIds.add((snap2.data as RoomUpdate).id);
              List<Room> rooms = (roomIds).map((id) => Matrix.of(context).client.getRoomById(id)).toList();
              rooms = rooms.whereType<Room>().toList();
              rooms.sort((a,b) => b.lastEvent.time.compareTo(a.lastEvent.time));
              return ListView(
                children: (rooms).map((room) => ListTile(
                  leading:
                  room.avatar?.getThumbnail(Matrix.of(context).client) != null
                      ? Image.network("${room.avatar?.getThumbnail(Matrix.of(context).client, width: 64, height: 64, method: ThumbnailMethod.crop )}")
                      : Icon(room.isUnread ? Icons.notification_important : Icons.account_box),
                  title: Text(room.displayname),
                  subtitle: Text(room.lastEvent.body),
                  onTap: () {
                    Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context) => ChatPage(room),
                    ));
                  },
                )).toList(),
              );
            },
          );
        },
      ),
    );
  }
}