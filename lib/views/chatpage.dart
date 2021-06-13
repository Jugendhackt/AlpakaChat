// ignore: import_of_legacy_library_into_null_safe
import 'package:famedlysdk/famedlysdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../matrix.dart';

class ChatPage extends StatelessWidget {
  
  final Room room;
  final SendMessageWidget _sendMessageWidget;

  ChatPage(this.room) :
        _sendMessageWidget = SendMessageWidget(room);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Matrix.of(context).client.onEvent.stream,
        builder: (context, snapshot) {
          if (room.isUnread) room.setUnread(false);
          return _MessageView(room, _sendMessageWidget);
        },
      ),
    );
  }

}

class _MessageView extends StatelessWidget {

  final Room _room;
  final SendMessageWidget _sendMessageWidget;

  _MessageView(this._room, this._sendMessageWidget);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Matrix.of(context).client.getRoomEvents(_room.id, _room.prev_batch, Direction.b, limit: 200),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text(snapshot.error.toString());
        if (!snapshot.hasData) return CircularProgressIndicator();
        TimelineHistoryResponse historyResponse = snapshot.data as TimelineHistoryResponse;
        List<Widget> messageView = [];
        messageView.add(_sendMessageWidget);
        messageView.add(Divider());
        messageView.addAll(historyResponse.chunk.map((event) {
          if (event.type == "m.room.message") {
            return Message(event);
          } else if (event.type == "m.room.encrypted") {
            return ListTile(
              leading: Icon(Icons.warning_amber_outlined),
              title: Text("Die Nachricht ist verschlüsselt"),
              subtitle: Text("Leider kann AlpakaChat noch keine Nachrichten entschlüsseln"),
            );
          }
          return Container();
        }).toList());
        return ListView(
          children: messageView,
          reverse: true,
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
                onPressed: () async {
                  if(_controller.text != ""){
                    await _room.sendTextEvent(_controller.text);
                    _controller.clear();
                    Matrix.of(context).client.onEvent.add(EventUpdate(roomID: _room.id, content: {'body': _controller.text}));
                  }
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

class Message extends StatelessWidget {

  final MatrixEvent event;

  const Message(this.event);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15)
          ),
          gradient: LinearGradient(
              colors: [Colors.white, Colors.grey],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          ),
          boxShadow: [BoxShadow(
            blurRadius: 20,
            offset: Offset(10, 10),
            color: Colors.black,
          ),],
        ),
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(10),
        constraints: BoxConstraints(maxWidth: 330),
        width: MediaQuery.of(context).size.width / 2,
        child: ListTile(
          title: Text("${event.senderId}"),
          subtitle: Text("${event.content['body']}"),
        )
    );
  }

}