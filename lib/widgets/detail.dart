import 'package:avatar_plus/avatar_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_flutter/utils/constant.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import '';
class DetailScreen extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> details;

  DetailScreen({required this.details});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return GiffyDialog(
                  content: Row(
                    children: [

                    ],
                  ),
                    giffy: Text('Add review'));
              });
          print(widget.details.exists);
        },
        label: Text('Add Review'),
      ),
      appBar: AppBar(
        title: const Text('PARIS'),
        backgroundColor: Colors.white,
        excludeHeaderSemantics: true,
        toolbarHeight: 80,
        leading: const Icon(
          Icons.location_on_sharp,
          size: 40,
        ),
      ),
      body: Container(
        child: SafeArea(
          child: Container(
            child: FutureBuilder(
                future: db.collection('restaurants').doc().get(),
                builder: (context, snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(
                        widget.details['image_url'],
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.food_bank,
                                size: 45,
                                color: Colors.lightBlueAccent,
                              ),
                              subtitle: Text(widget.details['res_location'],
                                  style: TextStyle(
                                    color: Colors.blue.shade800,
                                    fontWeight: FontWeight.w400,
                                  )),
                              title: Text(
                                widget.details['res_name'],
                                style: TextStyle(
                                    color: Colors.blue.shade800,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 32),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              'Review',
                              style: TextStyle(
                                  color: Colors.blue.shade800,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 32),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.details['reviews'].length,
                              itemBuilder: (context, index) {
                                var reviews = widget.details['reviews'][index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    child: AvatarPlus('sdsd'),
                                  ),
                                  title: Text(reviews['username']),
                                  subtitle: Row(
                                    children: [
                                      for (var i = 0;
                                          i < reviews['rating'];
                                          i++)
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
