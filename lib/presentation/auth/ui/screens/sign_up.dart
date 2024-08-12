import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magueyapp/common/widget/my_buttons/my_loader_elevated_button.dart';
import 'package:magueyapp/common/widget/my_buttons/my_outline_button.dart';
import 'package:magueyapp/common/widget/my_text_field.dart';
import 'package:magueyapp/presentation/auth/ui/widgets/get_started/divider_with_text_widget.dart';
import 'package:magueyapp/presentation/auth/ui/widgets/sign_up/background_image_greeting_widget.dart';
import 'package:magueyapp/presentation/auth/ui/screens/sign_in.dart';
import 'package:magueyapp/presentation/auth/ui/widgets/sign_in/text_button_view.dart';
import 'package:magueyapp/presentation/auth/ui/widgets/sign_up/show_password_widget.dart';
import 'package:magueyapp/service/di.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

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

  @override
  void initState() {
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ImagedBackgroundGreetingsWidget(
              imageUrl: MyImages.signUpScreenShape,
              heading: "Welcome Back",
              description:
                  "Enter a new email and set password for registration.",
              height: 26.48,
            ),
            const Spacer(),
            MyTextFormField(
              title: "Email",
              margin: 16.paddingH(context),
              hintText: "Enter your email",
              controller: emailController!,
              bottomSpace: 21,
            ),
            MyTextFormField(
              title: "Password",
              margin: 16.paddingH(context),
              hintText: "Enter password",
              obscure: !showPassword,
              controller: passwordController!,
              bottomSpace: 21,
            ),
            MyTextFormField(
              title: "Confirm Password",
              margin: 16.paddingH(context),
              hintText: "Re-enter password",
              obscure: !showPassword,
              controller: confirmPasswordController!,
              bottomSpace: 15,
            ),
            ShowPasswordButton(
              onTap: (val) {
                setState(() => showPassword = !showPassword);
              },
              margin: 20.paddingLeft(context),
              value: showPassword,
            ),
            14.vSpace(context),
            MyLoaderElvButton(
              text: "Sign Up",
              loader: loader,
              onPressed: _signUp,
              padding: 16.paddingH(context),
              textStyle: myTextStyle.font_14w400,
            ),
            16.vSpace(context),
            DividerWithText(
              style: myTextStyle.font_14w500Black,
              text: "Or sign in with",
            ),
            16.vSpace(context),
            MyOutlineButton(
              iconSpacing: 33.pxH(context),
              prefixIcon: SvgPicture.asset(MyIcons.googleIcon),
              text: "Sign up with Google",
              onPressed: _signUpWithGoogle,
              padding: 16.paddingH(context),
            ),
            const Spacer(flex: 7),
            TextButtonRow(
              buttonText: "Sign In",
              message: "Already Registered?",
              onTap: () {
                context.pushReplacementNamed(SignInScreen.route);
              },
            ),
            34.vSpace(context),
          ],
        ),
      ),
    );
  }

  _signUp() async {
    primaryFocus!.unfocus();
    setState(() => loader = true);

    /*await authRepo.createAnAccount(
      context,
      email: emailController!.text.trim(),
      password: passwordController!.text.trim(),
      confirmPassword: confirmPasswordController!.text.trim(),
    );*/

    setState(() => loader = false);
  }

  _signUpWithGoogle() async {
    primaryFocus!.unfocus();
    //await authRepo.signUpWithGoogle(context);
  }
}
