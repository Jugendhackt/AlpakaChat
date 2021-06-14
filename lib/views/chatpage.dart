// ignore: import_of_legacy_library_into_null_safe
import 'package:famedlysdk/famedlysdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

import '../matrix.dart';

class ChatPage extends StatelessWidget {
  
  final Room room;
  final SendMessageWidget _sendMessageWidget;
  final List<MatrixEvent> _messages;

  ChatPage(this.room) :
        _sendMessageWidget = SendMessageWidget(room),
        _messages = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Matrix.of(context).client.getRoomEvents(room.id, room.prev_batch, Direction.b, limit: 200),
        builder: (context, messagesSnap) {
          if (!messagesSnap.hasData)  return CircularProgressIndicator();
          if (_messages.isEmpty) _messages.addAll((messagesSnap.data as TimelineHistoryResponse).chunk);
          return StreamBuilder(
            stream: Matrix.of(context).client.onEvent.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                EventUpdate update = snapshot.data as EventUpdate;
                if (update.content != null &&
                    update.content.containsKey('type') &&
                    update.content['type'] == "m.room.message" &&
                    update.content['event_id'].startsWith("\$")) {
                  MatrixEvent newEvent = MatrixEvent.fromJson(update.content);
                  _messages.firstWhere((element) => element.eventId == newEvent.eventId, orElse: () {_messages.insert(0, newEvent); return MatrixEvent();});
                }
              }
              if (room.isUnread) room.setUnread(false);
              return _MessageView(_messages, _sendMessageWidget);
            },
          );
        },
      ),
    );
  }

}

class _MessageView extends StatelessWidget {

  final List<MatrixEvent> _messages;
  final SendMessageWidget _sendMessageWidget;

  _MessageView(this._messages, this._sendMessageWidget);

  @override
  Widget build(BuildContext context) {
    List<Widget> messageView = [];
    messageView.add(_sendMessageWidget);
    messageView.add(Divider());
    messageView.addAll(_messages.map((event) {
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
    bool sendbyself = false;
    if(Matrix.of(context).client.userID == event.senderId) sendbyself = true;
    return Bubble(
      color:  sendbyself ? Colors.greenAccent : Colors.blueAccent,
      elevation: 0,
        alignment: sendbyself ? Alignment.topRight : Alignment.topLeft,
        margin: BubbleEdges.only(bottom: 15),
      nip: sendbyself ? BubbleNip.rightBottom : BubbleNip.leftBottom,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${event.senderId.localpart}",
              style: TextStyle(
                color: Colors.black54,
              ),),
            Text(
                "${event.content['body']}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
            ),
          ],
        ),
      )
    );
/*Container(
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
            color: Colors.white54,
          ),],
        ),
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(10),
        constraints: BoxConstraints(maxWidth: 330),
        width: MediaQuery.of(context).size.width / 2,
        child: ListTile(
          title: Text(
            "${event.senderId}",
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            "${event.content['body']}",
            style: TextStyle(color: Colors.black),
          ),
        )
    );*/
  }

}