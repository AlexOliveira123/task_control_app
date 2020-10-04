import 'package:flutter/material.dart';
import 'package:task_control_app/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/core/db/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(ModularApp(module: AppModule(db)));
}
