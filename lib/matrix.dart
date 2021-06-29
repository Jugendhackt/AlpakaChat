import 'package:flutter/cupertino.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:matrix/matrix.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Matrix {

  final client = Client("AlpakaChat");

  static Matrix of(BuildContext context) {
    return (context.getElementForInheritedWidgetOfExactType<MatrixWidget>()!.widget as MatrixWidget).matrix;
  }

  Future register(String homeserver, String username, String password) async {
    await client.checkHomeserver(homeserver);
    processLoginResponse(homeserver, await client.register(username: username, password: password));
  }

  Future<bool> login(String homeserver, String username, String password) async {
    WellKnownInformation homeserverData = await client.checkHomeserver(homeserver);
    LoginResponse login = await client.login(user: username, password: password, deviceId: "Alpaka Chat");
    processLoginResponse(homeserver, login);
    return login != null;
  }

  void processLoginResponse(String homeserver, LoginResponse login) {
    SharedPreferences.getInstance().then((sp) {
      sp.setString("homeserver", homeserver);
      sp.setString("token", login.accessToken);
      sp.setString("userId", login.userId);
      sp.setString("deviceId", login.deviceId);
    });
  }

  Future logout() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    await client.logout();
  }

  Future<bool> connect() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.containsKey("homeserver")) {
      await client.checkHomeserver(sp.getString("homeserver"));
      client.init(
          newDeviceID: sp.getString("deviceId"),
          newUserID: sp.getString("userId"),
          newToken: sp.getString("token"),
          newHomeserver: Uri.parse(sp.getString("homeserver")!),
          newDeviceName: ''
      );
      return true;
    } else {
      return false;
    }
  }

}

class MatrixWidget extends InheritedWidget {
  final Matrix matrix;

  MatrixWidget(Widget child, Matrix matrix) :
        matrix = matrix,
        super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

}