import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _restaurants = [
    {'name': 'KFC', 'image_url': 'https://download.logo.wine/logo/KFC/KFC-Logo.wine.png', 'location': 'bangi'},
    {'name': 'Mcdonald', 'image_url': 'https://w7.pngwing.com/pngs/719/645/png-transparent-mcdonalds-round-logo.png', 'location': 'Shah Alam'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: _restaurants.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image(
                    image: NetworkImage(_restaurants[index]['image_url']!)),
                trailing: const Icon(Icons.chevron_right),
                subtitle: Text(_restaurants[index]['location']!),
                title: Text(_restaurants[index]['name']!),
              );
            }),
      ),
    );
  }
}
