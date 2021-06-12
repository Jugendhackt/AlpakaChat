import 'package:famedlysdk/famedlysdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../matrix.dart';

class ChatPage extends StatelessWidget {
  
  final Room room;
  
  ChatPage(this.room);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Matrix.of(context).client.getRoomEvents(room.id, room.prev_batch, Direction.b, limit: 200),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text(snapshot.error.toString());
          if (!snapshot.hasData) return CircularProgressIndicator();
          TimelineHistoryResponse historyResponse = snapshot.data as TimelineHistoryResponse;
          Iterable<MatrixEvent> events = historyResponse.chunk.reversed;
          return ListView(
            children: events.map((event) {
              if (event.type == "m.room.message") {
                return ListTile(
                  title: Text("${event.senderId}"),
                  subtitle: Text("${event.content['body']}"),
                );
              }
              return Container();
            }).toList(),
          );
        },
      ),
    );
  }

}