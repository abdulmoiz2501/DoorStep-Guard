import 'dart:typed_data';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_guard/constants/colors.dart';
import '../../components/progress_dialog.dart';
import '../../constants/utils.dart';
import '../../services/user_model.dart';

class FillProfilePage extends StatefulWidget {
  const FillProfilePage({super.key});

  @override
  State<FillProfilePage> createState() => _FillProfilePageState();
}

class _FillProfilePageState extends State<FillProfilePage> {
  final formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cnicController = TextEditingController();

  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  Future<void> saveProfile() async {

    ProgressDialogWidget.show(context, "Please wait...");

    String resp = await StoreData().saveUserProfileData(
      name: _fullNameController.text,
      phone: _phoneController.text,
      cnic: _cnicController.text,
      file: _image!,

    ).whenComplete(() {
         tokenSetNew(FirebaseAuth.instance.currentUser!.uid.toString());
         ProgressDialogWidget.hide(context);

    }
    );

  }


  tokenSetNew(String userId){

    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.subscribeToTopic('user');
    _firebaseMessaging.getToken().then((value) {

      CollectionReference users = FirebaseFirestore.instance.collection('userProfile');

      users
          .doc(userId)
          .update({
        'token': value.toString()
      }).then((value) {
        Navigator.pushNamed(context, '/home');

      })
          .catchError((error) => print("Failed to update user: $error"));


    }).onError((error, stackTrace)
    {
      print(error);
      /// add snackbar
      //CustomAlertDialogs.showFailuresDailog(context,error.toString());

    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: kScaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: Text('Fill Details'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.08,
                      backgroundImage: MemoryImage(_image!),
                    )
                        : CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.1,
                      backgroundImage:
                      AssetImage('assets/images/avatar.png'),
                    ),
                    Positioned(
                      child: IconButton(
                        onPressed: selectImage,
                        icon: Icon(Icons.camera_alt),
                      ),
                      bottom: 0,
                      right: 0,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            customTextField("Full Name", _fullNameController, size),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            customTextField("Phone Number", _phoneController, size),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            customTextField("cnic", _cnicController, size),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),



            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              child: Text('Here we will add a dropdown society list later', style: TextStyle(fontSize: 15),),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              child: Text('Here we will add a dropdown building list later', style: TextStyle(fontSize: 15),),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              child: Text('Here we will add a form field to enter house no/flat no', style: TextStyle(fontSize: 15),),
            ),

            // ElevatedButton(
            //   onPressed: saveProfile,
            //   child: Text('Save Changes'),
            // ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try{
              if(formKey.currentState!.validate()){
                print("save Profile button ");
                await saveProfile();
                final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Success!',
                    message:
                    'Details saved successfully!',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.success,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }
              }


            catch(err){
              ProgressDialogWidget.hide(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Error"),
                    content: Text("An error occurred: $err"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                },
              );
              print(err);
            }

          },
          child: Icon(Icons.save, color: Colors.white,),
          backgroundColor: kAccentColor2,

        )
      ),
    );
  }
  Widget customTextField(String title, var controller, Size size,
      {bool readOnly = false}) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '         $title',
            style: TextStyle(
              fontFamily: 'Circular',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.005,
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.065),
            child: TextFormField(
                readOnly: readOnly,
                obscureText: false,
                controller: controller,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kWhite,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  fillColor: kTextBoxColor,
                  filled: true,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is Empty';
                  }
                  return null;
                }),
          ),
        ),
      ],
    );
  }
}
