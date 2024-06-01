import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth/uid.dart';

class GuardActivityPage extends StatefulWidget {
  @override
  _GuardActivityPageState createState() => _GuardActivityPageState();
}

class _GuardActivityPageState extends State<GuardActivityPage> {
  bool _isActive = false; // Initial state of the toggle switch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guard Activity'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Active'),
                Switch(
                  value: _isActive,
                  onChanged: (value) {
                    setState(() {
                      _isActive = value;
                      // Call function to update guard's activity status
                      updateGuardActivityStatus(value);
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Active Guards',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: _buildActiveGuardsList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateGuardActivityStatus(bool isActive) async {
    try {
      String? guardUID = await getGuardUID(); // Get the guard's UID
      if (guardUID != null) {
        await FirebaseFirestore.instance.collection('activeGuards').doc(guardUID).set({
          'guardUID': guardUID, // Add the guard's UID to the document
          'isActive': isActive,
          // Add other fields as needed, such as guardName, guardLocation, etc.
        });
        print('Guard activity status updated successfully!');
      } else {
        print('Guard UID is null');
      }
    } catch (error) {
      print('Error updating guard activity status: $error');
    }
  }

  Future<String?> getGuardName(String guardUID) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('userProfile').doc(guardUID).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        return data['name'] as String?;
      } else {
        print('No such document!');
        return null;
      }
    } catch (error) {
      print('Error getting guard name: $error');
      return null;
    }
  }

  /*Widget _buildActiveGuardsList() {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('activeGuards').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final documents = snapshot.data!.docs;
          // Check if all guards are inactive
          bool allInactive = documents.every((doc) => !(doc['isActive'] ?? false));

          if (allInactive) {
            return Center(child: Text('No guards are active currently.'));
          } else {
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                // Extract guard data from the document and display it
                final doc = documents[index];
                return ListTile(
                  //title: Text(documents[index]['name']),
                  subtitle: Text(documents[index]['guardUID']),
                  trailing: CircleAvatar(
                    backgroundColor: documents[index]['isActive'] ?? false ? Colors.green : Colors.grey, // Show green dot for active guards
                    radius: 8,
                  ),
                );
              },
            );
          }
        }
      },
    );
  }*/
  Widget _buildActiveGuardsList() {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('activeGuards').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final documents = snapshot.data!.docs;
          // Check if all guards are inactive
          bool allInactive = documents.every((doc) => !(doc['isActive'] ?? false));

          if (allInactive) {
            return Center(child: Text('No guards are active currently.'));
          } else {
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final doc = documents[index];
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('userProfile').doc(doc['guardUID']).get(),
                  builder: (context, userProfileSnapshot) {
                    if (userProfileSnapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        title: Text('Loading...'),
                        subtitle: Text(doc['guardUID']),
                        trailing: CircleAvatar(
                          backgroundColor: doc['isActive'] ?? false ? Colors.green : Colors.grey,
                          radius: 8,
                        ),
                      );
                    } else if (userProfileSnapshot.hasError) {
                      return ListTile(
                        title: Text('Error loading name'),
                        subtitle: Text(doc['guardUID']),
                        trailing: CircleAvatar(
                          backgroundColor: doc['isActive'] ?? false ? Colors.green : Colors.grey,
                          radius: 8,
                        ),
                      );
                    } else {
                      final userProfileData = userProfileSnapshot.data!.data() as Map<String, dynamic>?;
                      final guardName = userProfileData != null ? userProfileData['name'] : 'Unknown';
                      return ListTile(
                        title: Text(guardName),
                        subtitle: Text(doc['guardUID']),
                        trailing: CircleAvatar(
                          backgroundColor: doc['isActive'] ?? false ? Colors.green : Colors.grey,
                          radius: 8,
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        }
      },
    );
  }

}
