import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task_control_app/app/core/stores/auth/auth_store.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.logout),
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text('Atenção'),
              content: Text('Deseja realmente sair do aplicativo?'),
              actions: [
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Modular.get<AuthStore>().logOut().then((_) => Modular.to
                        .pushNamedAndRemoveUntil('/login', (r) => false));
                  },
                  child: Text('Sim'),
                ),
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Não',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
