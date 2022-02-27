import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class getTime extends StatelessWidget {
  final String title;
  getTime(this.title);
  @override
  Widget build(BuildContext context) {
    CollectionReference times = FirebaseFirestore.instance.collection('movies');
    return FutureBuilder<DocumentSnapshot>(
        future: times.doc(title).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something Wrong");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return GridView.builder(
                itemCount: data['Time'].length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 4.0,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0),
                itemBuilder: (context, index) => SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            data['Time'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'font1'),
                          ),
                        ),
                      ),
                    ));
          }

          return Text("loading");
        });
  }
}
