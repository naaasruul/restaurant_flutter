import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_flutter/utils/constant.dart';
import 'package:avatar_plus/avatar_plus.dart';
import 'package:restaurant_flutter/widgets/detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;
  var _restaurants = [
    {
      'name': 'KFC',
      'image_url': 'https://download.logo.wine/logo/KFC/KFC-Logo.wine.png',
      'location': 'bangi'
    },
    {
      'name': 'Mcdonald',
      'image_url':
          'https://w7.pngwing.com/pngs/719/645/png-transparent-mcdonalds-round-logo.png',
      'location': 'Shah Alam'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kBoxDecoration,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(16),
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print(user);
                          },
                          child: AvatarPlus(
                            "Jonny",
                            height: 70,
                            width: 70,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          '${user?.email!}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                'Restaurants',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: GridView.builder(
              //       itemCount: _restaurants.length,
              //       itemBuilder: (context, index) {
              //         return Card(
              //           child: Column(
              //             children: [
              //               Flexible(
              //                   child: Image.network(
              //                     _restaurants[index]['image_url']!,
              //                     fit: BoxFit.fill,)),
              //               Text(_restaurants[index]['name']!),
              //               Text(_restaurants[index]['location']!),
              //             ],
              //           ),
              //         );
              //       }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 3
              //     ),),
              //   ),
              // ),
              FutureBuilder(
                  future: db.collection('restaurants').get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('something went wrong'),
                      );
                    }
                    final restaurants = snapshot.data?.docs;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                            itemCount: restaurants?.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              print(restaurants?[index]);

                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(details:restaurants![index] ,)));
                                },
                                child: Card(
                                  color: Colors.white,
                                  semanticContainer: false,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    restaurants?[index]
                                                        ['image_url']))),
                                        height: 70,
                                        width: 80,
                                      ),
                                      Text(restaurants?[index]['res_name']!),
                                      Text(restaurants?[index]['res_location']!),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
