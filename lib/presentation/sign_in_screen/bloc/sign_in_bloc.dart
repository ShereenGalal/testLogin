import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:testlogin/presentation/sign_in_screen/models/sign_in_model.dart';
import 'package:testlogin/data/models/loginAccount/post_login_account_resp.dart';
import 'package:testlogin/data/models/loginAccount/post_login_account_req.dart';
import 'dart:async';
import 'package:testlogin/data/repository/repository.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

/// A bloc that manages the state of a SignIn according to the event that is dispatched to it.
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(SignInState initialState) : super(initialState) {
    on<SignInInitialEvent>(_onInitialize);
    on<ChangePasswordVisibilityEvent>(_changePasswordVisibility);
    on<ChangeCheckBoxEvent>(_changeCheckBox);
    on<CreateLoginEvent>(_callLoginAccount);
  }

  final _repository = Repository();

  var postLoginAccountResp = PostLoginAccountResp();

  _changePasswordVisibility(
    ChangePasswordVisibilityEvent event,
    Emitter<SignInState> emit,
  ) {
    emit(state.copyWith(isShowPassword: event.value));
  }

  _changeCheckBox(
    ChangeCheckBoxEvent event,
    Emitter<SignInState> emit,
  ) {
    emit(state.copyWith(rememberPassword: event.value));
  }

  _onInitialize(
    SignInInitialEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
        isShowPassword: true,
        rememberPassword: false));
  }

  /// Calls [https://seere.somee.com/api/Account/login] with the provided event and emits the state.
  ///
  /// The [CreateLoginEvent] parameter is used for handling event data
  /// The [emit] parameter is used for emitting the state
  ///
  /// Throws an error if an error occurs during the API call process.
  FutureOr<void> _callLoginAccount(
    CreateLoginEvent event,
    Emitter<SignInState> emit,
  ) async {
    var postLoginAccountReq = PostLoginAccountReq(
      email: state.emailController?.text ?? '',
      password: state.passwordController?.text ?? '',
      rememberMe: state.rememberPassword,
    );
    await _repository.loginAccount(
      headers: {},
      requestData: postLoginAccountReq.toJson(),
    ).then((value) async {
      postLoginAccountResp = value;
      _onLoginAccountSuccess(value, emit);
      event.onCreateLoginEventSuccess?.call();
    }).onError((error, stackTrace) {
      //implement error call
      _onLoginAccountError();
      event.onCreateLoginEventError?.call();
    });
  }

  void _onLoginAccountSuccess(
    PostLoginAccountResp resp,
    Emitter<SignInState> emit,
  ) {
    PrefUtils().setUserId(resp.token ?? '');
    PrefUtils().setUsernum(resp.expiration ?? '');
    emit(
      state.copyWith(
        signInModelObj: state.signInModelObj?.copyWith(),
      ),
    );
  }

  void _onLoginAccountError() {
    //implement error method body...
  }
}
