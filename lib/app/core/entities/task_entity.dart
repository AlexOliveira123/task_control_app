import 'package:floor/floor.dart';

import 'package:task_control_app/app/core/entities/base_entity.dart';
import 'package:task_control_app/app/core/entities/user_entity.dart';

@Entity(tableName: 'tasks', foreignKeys: [
  ForeignKey(
    childColumns: ['user_id'],
    parentColumns: ['id'],
    entity: UserEntity,
  )
])
class TaskEntity extends BaseEntity {
  final String description;
  final String status;
  final String deliveryDate;
  final String conclusionDate;

  @ColumnInfo(name: 'user_id')
  final int userId;

  TaskEntity({
    this.deliveryDate,
    this.conclusionDate,
    this.userId,
    int id,
    String createdAt,
    String updatedAt,
    String deletedAt,
    this.description,
    this.status = 'Open',
  }) : super(id, createdAt, updatedAt, deletedAt);

  TaskEntity copyWith({
    String description,
    String status,
    String deliveryDate,
    String conclusionDate,
    int userId,
    int id,
  }) {
    return TaskEntity(
      description: description ?? this.description,
      status: status ?? this.status,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      conclusionDate: conclusionDate ?? this.conclusionDate,
      userId: userId ?? this.userId,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'TaskEntity(description: $description, status: $status, deliveryDate: $deliveryDate, conclusionDate: $conclusionDate, userId: $userId, id: $id)';
  }
}
