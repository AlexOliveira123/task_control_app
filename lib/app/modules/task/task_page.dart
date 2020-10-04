import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task_control_app/app/modules/task/components/logout_button.dart';
import 'package:task_control_app/app/modules/task/components/task_item.dart';
import 'components/task_dialog.dart';
import 'task_controller.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends ModularState<TaskPage, TaskController> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        actions: [LogoutButton()],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Material(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                indicatorColor: Colors.grey[200],
                tabs: [
                  Tab(child: Text('Abertas')),
                  Tab(child: Text('Finalizadas')),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Observer(
                    builder: (_) {
                      if (controller.tasks == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var listOpenTasks = controller.tasks
                          .where((task) => task.status == "Open")
                          .toList();

                      if (listOpenTasks.length == 0) {
                        return Center(
                          child: Text(
                            'Não há tarefas abertas.',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 17,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: listOpenTasks.length,
                        itemBuilder: (_, idx) {
                          var task = listOpenTasks[idx];
                          return TaskItem(task: task);
                        },
                      );
                    },
                  ),
                  Observer(
                    builder: (_) {
                      if (controller.tasks == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var listFinishedTasks = controller.tasks
                          .where((task) => task.status == "Finished")
                          .toList();

                      if (listFinishedTasks.length == 0) {
                        return Center(
                          child: Text(
                            'Não há tarefas finalizadas.',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 17,
                            ),
                          ),
                        );
                      }

                      //If there, it will load
                      //the list
                      return ListView.builder(
                        itemCount: listFinishedTasks.length,
                        itemBuilder: (_, idx) {
                          var task = listFinishedTasks[idx];
                          return TaskItem(task: task);
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return TaskDialog(
                scaffoldKey: _scaffoldKey,
              );
            },
          );
        },
      ),
    );
  }
}
