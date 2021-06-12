import 'package:flutter/cupertino.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:famedlysdk/famedlysdk.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Matrix {

  Matrix() {
    SharedPreferences.getInstance().then((sp) async {
      if (sp.containsKey("homeserver")) {
        await client.checkHomeserver(sp.getString("homeserver"));
        client.init(
          newDeviceID: sp.getString("deviceId"),
          newUserID: sp.getString("userId"),
          newToken: sp.getString("token"),
          newHomeserver: Uri.parse(sp.getString("homeserver")!),
          newDeviceName: ''
        );
      }
    });
  }

  final client = Client("AlpakaChat");

  static Matrix of(BuildContext context) {
    return (context.getElementForInheritedWidgetOfExactType<MatrixWidget>()!.widget as MatrixWidget).matrix;
  }

  Future login(String homeserver, String username, String password) async {
    WellKnownInformation homeserverData = await client.checkHomeserver(homeserver);
    LoginResponse login = await client.login(user: username, password: password, deviceId: "lol");
    SharedPreferences.getInstance().then((sp) {
      sp.setString("homeserver", homeserver);
      sp.setString("token", login.accessToken);
      sp.setString("userId", login.userId);
      sp.setString("deviceId", login.deviceId);
    });
  }

  Future<bool> showLoginPage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return !preferences.containsKey("homeserver");
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