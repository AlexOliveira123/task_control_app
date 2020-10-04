import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:task_control_app/app/core/db/database.dart';
import 'package:task_control_app/app/core/enums/auth_status.dart';
import 'package:task_control_app/app/core/local_storage/local_storage.dart';
import 'package:task_control_app/app/core/daos/user_dao.dart';
import 'package:uuid/uuid.dart';
part 'auth_store.g.dart';

@Injectable()
class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final AppDatabase db;
  UserDAO get _userDAO => db.userDAO;

  _AuthStoreBase(this.db) {
    getUser();
  }

  @observable
  AuthStatus authStatus = AuthStatus.Loading;

  @action
  getUser() async {
    try {
      var token = await LocalStorage.getValue('token');
      print('token: $token');
      authStatus = token.isEmpty || token == null
          ? AuthStatus.Disconnected
          : AuthStatus.Logged;
    } catch (e) {
      print('Auth - getUser: $e');
    }
  }

  @action
  logIn(String email, String password) async {
    try {
      var user = await _userDAO.logIn(email, password);

      if (user != null) {
        var token = Uuid().v4();
        user = user.copyWith(token: token);
        await _userDAO.updateItem(user);
        await LocalStorage.setValue('token', token);
        await LocalStorage.setValue('email', email);
        await LocalStorage.setValue<int>('userId', user?.id);
      }

      return user;
    } catch (e) {
      print('Auth - logIn: $e');
      return null;
    }
  }

  logOut() async {
    var instance = await LocalStorage.setInstance();
    instance.clear();
  }
}
