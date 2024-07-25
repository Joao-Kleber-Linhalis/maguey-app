import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/common/widget/my_text_field.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/review/redux/action.dart';
import 'package:magueyapp/presentation/review/redux/reducer.dart';
import 'package:magueyapp/presentation/review/redux/store.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class AddNoteWidget extends StatefulWidget {
  final String? initialText;
  const AddNoteWidget({
    super.key,
    required this.initialText,
  });

  @override
  State<AddNoteWidget> createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  TextEditingController? controller;

  @override
  void initState() {
    controller = TextEditingController();
    if (widget.initialText != null) {
      controller!.text = widget.initialText!;
    }

    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ReviewState, ReviewState>(
      converter: (store) => store.state,
      builder: (context, store) => Padding(
        padding: 16.paddingH(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              "Add Note",
              style: myTextStyle.font_15w700Black,
            ),
            6.vSpace(context),
            MyTextFormField(
              hintText: "Write something",
              hintColor: MyColors.greyB7B7B7,
              textFieldHeight: 119,
              obscure: false,
              showTitle: false,
              maxLines: 5,
              controller: controller,
              onChanged: (note) {
                reviewStore.dispatch(AddReviewNoteAction(text: note));
              },
            ),
          ],
        ),
      ),
    );
  }
}
