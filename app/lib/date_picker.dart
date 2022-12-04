import 'globals/functions.dart';
import 'globals/variables.dart';
import 'entry_field.dart';
import 'package:flutter/cupertino.dart';

class DatePicker extends StatefulWidget {
  final Function(DateTime) onSaved;
  final Function(DateTime) onFieldSubmitted;
  final String? label;
  final int? ageLimit;
  final bool autovalidate;
  final DateTime? initialValue;

  const DatePicker({
    Key? key,
    this.label,
    this.ageLimit,
    this.autovalidate = false,
    this.initialValue,
    required this.onSaved,
    required this.onFieldSubmitted,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime selectedDate = widget.initialValue ?? DateTime.now();

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context);

    void showPopup(CupertinoDatePicker picker) {
      showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => Container(
            height: screen.size.height / 4,
            padding: const EdgeInsets.only(top: 5),
            margin: EdgeInsets.only(
              bottom: screen.viewInsets.bottom,
            ),
            color: CupertinoColors.white,
            child: SafeArea(
              top: false,
              child: picker,
            ),
          )
      );
    }

    String date = '${months[selectedDate.month-1]} ${selectedDate.day}, ${selectedDate.year}';

    TextEditingController controller = TextEditingController(text: date);

    print("Date: $date");

    return EntryField(
      widget.label,
      readOnly: true,
      controller: controller,
      onSaved: (dateTime) {
        widget.onSaved(DateTime(selectedDate.year, selectedDate.month, selectedDate.day));
      },
      onFieldSubmitted: (dateTime) {
        widget.onSaved(DateTime(selectedDate.year, selectedDate.month, selectedDate.day));
      },
      autovalidate: widget.autovalidate,
      validator: widget.ageLimit == null ? null : (value) {
        if(age(selectedDate) < widget.ageLimit!) {
          return "you must be ${widget.ageLimit} to join.";
        } else {
          return null;
        }
      },
      onTap: () => showPopup(
        CupertinoDatePicker(
          initialDateTime: selectedDate,
          maximumDate: DateTime.now(),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (DateTime entry) {
            setState(() {
              selectedDate = entry;
            });
          },
        ),
      ),
    );
  }
}