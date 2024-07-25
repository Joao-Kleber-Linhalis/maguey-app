// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/my_buttons/my_loader_elevated_button.dart';
import 'package:magueyapp/common/widget/my_text_field.dart';
import 'package:magueyapp/presentation/auth/repository/auth_repository.dart';
import 'package:magueyapp/presentation/auth/ui/widgets/reset_password/password_confirmation_dialog.dart';
import 'package:magueyapp/presentation/auth/ui/widgets/sign_up/background_image_greeting_widget.dart';
import 'package:magueyapp/service/di.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String route = "reset_password";
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController? emailController;
  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController!.dispose();
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
              imageUrl: MyImages.startingScreenShape,
              heading: "Reset Password", //"Welcome Back",
              description:
                  "For reset password, enter an email and verify the otp.",
              height: 33.25,
            ),
            const Spacer(),
            MyTextFormField(
              title: "Email",
              margin: 16.paddingH(context),
              hintText: "Enter your email",
              bottomSpace: 0,
              controller: emailController!,
            ),
            32.vSpace(context),
            MyLoaderElvButton(
              text: "Send Email",
              loader: loader,
              onPressed: () async => _forgotPassword(context),
              padding: 16.paddingH(context),
              textStyle: myTextStyle.font_14w400,
            ),
            const Spacer(flex: 7),
          ],
        ),
      ),
    );
  }

  Future<void> _forgotPassword(BuildContext context) async {
    primaryFocus!.unfocus();
    setState(() => loader = true);
    bool emailSent = await authRepo.forgotPassword(
      context,
      email: emailController!.text,
    );
    setState(() => loader = false);

    if (emailSent) confirmationDialog(context, emailController!.text);
  }
}
