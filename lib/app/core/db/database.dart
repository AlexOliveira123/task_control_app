import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
import 'package:task_control_app/app/core/entities/task_entity.dart';
import 'package:task_control_app/app/core/entities/user_entity.dart';
import 'package:task_control_app/app/core/daos/user_dao.dart';
import 'package:task_control_app/app/core/daos/task_dao.dart';

part 'database.g.dart';

@Database(version: 1, entities: [
  TaskEntity,
  UserEntity,
])
abstract class AppDatabase extends FloorDatabase {
  TaskDAO get taskDAO;
  UserDAO get userDAO;
}
