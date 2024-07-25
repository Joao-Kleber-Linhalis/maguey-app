import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magueyapp/common/widget/my_buttons/my_loader_elevated_button.dart';
import 'package:magueyapp/common/widget/my_buttons/my_outline_button.dart';
import 'package:magueyapp/common/widget/my_buttons/my_text_button.dart';
import 'package:magueyapp/common/widget/my_text_field.dart';
import 'package:magueyapp/presentation/auth/ui/widgets/get_started/divider_with_text_widget.dart';
import 'package:magueyapp/presentation/auth/ui/widgets/sign_up/background_image_greeting_widget.dart';
import 'package:magueyapp/presentation/auth/repository/auth_repository.dart';
import 'package:magueyapp/presentation/auth/ui/screens/reset_password.dart';
import 'package:magueyapp/presentation/auth/ui/widgets/sign_in/text_button_view.dart';
import 'package:magueyapp/presentation/auth/ui/screens/sign_up.dart';
import 'package:magueyapp/presentation/auth/ui/widgets/sign_up/show_password_widget.dart';
import 'package:magueyapp/service/di.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class SignInScreen extends StatefulWidget {
  static const String route = "sign_in";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController? emailController, passwordController;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordController!.dispose();
    super.dispose();
  }

  var authRepo = getIt<AuthRepository>();
  bool showPassword = false;
  bool loader = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ImagedBackgroundGreetingsWidget(
              imageUrl: MyImages.signInScreenShape,
              heading: "Sign In", //"Welcome Back",
              description:
                  "Enter your registered email and correct password for sign in",
              height: 30.17,
            ),
            const Spacer(),
            MyTextFormField(
              title: "Email",
              margin: 16.paddingH(context),
              hintText: "Enter your email",
              bottomSpace: 21,
              controller: emailController!,
            ),
            MyTextFormField(
              title: "Password",
              margin: 16.paddingH(context),
              hintText: "Enter password",
              obscure: !showPassword,
              bottomSpace: 16,
              controller: passwordController!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShowPasswordButton(
                  onTap: (val) {
                    setState(() => showPassword = !showPassword);
                  },
                  margin: 20.paddingLeft(context).copyWith(top: 5.pxV(context)),
                  value: showPassword,
                ),
                MyTextButton(
                  topPadding: 5,
                  text: "Forgot Password?",
                  underlineText: true,
                  splashColor: null,
                  underlineColor: MyColors.green658F7B,
                  space: 16,
                  style: myTextStyle.font_12w400.copyWith(
                    color: MyColors.green658F7B,
                    fontSize: 10.pxV(context),
                  ),
                  onTap: () =>
                      context.pushReplacementNamed(ResetPasswordScreen.route),
                ),
              ],
            ),
            32.vSpace(context),
            MyLoaderElvButton(
              text: "Sign In",
              loader: loader,
              onPressed: () async => _signIn(context),
              padding: 16.paddingH(context),
              textStyle: myTextStyle.font_14w400,
            ),
            32.vSpace(context),
            DividerWithText(
              style: myTextStyle.font_14w500Black,
              text: "Or sign in with",
            ),
            32.vSpace(context),
            MyOutlineButton(
              iconSpacing: 33.pxH(context),
              prefixIcon: SvgPicture.asset(MyIcons.googleIcon),
              text: "Sign in with Google",
              onPressed: () async => await _onGoogleLogin(context),
              padding: 16.paddingH(context),
            ),
            const Spacer(flex: 5),
            TextButtonRow(
              buttonText: "Register Now",
              message: "Not Registered Yet?",
              onTap: () {
                context.pushReplacementNamed(SignUpScreen.route);
              },
            ),
            34.vSpace(context),
          ],
        ),
      ),
    );
  }

  Future<void> _onGoogleLogin(BuildContext context) async {
    primaryFocus!.unfocus();
    await authRepo.signInWithGoogle(context);
  }

  Future<void> _signIn(BuildContext context) async {
    primaryFocus!.unfocus();
    setState(() => loader = true);
    await authRepo.signIn(
      context,
      email: emailController!.text,
      password: passwordController!.text,
    );

    setState(() => loader = false);
  }
}
