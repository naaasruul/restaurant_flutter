import 'package:avatar_plus/avatar_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  var _auth = FirebaseAuth.instance;
  var reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return GiffyDialog(
                  content: TextField(
                    controller: reviewController,
                  ),
                    actions: [ElevatedButton(onPressed: (){
                      var userReview = {
                        'reviews' :FieldValue.arrayUnion([
                          {
                            'rating':reviewController.text,
                            'username':  _auth.currentUser!.email
                          }
                        ])
                      };

                      db.collection('restaurants').doc(widget.details.id).update(userReview);

                    }, child: Text('Submit'))],
                    giffy: Text('Add review'));
              });
          print(widget.details.id);
        },
        label: Text('Add Review'),
      ),
      appBar: AppBar(
        title: Text(widget.details['res_location']),
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
          child: SingleChildScrollView(
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
                              StreamBuilder<DocumentSnapshot>(stream: db.collection('restaurants').doc(widget.details.id).snapshots(), builder: (ctx,snapshot){
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                }
                                if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                }
            
                                final data = snapshot.requireData;
            
                                return
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data['reviews'].length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: CircleAvatar(
                                          child: AvatarPlus('john'),
                                        ),
                                        title: Text(data['reviews'][index]['username']),
                                        subtitle: Text(data['reviews'][index]['rating']),
                                      );
                                    },
                                  )
            
                                  ;
                              })
            
                            ],
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}

