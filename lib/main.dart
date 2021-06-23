import 'package:alpaka_chat/views/appstate.dart';
import 'package:alpaka_chat/views/homeview.dart';
import 'package:alpaka_chat/views/login.dart';
import 'package:alpaka_chat/matrix.dart';
import 'package:alpaka_chat/views/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  Matrix matrix = new Matrix();
  runApp(MyApp(matrix));
}

class MyApp extends StatelessWidget {

  final Matrix _matrix;
  final AppStateManager manager = new AppStateManager();


  MyApp(this._matrix) {
    _matrix.connect().then((value) {
      manager.setLoggedIn(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppStateWidget(MatrixWidget(StreamBuilder(
        stream: manager.stream.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is AppState) {
              AppState appState = snapshot.data as AppState;
              print(appState.loggedIn ? "User is logged in!" : "User is not logged in!");
              return MatrixWidget(MaterialApp(
                title: 'Alpaka Chat',
                theme: ThemeData(
                  brightness: Brightness.light,
                  primarySwatch: Colors.green,
                ),
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                ),
                home: appState.loggedIn ? Homeview() : Welcome(),
              ), _matrix);
            }
          }
          return CircularProgressIndicator();
        }), _matrix), manager);
  }
}
