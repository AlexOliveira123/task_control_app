// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TaskDAO _taskDAOInstance;

  UserDAO _userDAOInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tasks` (`description` TEXT, `status` TEXT, `deliveryDate` TEXT, `conclusionDate` TEXT, `user_id` INTEGER, `id` INTEGER PRIMARY KEY AUTOINCREMENT, `createdAt` TEXT, `updatedAt` TEXT, `deletedAt` TEXT, FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`email` TEXT, `password` TEXT, `token` TEXT, `name` TEXT, `birthday` TEXT, `cpf` TEXT, `zipcode` TEXT, `address` TEXT, `number` INTEGER, `id` INTEGER PRIMARY KEY AUTOINCREMENT, `createdAt` TEXT, `updatedAt` TEXT, `deletedAt` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TaskDAO get taskDAO {
    return _taskDAOInstance ??= _$TaskDAO(database, changeListener);
  }

  @override
  UserDAO get userDAO {
    return _userDAOInstance ??= _$UserDAO(database, changeListener);
  }
}

class _$TaskDAO extends TaskDAO {
  _$TaskDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _taskEntityInsertionAdapter = InsertionAdapter(
            database,
            'tasks',
            (TaskEntity item) => <String, dynamic>{
                  'description': item.description,
                  'status': item.status,
                  'deliveryDate': item.deliveryDate,
                  'conclusionDate': item.conclusionDate,
                  'user_id': item.userId,
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'deletedAt': item.deletedAt
                }),
        _taskEntityUpdateAdapter = UpdateAdapter(
            database,
            'tasks',
            ['id'],
            (TaskEntity item) => <String, dynamic>{
                  'description': item.description,
                  'status': item.status,
                  'deliveryDate': item.deliveryDate,
                  'conclusionDate': item.conclusionDate,
                  'user_id': item.userId,
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'deletedAt': item.deletedAt
                }),
        _taskEntityDeletionAdapter = DeletionAdapter(
            database,
            'tasks',
            ['id'],
            (TaskEntity item) => <String, dynamic>{
                  'description': item.description,
                  'status': item.status,
                  'deliveryDate': item.deliveryDate,
                  'conclusionDate': item.conclusionDate,
                  'user_id': item.userId,
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'deletedAt': item.deletedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _tasksMapper = (Map<String, dynamic> row) => TaskEntity(
      deliveryDate: row['deliveryDate'] as String,
      conclusionDate: row['conclusionDate'] as String,
      userId: row['user_id'] as int,
      id: row['id'] as int,
      createdAt: row['createdAt'] as String,
      updatedAt: row['updatedAt'] as String,
      deletedAt: row['deletedAt'] as String,
      description: row['description'] as String,
      status: row['status'] as String);

  final InsertionAdapter<TaskEntity> _taskEntityInsertionAdapter;

  final UpdateAdapter<TaskEntity> _taskEntityUpdateAdapter;

  final DeletionAdapter<TaskEntity> _taskEntityDeletionAdapter;

  @override
  Future<TaskEntity> getTaskById(int id, int userId) async {
    return _queryAdapter.query(
        'SELECT * FROM tasks where id = ? and user_id = ?',
        arguments: <dynamic>[id, userId],
        mapper: _tasksMapper);
  }

  @override
  Future<List<TaskEntity>> getAllTasks(int userId) async {
    return _queryAdapter.queryList('SELECT * FROM tasks where user_id = ?',
        arguments: <dynamic>[userId], mapper: _tasksMapper);
  }

  @override
  Future<int> insertItem(TaskEntity entity) {
    return _taskEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(TaskEntity entity) {
    return _taskEntityUpdateAdapter.updateAndReturnChangedRows(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteItem(TaskEntity entity) {
    return _taskEntityDeletionAdapter.deleteAndReturnChangedRows(entity);
  }
}

class _$UserDAO extends UserDAO {
  _$UserDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userEntityInsertionAdapter = InsertionAdapter(
            database,
            'users',
            (UserEntity item) => <String, dynamic>{
                  'email': item.email,
                  'password': item.password,
                  'token': item.token,
                  'name': item.name,
                  'birthday': item.birthday,
                  'cpf': item.cpf,
                  'zipcode': item.zipcode,
                  'address': item.address,
                  'number': item.number,
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'deletedAt': item.deletedAt
                }),
        _userEntityUpdateAdapter = UpdateAdapter(
            database,
            'users',
            ['id'],
            (UserEntity item) => <String, dynamic>{
                  'email': item.email,
                  'password': item.password,
                  'token': item.token,
                  'name': item.name,
                  'birthday': item.birthday,
                  'cpf': item.cpf,
                  'zipcode': item.zipcode,
                  'address': item.address,
                  'number': item.number,
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'deletedAt': item.deletedAt
                }),
        _userEntityDeletionAdapter = DeletionAdapter(
            database,
            'users',
            ['id'],
            (UserEntity item) => <String, dynamic>{
                  'email': item.email,
                  'password': item.password,
                  'token': item.token,
                  'name': item.name,
                  'birthday': item.birthday,
                  'cpf': item.cpf,
                  'zipcode': item.zipcode,
                  'address': item.address,
                  'number': item.number,
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'deletedAt': item.deletedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _usersMapper = (Map<String, dynamic> row) => UserEntity(
      email: row['email'] as String,
      password: row['password'] as String,
      token: row['token'] as String,
      name: row['name'] as String,
      birthday: row['birthday'] as String,
      cpf: row['cpf'] as String,
      address: row['address'] as String,
      number: row['number'] as int,
      zipcode: row['zipcode'] as String,
      id: row['id'] as int,
      createdAt: row['createdAt'] as String,
      updatedAt: row['updatedAt'] as String,
      deletedAt: row['deletedAt'] as String);

  final InsertionAdapter<UserEntity> _userEntityInsertionAdapter;

  final UpdateAdapter<UserEntity> _userEntityUpdateAdapter;

  final DeletionAdapter<UserEntity> _userEntityDeletionAdapter;

  @override
  Future<UserEntity> getUser(String email) async {
    return _queryAdapter.query('SELECT * FROM users where email = ?',
        arguments: <dynamic>[email], mapper: _usersMapper);
  }

  @override
  Future<UserEntity> logIn(String email, String password) async {
    return _queryAdapter.query(
        'SELECT * FROM users where email = ? and password = ?',
        arguments: <dynamic>[email, password],
        mapper: _usersMapper);
  }

  @override
  Future<int> insertItem(UserEntity entity) {
    return _userEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(UserEntity entity) {
    return _userEntityUpdateAdapter.updateAndReturnChangedRows(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteItem(UserEntity entity) {
    return _userEntityDeletionAdapter.deleteAndReturnChangedRows(entity);
  }
}
