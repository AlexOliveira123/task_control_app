import 'package:floor/floor.dart';

class BaseEntity {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  BaseEntity(
    this.id,
    this.updatedAt,
    this.deletedAt,
    String createdAt,
  ) : this.createdAt = createdAt ?? DateTime.now().toUtc().toString();
}
