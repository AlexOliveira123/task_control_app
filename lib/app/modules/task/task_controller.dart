import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_control_app/app/core/db/database.dart';
import 'package:task_control_app/app/core/entities/task_entity.dart';
import 'package:task_control_app/app/core/local_storage/local_storage.dart';
import 'package:task_control_app/app/core/daos/task_dao.dart';

part 'task_controller.g.dart';

@Injectable()
class TaskController = _TaskControllerBase with _$TaskController;

abstract class _TaskControllerBase with Store {
  final AppDatabase database;
  TaskDAO get _taskDAO => database.taskDAO;

  @observable
  List<TaskEntity> tasks;

  @observable
  TaskEntity task = TaskEntity();

  @observable
  int userId;
  _TaskControllerBase(this.database) {
    getAllTasks();
  }

  @action
  getAllTasks() async {
    try {
      userId = await LocalStorage.getValue<int>('userId');
      tasks = await _taskDAO.getAllTasks(userId);
      print('tasks: $tasks');
    } catch (e) {
      print('Task - getAllTasks: $e');
    }
  }

  @action
  setTask({description, deliveryDate, conclusionDate}) {
    task = task.copyWith(
      description: description,
      deliveryDate: deliveryDate,
      conclusionDate: conclusionDate,
    );
  }

  @action
  createTask() async {
    try {
      task = task.copyWith(userId: userId);
      int taskId = await _taskDAO.insertItem(task);
      task = task.copyWith(id: taskId);
      tasks = List.from(tasks..add(task));
    } on DatabaseException catch (e) {
      print('Task - InsertTask: $e');
    }
  }

  @action
  updateTask() async {
    try {
      await _taskDAO.updateItem(task);
      var element = tasks.where((element) => element.id == task.id);
      var idx = tasks.indexOf(element.first);
      tasks[idx] = task;
      tasks = List.from(tasks);
    } on DatabaseException catch (e) {
      print('Task - UpdateTask: $e');
    }
  }

  @action
  deleteTask(TaskEntity taskEntity) async {
    try {
      await _taskDAO.deleteItem(taskEntity);
      tasks = List.from(tasks..remove(taskEntity));
    } on DatabaseException catch (e) {
      print('Task - DeleteTask: $e');
    }
  }
}
