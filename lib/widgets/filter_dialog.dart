import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String tax = '';
  String category = '';
  final categories = [
    "Animal",
    "Arts & Heritage",
    "Children",
    "Community",
    "Disability",
    "Education",
    "Elderly",
    "Environment",
    "Families",
    "Health",
    "Sports",
    "Women"
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      scrollable: true,
      title: const Text('Filter by'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const Text('CATEGORIES'),
            const Text('TAX'),
            ListTile(
              title: const Text("Tax Deductible"),
              trailing: Radio(
                value: "Tax Deductible",
                groupValue: tax,
                onChanged: (value) {
                  setState(() {
                    tax = value as String;
                  });
                },
                //activeColor: Colors.green,
              ),
            ),
            ListTile(
              title: const Text("Not Tax Deductible"),
              trailing: Radio(
                value: "Not Tax Deductible",
                groupValue: tax,
                onChanged: (value) {
                  setState(() {
                    tax = value as String;
                  });
                },
                //activeColor: Colors.green,
              ),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'SHOW RESULTS',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
