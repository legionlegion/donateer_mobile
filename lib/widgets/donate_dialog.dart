import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class DonateDialog extends StatefulWidget {
  final String name;

  DonateDialog({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  _DonateDialogState createState() => _DonateDialogState();
}

class _DonateDialogState extends State<DonateDialog> {
  var start;
  var end;
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      scrollable: true,
      title: Text('Donationing your time'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
                'Thank you for your support to ${widget.name}. How many hours do you want to donate?'),
            TextButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    onConfirm: (date) {
                      setState(() {
                        start = date.toString();
                      }); //2022-05-15 18:07:00.000 (need tostring?)
                    },
                  );
                },
                child: Text(
                  'Select start time',
                  style: TextStyle(color: Colors.blue[900]),
                )),
            Text(start == null ? '' : '${start}'),
          
            TextButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    onConfirm: (date) {
                      setState(() {
                        end = date.toString();
                      });
                    },
                  );
                },
                child: Text(
                  'Select end time',
                  style: TextStyle(color: Colors.blue[900]),
                )),
            Text(end == null ? '' : '${end}'),
            SizedBox(height: 12),
            ElevatedButton(
                child: Text("Submit"),
                onPressed: () {
                  // your code
                })
          ],
        ),
      ),
    );
  }
}
