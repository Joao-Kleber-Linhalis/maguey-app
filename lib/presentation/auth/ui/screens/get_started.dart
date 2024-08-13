import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magueyapp/common/widget/my_buttons/my_outline_button.dart';
import 'package:magueyapp/presentation/auth/ui/screens/sign_in.dart';
import 'package:magueyapp/presentation/auth/ui/screens/sign_up.dart';
import 'package:magueyapp/presentation/auth/ui/widgets/get_started/divider_with_text_widget.dart';
import 'package:magueyapp/presentation/auth/ui/widgets/get_started/instructions_widget.dart';
import 'package:magueyapp/presentation/auth/ui/widgets/sign_in/text_button_view.dart';
import 'package:magueyapp/presentation/auth/ui/widgets/sign_up/background_image_greeting_widget.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class GetStartedScreen extends StatefulWidget {
  static const String route = "get_started_screen";
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  // var authRepo = getIt<AuthRepository>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ImagedBackgroundGreetingsWidget(
            imageUrl: MyImages.startingScreenShape,
            heading: "Getting started", //"Welcome Back",
            description: "Create account to continue",
            height: 33.25,
          ),
          const Spacer(flex: 2),
          MyOutlineButton(
            iconSpacing: 33.pxH(context),
            prefixIcon: SvgPicture.asset(MyIcons.googleIcon),
            text: "Sign up with Google",
            onPressed: _signUpWithGoogle,
            padding: 42.paddingH(context),
          ),
          16.vSpace(context),
          DividerWithText(
            style:
                myTextStyle.font_13w700.copyWith(color: MyColors.black0D0D0D),
            text: "Or",
          ),
          16.vSpace(context),
          MyOutlineButton(
            iconSpacing: 33.pxH(context),
            prefixIcon: SvgPicture.asset(MyIcons.mailIcon),
            text: "Sign up with Email",
            onPressed: () => context.pushNamed(SignUpScreen.route),
            padding: 42.paddingH(context),
          ),
          31.vSpace(context),
          TextButtonRow(
            buttonText: "Sign In",
            message: "Already have an account",
            onTap: () {
              context.pushNamed(SignInScreen.route);
            },
          ),
          8.vSpace(context),
          InstructionWidget(
            onPrivacyPolicyTap: () {},
            onTermsAndPoliciesTap: () {},
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }

  _signUpWithGoogle() async {
    //await authRepo.signUpWithGoogle(context);
  }
}
