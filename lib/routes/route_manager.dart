import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:soccer_school/views/pages/classes/class_home.dart';

import '../models/base/routes.dart';

class RouteManager {
  RouteManager._internal();

  static final RouteManager _instance = RouteManager._internal();

  factory RouteManager() => _instance;

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final uri = Uri.parse(settings.name!);

    if (settings.name!.contains(Routes.classes().routeName)) {
      return _goTo(ClassesHome(), Routes.classes(), args: args);
    }
    return _goTo(ClassesHome(), Routes.classes(), args: args);
  }

  static GetPageRoute _goTo(Widget page, Routes route, {Object? args, int? index}) {
    
    // if (index != null) {
    //   control.activeIndex.value = index;
    // }
    // control.setMenuTitle(route.title);
    return GetPageRoute(
      page: () => page,
      routeName: route.routeName,
      settings: RouteSettings(
        name: route.routeName,
        arguments: args,
      ),
      title: route.title,
      transition: Transition.noTransition
    );
  }
}