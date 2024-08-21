// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:magueyapp/provider/log_in_sign_up_provider.dart';
import 'package:magueyapp/widgets/global_padding.dart';
import 'package:magueyapp/widgets/sized_box.dart';
import 'package:provider/provider.dart';

import '../../../theme/my_icons.dart';
import '../../../theme/text_styling.dart';
import '../../../widgets/LoaderElevatedButton.dart';
import '../../../widgets/image_background_greetings_widget.dart';
import '../../../widgets/my_text_form_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String route = "reset_password";
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController? emailController;
  late LogInSignUpProvider logInSignUpProvider;
  @override
  void initState() {
    logInSignUpProvider = Provider.of<LogInSignUpProvider>(context, listen: false);
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController!.dispose();
    super.dispose();
  }

  //var authRepo = getIt<AuthRepository>();
  bool showPassword = false;
  bool loader = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: logInSignUpProvider.formKeyAuthenticationResetPassword,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ImagedBackgroundGreetingsWidget(
                imageUrl: MyImages.startingScreenShape,
                heading: "Reset Password", //"Welcome Back",
                description: "For reset password, enter an email and verify the otp.",
                height: 33.25,
              ),
              const Spacer(),
              MyTextFormField(
                title: "Email",
                margin: 16.paddingH(context),
                hintText: "Enter your email",
                bottomSpace: 0,
                controller: logInSignUpProvider.resetPasswordEmail,
                validator: logInSignUpProvider.validateEmailResetPassword,
              ),
              32.vSpace(context),
              MyLoaderElvButton(
                text: "Send Email",
                loader: loader,
                onPressed: () async => _forgotPassword(context),
                padding: 16.paddingH(context),
                textStyle: TextStyleCustom().font_14w400,
              ),
              const Spacer(flex: 7),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _forgotPassword(BuildContext context) async {
    primaryFocus!.unfocus();
    setState(() => loader = true);
    await logInSignUpProvider.resetPassword(context: context);
    setState(() => loader = false);

    //if (emailSent) confirmationDialog(context, emailController!.text);
  }
}
