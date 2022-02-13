// ignore_for_file: unused_field, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage _box = GetStorage();
  final _key = 'isDarkTheme';
  saveThemetoBox(bool isDarkTheme) => _box.write(_key, isDarkTheme);

  bool laodThemeFromBox() => _box.read<bool>(_key) ?? false;

  ThemeMode get theme => laodThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  void isSwiteched() {
    Get.changeThemeMode(laodThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    //**To Save new Value Dark Or light When open the App */
    saveThemetoBox(!laodThemeFromBox());
  }
}
