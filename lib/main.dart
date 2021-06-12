import 'package:alpaka_chat/views/login.dart';
import 'package:alpaka_chat/matrix.dart';
import 'package:flutter/material.dart';

void main() {
  Matrix matrix = new Matrix();
  matrix.showLoginPage().then((value) {
    runApp(MyApp(matrix, value));
  });
}

class MyApp extends StatelessWidget {

  final Matrix _matrix;
  final bool startLoggedIn;

  MyApp(this._matrix, this.startLoggedIn);

  @override
  Widget build(BuildContext context) {
    return MatrixWidget(MaterialApp(
      title: 'Alpaka Chat',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,

      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    ), _matrix);
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alpaka Chat"),
      ),
      body: Loginwidget(),
    );
  }

}
