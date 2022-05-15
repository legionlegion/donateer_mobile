import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import './organisations_overview_screen.dart';

class OrganisationDetailsScreen extends StatelessWidget {
  final Map obj;

  const OrganisationDetailsScreen({Key? key, required this.obj})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrganisationsOverviewScreen(),
                  ),
                  (route) => false,
                );
              }),
          title: Text(obj['name']),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.favorite_outline_rounded),
                onPressed: () {})
          ]),
      body: SingleChildScrollView(
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(obj['imageUrl'], height: 145, fit: BoxFit.fitWidth),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Container(
                height: MediaQuery.of(context).size.height - 280,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'ABOUT US',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(height: 7),
                        Text(obj['description'].replaceAll("\\n", "\n")),
                        const SizedBox(height: 15),
                        Text(
                          'CONTACT',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(height: 7),
                        Row(children: [
                          const Icon(Icons.laptop),
                          const Spacer(flex: 1),
                          Text(obj['website']),
                          const Spacer(flex: 15),
                        ]),
                        const SizedBox(height: 5),
                        Row(children: [
                          const Icon(Icons.call),
                          const Spacer(flex: 1),
                          Text(obj['contactNo']),
                          const Spacer(flex: 15),
                        ]),
                        const SizedBox(height: 5),
                        Row(children: [
                          const Icon(Icons.email),
                          const Spacer(flex: 1),
                          Text(obj['email']),
                          const Spacer(flex: 15),
                        ]),
                      ],
                    ),
                    ElevatedButton(
                      child: const Text('DONATE YOUR TIME'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: Text('Donationing your time'),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                          'Thank you for your support to ${obj['name']}. How many hours do you want to donate?'),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Number of hours',
                                        ),
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.datetime,
                                        decoration: InputDecoration(
                                          labelText: 'Date',
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            DatePicker.showDateTimePicker(context,
                                                showTitleActions: true,
                                                minTime:
                                                    DateTime.now(),
                                                onChanged: (date) {
                                              print('change $date in time zone ' +
                                                  date.timeZoneOffset.inHours
                                                      .toString());
                                            }, onConfirm: (date) {
                                              print('confirm $date');
                                            });
                                          },
                                          child: Text(
                                            'Select end time',
                                            style: TextStyle(color: Colors.blue),
                                          )),
                                      SizedBox(height: 12),
                                      ElevatedButton(
                                          child: Text("Submit"),
                                          onPressed: () {
                                            // your code
                                          })
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
