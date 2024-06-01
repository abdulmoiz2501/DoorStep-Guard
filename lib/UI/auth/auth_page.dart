import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_guard/UI/auth/filling_profile_details.dart';
import 'package:project_guard/services/login_or_register.dart';

import '../homepage/home_page.dart';
import 'login_page.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            print('snapshot has data');
            // Check if user's profile document exists
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('userProfile')
                  .doc(snapshot.data!.uid)
                  .get(),
              builder: (context, profileSnapshot) {
                if (profileSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (profileSnapshot.hasData && profileSnapshot.data!.exists) {
                  // User's profile document exists, check if profile details are filled
                  if (profileSnapshot.data!.get('profileLink') != null) {
                    // Profile details are filled, navigate to dashboard
                    return HomePage();
                  } else {
                    // Profile details are not filled, navigate to profile filling page
                    //return FillProfilePage();
                    return HomePage();
                  }
                } else if (profileSnapshot.hasError) {
                  print('Error fetching profile details: ${profileSnapshot.error}');
                  return Scaffold(
                    body: Center(
                      child: Text('Something went wrong'),
                    ),
                  );
                } else {
                  // User's profile document doesn't exist, navigate to profile filling page
                  //return FillProfilePage();
                  return HomePage();
                }
              },
            );
          } else if (snapshot.hasError) {
            print('snapshot has error');
            return Scaffold(
              body: Center(
                child: Text('Something went wrong'),
              ),
            );
          } else {
            return LoginOrRegisterPage();
          }
        },
      ),
/*      body: StreamBuilder<User?>(
        ///This will constantly check if the user is logged in or not
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            print('snapshot has data');
            return FillProfilePage();
          }
          else if(snapshot.hasError)
            {
              print('snapshot has error');
              return  Scaffold(
                body: Center(
                  child: Text('Something went wrong'),
                ),
              );
            }
          //Is the user NOT logged in
          else{
            return LoginOrRegisterPage();
          }
        },

      ),*/
    );
  }
}
