import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magueyapp/utils/extention.dart';
import 'package:magueyapp/widgets/global_padding.dart';
import 'package:magueyapp/widgets/sized_box.dart';
import 'package:provider/provider.dart';

import '../../../../provider/google_sign_in_provider.dart';
import '../../../../provider/log_in_sign_up_provider.dart';
import '../../../../theme/my_icons.dart';
import '../../../../theme/text_styling.dart';
import '../../../../utils/app_route.dart';
import '../../../../widgets/LoaderElevatedButton.dart';
import '../../../../widgets/divider_with_text.dart';
import '../../../../widgets/image_background_greetings_widget.dart';
import '../../../../widgets/my_outline_button.dart';
import '../../../../widgets/my_text_form_field.dart';
import '../../../../widgets/show_password_button.dart';
import '../../../../widgets/text_button_row.dart';
import '../../../widgets/text_view.dart';
import '../log_in/log_in.dart';
import '../me_section/ui/sub_screens/me_terms.dart';

class SignUpScreen extends StatefulWidget {
  static const String route = "sign_up";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController? emailController,
      passwordController,
      confirmPasswordController;
  bool showPassword = false, loader = false;
  //var authRepo = getIt<AuthRepository>();
  late LogInSignUpProvider logInSignUpProvider;
  late GoogleSignInProvider googleSignInProvider;

  @override
  void initState() {
    logInSignUpProvider =
        Provider.of<LogInSignUpProvider>(context, listen: false);
    googleSignInProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordController!.dispose();
    confirmPasswordController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: logInSignUpProvider.formKeyAuthenticationSignUp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ImagedBackgroundGreetingsWidget(
                heading: "Register to join us",
                description: "Please enter your details to sign up.",
              ),
              const SizedBox(height: 20),
              MyTextFormField(
                title: "",
                margin: 16.paddingH(context),
                hintText: "Enter your email",
                controller: logInSignUpProvider.signUpEmail,
                bottomSpace: 21,
                validator: logInSignUpProvider.validateEmailSignUp,
              ),
              MyTextFormField(
                title: "",
                margin: 16.paddingH(context),
                hintText: "Enter password",
                obscure: !showPassword,
                controller: logInSignUpProvider.signUpPassword,
                bottomSpace: 21,
                validator: logInSignUpProvider.validatePasswordSignUp,
              ),
              MyTextFormField(
                title: "Confirm Password",
                margin: 16.paddingH(context),
                hintText: "Re-enter password",
                obscure: !showPassword,
                controller: logInSignUpProvider.signUpConfirmPassword,
                bottomSpace: 15,
                validator: logInSignUpProvider.validateConfirmPassword,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckBoxWithText(
                    text: "Show password",
                    onTap: (val) {
                      setState(() => showPassword = !showPassword);
                    },
                    margin: 20.paddingLeft(context),
                    value: showPassword,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CheckBoxWithText(
                          text: "I accept the terms",
                          onTap: (val) {
                            setState(() => logInSignUpProvider.isCheckedTerms =
                                !logInSignUpProvider.isCheckedTerms);
                          },
                          margin: 20.paddingLeft(context),
                          value: logInSignUpProvider.isCheckedTerms,
                        ),
                        GestureDetector(
                          onTap: () {
                            AppRoutes.push(context, const MeTerms());
                          },
                          child: TextView(
                            'Terms & conditions',
                            style:
                                TextStyleCustom().font_14w500Black.copyWith(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              14.vSpace(context),
              MyLoaderElvButton(
                text: "Register",
                loader: loader,
                onPressed: () async {
                  await _signUp(logInSignUpProvider);
                },
                padding: 16.paddingH(context),
                textStyle: TextStyleCustom().font_14w400,
              ),
              const SizedBox(height: 32),
              DividerWithText(
                style: TextStyleCustom().font_14w500Black,
                text: "Or",
              ),
              const SizedBox(height: 32),
              MyOutlineButton(
                iconSpacing: 33.pxH(context),
                prefixIcon: SvgPicture.asset(MyIcons.googleIcon),
                text: "Continue with Google",
                onPressed: _signUpWithGoogle,
                padding: 16.paddingH(context),
              ),
              const SizedBox(height: 16),
              TextButtonRow(
                buttonText: "Login",
                message: "Have an account?",
                onTap: () {
                  AppRoutes.replace(context, const LogInScreen());
                },
              ),
              34.vSpace(context),
            ],
          ),
        ),
      ),
    );
  }

  _signUp(LogInSignUpProvider logInSignUpProvider) async {
    primaryFocus!.unfocus();
    setState(() => loader = true);
    await logInSignUpProvider.checkConditionsSignUpUser(context);
    /*await authRepo.createAnAccount(
      context,
      email: emailController!.text.trim(),
      password: passwordController!.text.trim(),
      confirmPassword: confirmPasswordController!.text.trim(),
    );*/

    setState(() => loader = false);
  }

  _signUpWithGoogle() async {
    //googleSignInProvider.signInWithGoogle(context);

    primaryFocus!.unfocus();
  }
}
