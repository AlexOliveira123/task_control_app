import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:task_control_app/app/core/stores/auth/auth_store.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  AuthStore auth = Modular.get();

  @observable
  bool isLoading = false;

  @observable
  String email;

  @observable
  String password;

  @observable
  bool obscurePassword = true;

  @action
  onChangedEmail(value) => email = value;

  @action
  onChangedPassword(value) => password = value;

  @action
  setObscurePassword() => obscurePassword = !obscurePassword;

  @action
  logIn() async {
    isLoading = true;
    await Future.delayed(Duration(milliseconds: 600));
    try {
      var user = await auth.logIn(email.toLowerCase(), password.toLowerCase());

      return user;
    } catch (e) {
      print('Login - $e');
      return null;
    }
  }
}
