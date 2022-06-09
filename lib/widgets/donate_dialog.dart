import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

import '../screens/donation_screen.dart';

class DonateDialog extends StatefulWidget {
  final String name;
  final Map obj;

  DonateDialog(
      {Key? key, required this.name, required this.obj})
      : super(key: key);
  @override
  _DonateDialogState createState() => _DonateDialogState();
}

class _DonateDialogState extends State<DonateDialog> {
  String start = '';
  String end = '';
  User? user = FirebaseAuth.instance.currentUser;
  List _donations = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get();
    setState(() {
      if (data['donations'] != null) {
        _donations = data['donations'];
      } else {
        _donations = [];
      }
    });
  }

  updateFirestore() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .update({'donations': _donations});
  }

  Event getEvent(start, end) {
    Event event = Event(
      title: 'Donation to: ' + widget.name,
      description: widget.obj["description"].replaceAll("\\n", "\n") +
          '\nDonation link: ' +
          widget.obj["donationUrl"],
      startDate: DateTime.parse(start),
      endDate: DateTime.parse(end),
    );
    return event;
  }

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
            Text(start == '' ? '' : start.substring(0, 19)),
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
            Text(end == '' ? '' : end.substring(0, 19)),
            SizedBox(height: 12),
            ElevatedButton(
                child: Text("Submit"),
                onPressed: () {
                  var duration = DateTime.parse(end).difference(DateTime.parse(start));
                  _donations.add({'name': widget.name, 'start': start, 'end': end, 'duration': duration.inMinutes});
                  updateFirestore();
                  Add2Calendar.addEvent2Cal(getEvent(start, end));
                  
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => DonationScreen(
                        obj: widget.obj
                      ),
                    ),
                    (route) => false,
                  );
                })
          ],
        ),
      ),
    );
  }
}
