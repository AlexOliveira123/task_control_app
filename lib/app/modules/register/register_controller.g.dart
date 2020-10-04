// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $RegisterController = BindInject(
  (i) => RegisterController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterController on _RegisterControllerBase, Store {
  final _$userAtom = Atom(name: '_RegisterControllerBase.user');

  @override
  UserEntity get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserEntity value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$passwordObscureAtom =
      Atom(name: '_RegisterControllerBase.passwordObscure');

  @override
  bool get passwordObscure {
    _$passwordObscureAtom.reportRead();
    return super.passwordObscure;
  }

  @override
  set passwordObscure(bool value) {
    _$passwordObscureAtom.reportWrite(value, super.passwordObscure, () {
      super.passwordObscure = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_RegisterControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$addressAtom = Atom(name: '_RegisterControllerBase.address');

  @override
  AddressModel get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(AddressModel value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  final _$setUserAsyncAction = AsyncAction('_RegisterControllerBase.setUser');

  @override
  Future setUser(
      {dynamic email,
      dynamic password,
      dynamic token,
      dynamic name,
      dynamic birthday,
      dynamic cpf,
      dynamic address,
      dynamic number,
      dynamic zipcode}) {
    return _$setUserAsyncAction.run(() => super.setUser(
        email: email,
        password: password,
        token: token,
        name: name,
        birthday: birthday,
        cpf: cpf,
        address: address,
        number: number,
        zipcode: zipcode));
  }

  final _$searchAddressAsyncAction =
      AsyncAction('_RegisterControllerBase.searchAddress');

  @override
  Future searchAddress() {
    return _$searchAddressAsyncAction.run(() => super.searchAddress());
  }

  final _$_RegisterControllerBaseActionController =
      ActionController(name: '_RegisterControllerBase');

  @override
  dynamic setPasswordObscure() {
    final _$actionInfo = _$_RegisterControllerBaseActionController.startAction(
        name: '_RegisterControllerBase.setPasswordObscure');
    try {
      return super.setPasswordObscure();
    } finally {
      _$_RegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
passwordObscure: ${passwordObscure},
isLoading: ${isLoading},
address: ${address}
    ''';
  }
}
