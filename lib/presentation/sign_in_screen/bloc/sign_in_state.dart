// ignore_for_file: must_be_immutable

part of 'sign_in_bloc.dart';

/// Represents the state of SignIn in the application.
class SignInState extends Equatable {
  SignInState({
    this.emailController,
    this.passwordController,
    this.isShowPassword = true,
    this.rememberPassword = false,
    this.signInModelObj,
  });

  TextEditingController? emailController;

  TextEditingController? passwordController;

  SignInModel? signInModelObj;

  bool isShowPassword;

  bool rememberPassword;

  @override
  List<Object?> get props => [
        emailController,
        passwordController,
        isShowPassword,
        rememberPassword,
        signInModelObj,
      ];

  SignInState copyWith({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    bool? isShowPassword,
    bool? rememberPassword,
    SignInModel? signInModelObj,
  }) {
    return SignInState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      rememberPassword: rememberPassword ?? this.rememberPassword,
      signInModelObj: signInModelObj ?? this.signInModelObj,
    );
  }
}
