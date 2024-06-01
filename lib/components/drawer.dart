import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_guard/components/my_list_tile.dart';
import 'package:project_guard/constants/colors.dart';

import '../constants/utils.dart';

class MyDrawer extends StatefulWidget {

  final void Function()? onHomeTap;
  final void Function()? onProfileTap;
  final void Function()? onSettingTap;
  final void Function()? onLogoutTap;
  final void Function()? onAdminChatTap;

  const MyDrawer({Key? key, required this.onProfileTap, required this.onSettingTap, required this.onLogoutTap, required this.onHomeTap, required this.onAdminChatTap}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor: kAccentColor2,
      child: Column(
        children: [
         SizedBox(height: 50,),


         ///home list tile
          MyListTile(
            icon: Icons.home,
            text: 'H O M E',
            onTap: widget.onHomeTap,
          ),
          ///profile list tile
          /*MyListTile(
              icon: Icons.person,
              text: 'P R O F I L E' ,
              onTap: widget.onProfileTap
          ),*/

          ///settings list tile
          MyListTile(
              icon: Icons.settings,
              text: 'A C T I V I T Y' ,
              onTap: widget.onSettingTap,
          ),

          MyListTile(
            icon: Icons.chat_outlined,
            text: 'Admin Chat',
            onTap: widget.onAdminChatTap,
          ),

          ///logout list tile
          MyListTile(
            icon: Icons.logout,
            text: 'L O G O U T',
            onTap: widget.onLogoutTap,
          ),


        ],
      ),
    );
  }
}
