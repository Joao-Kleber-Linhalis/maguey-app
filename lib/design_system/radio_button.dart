import 'package:flutter/material.dart';

import 'Text/ds_text.dart';
import 'colors.dart';

class RadioButtonExample extends StatefulWidget {
  int selectedValue;
  final Function() toggleRadioButton;

  RadioButtonExample({
    Key? key,
    required this.selectedValue,
    required this.toggleRadioButton,
  }) : super(key: key);

  @override
  State<RadioButtonExample> createState() => _RadioButtonExampleState();
}

class _RadioButtonExampleState extends State<RadioButtonExample> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Radio(
                value: 0,
                groupValue: widget.selectedValue,
                activeColor: DSColors.primaryActionState1,
                onChanged: (value) {
                  if (widget.selectedValue != 0) {
                    setState(() {
                      widget.selectedValue = value as int;
                    });
                    widget.toggleRadioButton();
                  }
                },
              ),
              const DSStandardText(
                text: 'Income',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: DSColors.primaryTextBlack,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: widget.selectedValue,
                activeColor: DSColors.primaryActionState1,
                onChanged: (value) {
                  if (widget.selectedValue != 1) {
                    setState(() {
                      widget.selectedValue = value as int;
                    });
                    widget.toggleRadioButton();
                  }
                },
              ),
              const DSStandardText(
                text: 'Expense',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: DSColors.primaryTextBlack,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
