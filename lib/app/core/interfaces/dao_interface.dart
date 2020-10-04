import 'package:floor/floor.dart';
import 'package:task_control_app/app/core/entities/base_entity.dart';

abstract class IDAO<ItemEntity extends BaseEntity> {
  @insert
  Future<int> insertItem(ItemEntity entity);

  @update
  Future<int> updateItem(ItemEntity entity);

  @delete
  Future<int> deleteItem(ItemEntity entity);
}
