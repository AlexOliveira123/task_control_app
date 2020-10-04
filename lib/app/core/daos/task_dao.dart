import 'package:task_control_app/app/core/entities/task_entity.dart';

import 'package:floor/floor.dart';
import 'package:task_control_app/app/core/interfaces/dao_interface.dart';

@dao
abstract class TaskDAO extends IDAO<TaskEntity> {
  @Query('SELECT * FROM tasks where id = :id and user_id = :userId')
  Future<TaskEntity> getTaskById(int id, int userId);

  @Query('SELECT * FROM tasks where user_id = :userId')
  Future<List<TaskEntity>> getAllTasks(int userId);
}
