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
      title: const Text('Filter by', textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('CATEGORIES'),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(0.0),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                      title: Text(categories[index]),
                      value: categories[index],
                      groupValue: category,
                      onChanged: (value) {
                        setState(() {
                          category = value as String;
                        });
                      });
                },
              ),
            ),
            const SizedBox(height: 15),
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
