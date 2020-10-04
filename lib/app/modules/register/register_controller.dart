import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task_control_app/app/core/db/database.dart';
import 'package:task_control_app/app/core/entities/user_entity.dart';
import 'package:task_control_app/app/core/models/address_model.dart';
import 'package:task_control_app/app/core/services/address_service.dart';

import '../../core/daos/user_dao.dart';

part 'register_controller.g.dart';

@Injectable()
class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  final AppDatabase db = Modular.get();
  final AddressService addressService = Modular.get();
  UserDAO get _userDAO => db.userDAO;

  @observable
  UserEntity user = UserEntity();

  @observable
  bool passwordObscure = true;

  @observable
  bool isLoading = false;

  @observable
  AddressModel address = AddressModel();

  @action
  setUser(
      {email,
      password,
      token,
      name,
      birthday,
      cpf,
      address,
      number,
      zipcode}) async {
    user = user.copyWith(
        email: email,
        password: password,
        token: token,
        name: name,
        birthday: birthday,
        cpf: cpf,
        address: address,
        number: number,
        zipcode: zipcode);
  }

  @action
  searchAddress() async {
    address = null;
    address = await addressService.getAddress(user.zipcode);

    user = user.copyWith(address: address?.addressInfo() ?? "");

    return address;
  }

  createUser() async {
    isLoading = true;

    try {
      var getUser = await _userDAO.getUser(user.email.toLowerCase());

      if (getUser?.email != null) {
        return {
          'response': false,
          'msg': 'Este e-mail já está sendo utilizado no aplicativo.'
        };
      }

      var userId = await _userDAO.insertItem(user);

      print('User: ${user.toString()}');
      print('UserId: $userId');

      return {'response': true, 'msg': 'Usuário cadastrado com sucesso!'};
    } catch (e) {
      print('$e');
      return {
        'response': false,
        'msg':
            'Ocorreu um erro ao finalizar o cadastro. Contate o administrador!'
      };
    }
  }

  @action
  setPasswordObscure() => passwordObscure = !passwordObscure;
}
