// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $AuthStore = BindInject(
  (i) => AuthStore(i<AppDatabase>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStoreBase, Store {
  final _$authStatusAtom = Atom(name: '_AuthStoreBase.authStatus');

  @override
  AuthStatus get authStatus {
    _$authStatusAtom.reportRead();
    return super.authStatus;
  }

  @override
  set authStatus(AuthStatus value) {
    _$authStatusAtom.reportWrite(value, super.authStatus, () {
      super.authStatus = value;
    });
  }

  final _$getUserAsyncAction = AsyncAction('_AuthStoreBase.getUser');

  @override
  Future getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  final _$logInAsyncAction = AsyncAction('_AuthStoreBase.logIn');

  @override
  Future logIn(String email, String password) {
    return _$logInAsyncAction.run(() => super.logIn(email, password));
  }

  @override
  String toString() {
    return '''
authStatus: ${authStatus}
    ''';
  }
}
