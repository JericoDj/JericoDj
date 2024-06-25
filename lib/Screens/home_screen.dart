  import 'package:flutter/material.dart';

  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';

import 'cart.dart';



  class HomeScreen extends StatefulWidget {
    const HomeScreen({Key? key}) : super(key: key);

    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {
    int _currentIndex = 0;
    int _boxesInCart = 0;

    List<Map<String, dynamic>> addedWorkers = [];

    void _addWorker(Map<String, dynamic> worker) {
      setState(() {
        addedWorkers.add(worker);
      });
    }



    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Sourcefully'),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.5,
                            child: BoxDetailsScreen(
                              categoryBoxName: getCategoryBoxName(index),
                              price: (index + 1) * 10,
                              categoryIndex: index,
                              addWorkerCallback: _addWorker,
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.teal, width: 2.0),
                      ),
                      margin: EdgeInsets.all(2),
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  getCategoryBoxName(index),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '\$${(index + 1) * 10}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
              if (index == 0) {
                _boxesInCart = 0;
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              }
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart $_boxesInCart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Me',
            ),
          ],
          selectedItemColor: Colors.teal,
        ),
      );
    }

    String getCategoryBoxName(int index) {
      switch (index) {
        case 0:
          return 'Visual Design';
        case 1:
          return 'Business VA';
        case 2:
          return 'Social Media VA';
        case 3:
          return 'Customer Support VA';
        case 4:
          return 'Web Application VA';
        case 5:
          return 'Singapore Math VT';
        default:
          return 'Box $index';
      }
    }
  }

  String getCategoryBoxName(int categoryIndex, int boxIndex) {
    switch (categoryIndex) {
      case 0:
        switch (boxIndex) {
          case 0:
            return 'Photo Editor';
          case 1:
            return 'Video Editor';
          case 2:
            return 'Architectural Design';
          default:
            return 'Box $boxIndex';
        }
      case 1:
        switch (boxIndex) {
          case 0:
            return 'General Virtual Assistant';
          case 1:
            return 'Accounts Virtual Asisstant';
          case 2:
            return 'Legal Virtual Assistant';
          default:
            return 'Box $boxIndex';
        }
      case 2:
        switch (boxIndex) {
          case 0:
            return 'Social Media General Manager';
          case 1:
            return 'Social Media Post Assistant';
          case 2:
            return 'Social Media Chat Assistant';
          default:
            return 'Box $boxIndex';
        }
      case 3:
        switch (boxIndex) {
          case 0:
            return 'Inbound Call Support';
          case 1:
            return 'OutBound Call Support';
          case 2:
            return 'Non-Voice Customer Support';
          default:
            return 'Box $boxIndex';
        }
      case 4:
        switch (boxIndex) {
          case 0:
            return 'Web Developer VA';
          case 1:
            return 'Mobile App Developer VA';
          case 2:
            return 'CryptoCurrency App VA';
          default:
            return 'Box $boxIndex';
        }
      case 5:
        switch (boxIndex) {
          case 0:
            return 'Pre-School Singapore Math';
          case 1:
            return 'Elementary Singapore Math';
          case 2:
            return 'High School Singapore Math';
          default:
            return 'Box $boxIndex';
        }
      default:
        return 'Box $boxIndex';
    }
  }

  class BoxDetailsScreen extends StatefulWidget {
    final String categoryBoxName;
    final int price;
    final int categoryIndex;
    final void Function(Map<String, dynamic> worker) addWorkerCallback;

    BoxDetailsScreen({
      required this.categoryBoxName,
      required this.price,
      required this.categoryIndex,
      required this.addWorkerCallback,
    });

    @override
    _BoxDetailsScreenState createState() => _BoxDetailsScreenState();
  }

  class _BoxDetailsScreenState extends State<BoxDetailsScreen> {
    int boxQuantity = 1;
    int selectedBoxIndex = -1;

    void _incrementQuantity() {
      setState(() {
        if (boxQuantity < 9) {
          boxQuantity++;
        }
      });
    }

    void _decrementQuantity() {
      setState(() {
        if (boxQuantity > 1) {
          boxQuantity--;
        }
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryBoxName),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Container(
              height: 200,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedBoxIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedBoxIndex == index
                            ? Colors.teal
                            : Colors.teal.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.tealAccent,
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            getCategoryBoxName(widget.categoryIndex, index),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '\$${widget.price}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      height: 70,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            selectedBoxIndex != -1
                ? Text(
              'Selected Box Index: $selectedBoxIndex',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
                : SizedBox.shrink(), // Hide if no box is selected
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.teal, width: 2.0),
                  ),
                  child: ClipOval(
                    child: ElevatedButton(
                      onPressed: _decrementQuantity,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(12),
                        shape: CircleBorder(),
                      ),
                      child: Text('-'),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '$boxQuantity',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.teal, width: 2.0),
                  ),
                  child: ClipOval(
                    child: ElevatedButton(
                      onPressed: _incrementQuantity,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(12),
                        shape: CircleBorder(),
                      ),
                      child: Text('+'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedBoxIndex != -1
                  ? () {
                Map<String, dynamic> worker = {
                  'categoryBoxName': widget.categoryBoxName,
                  'price': widget.price,
                  'categoryIndex': widget.categoryIndex,
                  'selectedBoxIndex': selectedBoxIndex,
                  'quantity': boxQuantity,
                  'timestamp': FieldValue.serverTimestamp(),
                };
                widget.addWorkerCallback(worker);
                _addWorkerToFirestore(worker);
              }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              child: Text('Add a Worker'),
            ),
          ],
        ),
      );
    }
    void _addWorkerToFirestore(Map<String, dynamic> worker) {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        worker['userId'] = user.uid;
        worker['email'] = user.email;
        worker['name'] = user.displayName ?? '';

        worker['selectedBoxName'] =
            getCategoryBoxName(widget.categoryIndex, selectedBoxIndex);

        CollectionReference cartCollection =
        FirebaseFirestore.instance.collection('cart');

        cartCollection
            .where('userId', isEqualTo: user.uid)
            .where('selectedBoxName', isEqualTo: worker['selectedBoxName'])
            .get()
            .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            // Document already exists, update the quantity
            var existingDocument = querySnapshot.docs.first;
            cartCollection
                .doc(existingDocument.id)
                .update({
              'quantity': FieldValue.increment(worker['quantity']),
              'timestamp': FieldValue.serverTimestamp(),
            })
                .then((_) {
              print('Quantity updated in Firestore');
              // Show a pop-up indicating that the quantity has been updated
              _showQuantityUpdatedPopup();

              // Close the bottom sheet
              Navigator.pop(context);
            })
                .catchError((error) {
              print('Error updating quantity in Firestore: $error');
            });
          } else {
            // Document does not exist, add the new worker to Firestore
            cartCollection
                .add(worker)
                .then((value) {
              print('Worker added to Firestore');
              // Show a pop-up indicating that the worker has been added to the cart
              _showQuantityUpdatedPopup();

              // Close the bottom sheet
              Navigator.pop(context);
            })
                .catchError((error) {
              print('Error adding worker to Firestore: $error');
            });
          }
        }).catchError((error) {
          print('Error checking document existence in Firestore: $error');
        });
      } else {
        print('User not authenticated');
      }
    }

    void _showQuantityUpdatedPopup() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quantity Updated'),
            content: Text('The quantity has been updated in your cart.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

