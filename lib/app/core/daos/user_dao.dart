import 'package:floor/floor.dart';
import 'package:task_control_app/app/core/entities/user_entity.dart';
import 'package:task_control_app/app/core/interfaces/dao_interface.dart';

@dao
abstract class UserDAO extends IDAO<UserEntity> {
  @Query('SELECT * FROM users where email = :email')
  Future<UserEntity> getUser(String email);

  @Query('SELECT * FROM users where email = :email and password = :password')
  Future<UserEntity> logIn(String email, String password);
}
