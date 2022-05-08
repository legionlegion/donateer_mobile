import 'package:flutter/material.dart';
import '../models/organisation.dart';
import '../widgets/organisation_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganisationsOverviewScreen extends StatelessWidget {
  final List<Organisation> organisations = [
    Organisation(
      name: "World Wide Fund for Nature Singapore",
      description:
          "WWF-Singapore was founded in March 2006 to engage individuals and organisations in Singapore towards making a positive change in their lives and business operations.\n\nThrough our awareness campaigns and outreach activities, we aim to educate individuals from all walks of life on how a simple action can add up to make a big difference to our environment and safeguard the world’s biodiversity.",
      categories: ["Animal", "Environment"],
      website: "info@wwf.sg",
      contactNo: "6730 8100",
      email: "info@wwf.sg",
      imageUrl:
          "https://media-exp1.licdn.com/dms/image/C5622AQHdCZ0mVUUOWQ/feedshare-shrink_2048_1536/0/1650526293171?e=2147483647&v=beta&t=INjnjNGSC55gQBQAcRtsLqExMzniOYMUAmOLMfeKRZM",
      donateMessage:
          "Human activities are destroying the natural world we all depend on for our survival and well-being. The threats grow by the day. But WWF remains hopeful and works tirelessly with people around the world to build a future where humanity and nature thrive.\n\nMillions of like-minded individuals like you are already making their voice heard. But hundreds of millions more must act if we are to have the big impact that’s so desperately needed. Every single one of us has a role to play. By supporting WWF, you are doing something positive for the future of people and planet.",
    ),
    Organisation(
      name: "Children Cancer foundation",
      description:
          "Children’s Cancer Foundation (CCF) is a social service agency with a mission to improve the quality of life of children with cancer and their families and children impacted by cancer through enhancing their emotional, social and medical well-being. \n\nFounded in 1992, CCF provides children with cancer and their families the much needed support in their battle against the life threatening illness. Over the years, CCF has helped more than 3500 children and their families at different stages of the illness and recovery.",
      categories: ["Children", "Health"],
      website: "https://www.ccf.org.sg/",
      contactNo: "6229 3701",
      email: "ccfadmin@ccf.org.sg",
      imageUrl:
          "https://www.ccf.org.sg/wp-content/uploads/2020/06/FR-page-Hair-for-Hope-1024x684.jpg",
      donateMessage:
          "Volunteers are important assets and are valued for their experiences and services. A strong volunteer base allows for contributions from the volunteers to be effectively integrated with existing resources to help meet the core mission of CCF.  Join us as a volunteer and be part of a meaningful and rewarding journey for children who are affected by cancer.",
    )
  ];

  @override
  Widget build(BuildContext context) {
    /*
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('Organisations').snapshots(),
        builder: (ctx, AsyncSnapshot streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.documents;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[index]['description']),
            ),
          );
        },
      ),
    );
    */
    return Scaffold(
       appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('Organisations').snapshots(),
        builder: (ctx, AsyncSnapshot streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[index]['description']),
            ),
          );
        },
      ),
    );
  }
}
