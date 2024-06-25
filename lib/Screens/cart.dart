import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'home_screen.dart';


class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _currentIndex = 1; // Set the initial highlighted item to 'Cart'
  late User _user;
  late CollectionReference _cartCollection; // Provide a type for the variable

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _cartCollection = FirebaseFirestore.instance.collection('cart');

    print('Firestore collection: ${_cartCollection.path}');

    FirebaseApp app = Firebase.app(); // Get the default FirebaseApp
    print('Firebase project name: ${app.options.projectId}');

    // Print all documents in the 'cart' collection
    _cartCollection.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print('Document ID: ${doc.id}, Data: ${doc.data()}');
      });
    });
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.teal,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Me',
          backgroundColor: Colors.orange,
        ),
      ],
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey[400],
      backgroundColor: Colors.white,
      elevation: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CartScreen'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(), // Empty container, as we're not displaying any content
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

