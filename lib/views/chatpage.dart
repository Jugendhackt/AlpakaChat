// ignore: import_of_legacy_library_into_null_safe
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
      body: StreamBuilder(
        stream: Matrix.of(context).client.onEvent.stream,
        builder: (context, snapshot) => _MessageView(room),
      ),
    );
  }

}

class _MessageView extends StatelessWidget {

  Room _room;

  _MessageView(this._room);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Matrix.of(context).client.getRoomEvents(_room.id, _room.prev_batch, Direction.b, limit: 200),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text(snapshot.error.toString());
        if (!snapshot.hasData) return CircularProgressIndicator();
        TimelineHistoryResponse historyResponse = snapshot.data as TimelineHistoryResponse;
        Iterable<MatrixEvent> events = historyResponse.chunk.reversed;
        List<Widget> messageView = events.map((event) {
          if (event.type == "m.room.message") {
            return ListTile(
              title: Text("${event.senderId}"),
              subtitle: Text("${event.content['body']}"),
            );
          } else if (event.type == "m.room.encrypted") {
            return ListTile(
              leading: Icon(Icons.warning_amber_outlined),
              title: Text("Die Nachricht ist verschlüsselt"),
              subtitle: Text("Leider kann AlpakaChat noch keine Nachrichten entschlüsseln"),
            );
          }
          return Container();
        }).toList();
        messageView.add(Divider());
        messageView.add(SendMessageWidget(_room));
        return ListView(
          children: messageView,
        );
      },
    );
  }

}

class SendMessageWidget extends StatelessWidget {

  final TextEditingController _controller = new TextEditingController();
  final Room _room;

  SendMessageWidget(this._room);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 30),
      child: Stack(
        children: [
          TextField(
            controller: _controller,
          ),
          Align(
            child: MaterialButton(
                onPressed: () {
                  if(_controller.text != ""){
                    _room.sendTextEvent(_controller.text);
                    _controller.clear();}
                },
                child: Icon(Icons.send)
            ),
            alignment: Alignment.bottomRight,
          )
        ],
      ),
    );
  }
}