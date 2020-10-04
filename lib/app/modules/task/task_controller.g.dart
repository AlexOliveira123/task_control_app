// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $TaskController = BindInject(
  (i) => TaskController(i<AppDatabase>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TaskController on _TaskControllerBase, Store {
  final _$tasksAtom = Atom(name: '_TaskControllerBase.tasks');

  @override
  List<TaskEntity> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(List<TaskEntity> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  final _$taskAtom = Atom(name: '_TaskControllerBase.task');

  @override
  TaskEntity get task {
    _$taskAtom.reportRead();
    return super.task;
  }

  @override
  set task(TaskEntity value) {
    _$taskAtom.reportWrite(value, super.task, () {
      super.task = value;
    });
  }

  final _$userIdAtom = Atom(name: '_TaskControllerBase.userId');

  @override
  int get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(int value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  final _$getAllTasksAsyncAction =
      AsyncAction('_TaskControllerBase.getAllTasks');

  @override
  Future getAllTasks() {
    return _$getAllTasksAsyncAction.run(() => super.getAllTasks());
  }

  final _$updateTaskAsyncAction = AsyncAction('_TaskControllerBase.updateTask');

  @override
  Future updateTask() {
    return _$updateTaskAsyncAction.run(() => super.updateTask());
  }

  final _$deleteTaskAsyncAction = AsyncAction('_TaskControllerBase.deleteTask');

  @override
  Future deleteTask(TaskEntity taskEntity) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(taskEntity));
  }

  final _$_TaskControllerBaseActionController =
      ActionController(name: '_TaskControllerBase');

  @override
  dynamic setTask(
      {dynamic description, dynamic deliveryDate, dynamic conclusionDate}) {
    final _$actionInfo = _$_TaskControllerBaseActionController.startAction(
        name: '_TaskControllerBase.setTask');
    try {
      return super.setTask(
          description: description,
          deliveryDate: deliveryDate,
          conclusionDate: conclusionDate);
    } finally {
      _$_TaskControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tasks: ${tasks},
task: ${task},
userId: ${userId}
    ''';
  }
}
