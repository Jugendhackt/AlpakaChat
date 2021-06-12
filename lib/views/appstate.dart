import 'dart:async';

import 'package:flutter/cupertino.dart';

class AppState {
  final bool loggedIn;

  AppState(this.loggedIn);
}

class AppStateManager {
  // ignore: close_sinks
  final StreamController stream = new StreamController();

  void setLoggedIn(bool loggedIn) {
    stream.add(AppState(loggedIn));
  }

  static AppStateManager of(BuildContext context) {
    return (context.getElementForInheritedWidgetOfExactType<AppStateWidget>()!.widget as AppStateWidget).manager;
  }

}

class AppStateWidget extends InheritedWidget {
  final AppStateManager manager;

  AppStateWidget(child, this.manager) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

}