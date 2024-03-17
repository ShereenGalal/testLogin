import 'package:testlogin/core/utils/validation_functions.dart';
import 'package:testlogin/widgets/custom_text_form_field.dart';
import 'package:testlogin/widgets/custom_checkbox_button.dart';
import 'package:testlogin/widgets/custom_elevated_button.dart';
import 'models/sign_in_model.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:flutter/material.dart';
import 'package:testlogin/core/app_export.dart';
import 'bloc/sign_in_bloc.dart';

// ignore_for_file: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<SignInBloc>(
        create: (context) =>
            SignInBloc(SignInState(signInModelObj: SignInModel()))
              ..add(SignInInitialEvent()),
        child: SignInScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        key: _formKey,
                        child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(vertical: 50.v),
                            child: Column(children: [
                              _buildThree(context),
                              SizedBox(height: 6.v),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 23.h),
                                      child: Text("lbl_email".tr,
                                          style:
                                              theme.textTheme.headlineSmall))),
                              SizedBox(height: 5.v),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 23.h, right: 24.h),
                                  child: BlocSelector<SignInBloc, SignInState,
                                          TextEditingController?>(
                                      selector: (state) =>
                                          state.emailController,
                                      builder: (context, emailController) {
                                        return CustomTextFormField(
                                            controller: emailController,
                                            hintText:
                                                "msg_williams_email_com".tr,
                                            textInputType:
                                                TextInputType.emailAddress,
                                            prefix: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    16.h, 26.v, 11.h, 26.v),
                                                child: CustomImageView(
                                                    imagePath:
                                                        ImageConstant.imgLock,
                                                    height: 18.adaptSize,
                                                    width: 18.adaptSize)),
                                            prefixConstraints:
                                                BoxConstraints(maxHeight: 70.v),
                                            validator: (value) {
                                              if (value == null ||
                                                  (!isValidEmail(value,
                                                      isRequired: true))) {
                                                return "err_msg_please_enter_valid_email"
                                                    .tr;
                                              }
                                              return null;
                                            });
                                      })),
                              SizedBox(height: 3.v),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 23.h),
                                      child: Text("lbl_password".tr,
                                          style:
                                              theme.textTheme.headlineSmall))),
                              SizedBox(height: 5.v),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 23.h, right: 24.h),
                                  child: BlocBuilder<SignInBloc, SignInState>(
                                      builder: (context, state) {
                                    return CustomTextFormField(
                                        controller: state.passwordController,
                                        textInputAction: TextInputAction.done,
                                        prefix: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                16.h, 26.v, 30.h, 26.v),
                                            child: CustomImageView(
                                                imagePath:
                                                    ImageConstant.imgLock1,
                                                height: 18.adaptSize,
                                                width: 18.adaptSize)),
                                        prefixConstraints:
                                            BoxConstraints(maxHeight: 70.v),
                                        suffix: InkWell(
                                            onTap: () {
                                              context.read<SignInBloc>().add(
                                                  ChangePasswordVisibilityEvent(
                                                      value: !state
                                                          .isShowPassword));
                                            },
                                            child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    30.h, 23.v, 20.h, 23.v),
                                                child: CustomImageView(
                                                    imagePath: ImageConstant
                                                        .imgMdihide,
                                                    height: 24.adaptSize,
                                                    width: 24.adaptSize))),
                                        suffixConstraints:
                                            BoxConstraints(maxHeight: 70.v),
                                        obscureText: state.isShowPassword);
                                  })),
                              SizedBox(height: 16.v),
                              _buildSix(context),
                              SizedBox(height: 23.v),
                              Divider(color: appTheme.gray200),
                              SizedBox(height: 33.v),
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "msg_don_t_have_an_account2".tr,
                                        style: CustomTextStyles
                                            .titleSmallff59606e),
                                    TextSpan(
                                        text: "lbl_register_now".tr,
                                        style:
                                            CustomTextStyles.titleSmallff326bdf)
                                  ]),
                                  textAlign: TextAlign.left),
                              SizedBox(height: 31.v),
                              CustomElevatedButton(
                                  text: "lbl_sign_in".tr,
                                  margin:
                                      EdgeInsets.only(left: 23.h, right: 24.h),
                                  onPressed: () {
                                    signIn(context);
                                  }),
                              SizedBox(height: 5.v)
                            ])))))));
  }

  /// Section Widget
  Widget _buildThree(BuildContext context) {
    return SizedBox(
        height: 353.v,
        width: 358.h,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: EdgeInsets.only(left: 4.h, top: 8.v),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 94.v),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: fs.Svg(ImageConstant.imgGroup1),
                          fit: BoxFit.cover)),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 92.v),
                        CustomImageView(
                            imagePath: ImageConstant.imgTelevision,
                            height: 34.v,
                            width: 63.h)
                      ]))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 25.v),
                  child: SizedBox(width: 346.h, child: Divider()))),
          CustomImageView(
              imagePath: ImageConstant.imgFreepikScreenInject76,
              height: 328.v,
              width: 155.h,
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 92.h)),
          CustomImageView(
              imagePath: ImageConstant.imgFreepikPlantInject76,
              height: 185.v,
              width: 106.h,
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.only(bottom: 25.v)),
          CustomImageView(
              imagePath: ImageConstant.imgFreepikCharacterInject76,
              height: 218.v,
              width: 138.h,
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(right: 16.h))
        ]));
  }

  /// Section Widget
  Widget _buildSix(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          BlocSelector<SignInBloc, SignInState, bool?>(
              selector: (state) => state.rememberPassword,
              builder: (context, rememberPassword) {
                return CustomCheckboxButton(
                    text: "msg_remember_password".tr,
                    value: rememberPassword,
                    padding: EdgeInsets.symmetric(vertical: 1.v),
                    onChange: (value) {
                      context
                          .read<SignInBloc>()
                          .add(ChangeCheckBoxEvent(value: value));
                    });
              }),
          Padding(
              padding: EdgeInsets.only(top: 2.v),
              child: Text("msg_forgot_password".tr,
                  style: theme.textTheme.titleSmall))
        ]));
  }

  /// Calls the https://seere.somee.com/api/Account/login API and triggers a [CreateLoginEvent] event on the [SignInBloc] bloc.
  ///
  /// Validates the form and triggers a [CreateLoginEvent] event on the [SignInBloc] bloc if the form is valid.
  /// The [BuildContext] parameter represents current [BuildContext]
  signIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<SignInBloc>().add(
            CreateLoginEvent(
              onCreateLoginEventSuccess: () {
                _onLoginAccountEventSuccess(context);
              },
              onCreateLoginEventError: () {
                _onLoginAccountEventError(context);
              },
            ),
          );
    }
  }

  /// Displays an alert dialog when the action is triggered.
  /// The dialog box contains a title and a message with the `Woooooooow`
  void _onLoginAccountEventSuccess(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('success'),
              content: const Text('Woooooooow'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'))
              ],
            ));
  }

  /// Displays an alert dialog when the action is triggered.
  /// The dialog box contains a title and a message with the `try again`
  void _onLoginAccountEventError(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('error'),
              content: const Text('try again'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'))
              ],
            ));
  }
}
