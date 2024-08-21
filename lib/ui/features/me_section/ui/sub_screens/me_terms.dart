import 'package:flutter/material.dart';

import '../../../../../custom_app_bar.dart';
import '../../../../../theme/my_colors.dart';
import '../../../../../theme/text_styling.dart';

class MeTerms extends StatelessWidget {
  const MeTerms({super.key});

  static void navigateTo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeTerms(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black2B2B2B,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Terms and Conditions",
              style: TextStyleCustom().font_14w400.copyWith(
                    color: MyColors.yellowE2D7C1,
                    height: 1.5,
                    fontSize: 20,
                  ),
            ),
            const SizedBox(height: 20),
            Text(
              style: TextStyleCustom().font_14w400.copyWith(
                    color: MyColors.yellowE2D7C1,
                    height: 1.5,
                  ),
              '''
            Maguey All Day Terms and Conditions

Last Updated: 8/19/2024

1. Acceptance of Terms
Welcome to Maguey All Day (“App”). By accessing or using our App, you agree to be bound by these Terms and Conditions (“Terms”). If you do not agree with any part of these Terms, please do not use the App.

2. User Accounts
To access certain features of the App, you may be required to create an account. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account. You agree to provide accurate and complete information when creating your account.

3. Use of the App
You agree to use the App for lawful purposes only. You must not use the App to:

	•	Post, upload, or share any content that is illegal, harmful, or offensive.
	•	Violate the rights of others, including intellectual property rights.
	•	Interfere with or disrupt the App or servers or networks connected to the App.

4. Content and Intellectual Property
The content provided in the App, including but not limited to text, images, logos, and trademarks, is the property of Maguey All Day or its licensors. You may not reproduce, distribute, or create derivative works from the content without prior written permission from Maguey All Day.

5. User-Generated Content
Users may post reviews, ratings, and other content on the App. By posting content, you grant Maguey All Day a non-exclusive, royalty-free, perpetual, and worldwide license to use, reproduce, modify, and display such content. You are solely responsible for the content you post and must ensure that it does not violate the rights of others or applicable laws.

6. Third-Party Links
The App may contain links to third-party websites or services that are not owned or controlled by Maguey All Day. We have no control over, and assume no responsibility for, the content, privacy policies, or practices of any third-party websites or services.

7. Advertisements and Sponsored Content
Maguey All Day may display advertisements and sponsored content within the App. These may be targeted based on user data. By using the App, you agree to the display of such advertisements and sponsored content.

8. Disclaimer of Warranties
The App is provided “as is” and “as available” without warranties of any kind, either express or implied. Maguey All Day does not warrant that the App will be uninterrupted, error-free, or free from viruses or other harmful components.

9. Limitation of Liability
To the fullest extent permitted by law, Maguey All Day shall not be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in connection with the use or inability to use the App.

10. Indemnification
You agree to indemnify and hold harmless Maguey All Day, its affiliates, officers, directors, employees, and agents from and against any claims, damages, liabilities, and expenses arising out of your use of the App or violation of these Terms.

11. Modifications to the Terms
Maguey All Day reserves the right to modify these Terms at any time. We will notify users of any material changes by posting the revised Terms in the App. Your continued use of the App after any changes constitute your acceptance of the new Terms.

12. Termination
Maguey All Day may terminate or suspend your account and access to the App at any time, with or without cause, with or without notice. Upon termination, your right to use the App will cease immediately.

13. Governing Law
These Terms shall be governed by and construed in accordance with the laws of the State of California without regard to its conflict of law principles.

14. Contact Information
If you have any questions about these Terms, please contact us at: salud@magueyallday.com
            ''',
            ),
          ],
        ),
      ),
    );
  }
}
