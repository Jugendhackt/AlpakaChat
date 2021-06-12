// ignore: import_of_legacy_library_into_null_safe
import 'package:famedlysdk/famedlysdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          List<Widget> messageView = events.map((event) {
            if (event.type == "m.room.message") {
              return ListTile(
                title: Text("${event.senderId}"),
                subtitle: Text("${event.content['body']}"),
              );
            }
            return Container();
          }).toList();
          messageView.add(Divider());
          messageView.add(SendMessageWidget(room));
          return ListView(
            children: messageView,
          );
        },
      ),
    );
  }

}

class SendMessageWidget extends StatelessWidget {

  final TextEditingController _controller = new TextEditingController();
  final Room _room;

  SendMessageWidget(this._room);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextField(
            controller: _controller,
          ),
          FlatButton(
            onPressed: () {
            if(_controller.text != ""){
            _room.sendTextEvent(_controller.text);
            _controller.clear();}
          },
            child: Icon(Icons.send),)
        ],
      ),
    );
  }

}