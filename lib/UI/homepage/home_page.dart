import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:project_guard/UI/access_logs/access_logs.dart';
import 'package:project_guard/UI/generated_sos/generated_sos_list.dart';
import 'package:project_guard/constants/colors.dart';
import '../../chat/AllChat.dart';
import '../../chat/Chat.dart';
import '../../components/bottom_nav.dart';
import '../../components/drawer.dart';
import '../../services/signout_user.dart';
import '../AccessControl/access_control.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(
        onHomeTap: () {
          Navigator.pop(context);
          //Navigator.pushNamed(context, '/home');
        },
        onProfileTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/profile');
        },
        onSettingTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/activeList');
        },

        onAdminChatTap: () {
          Navigator.push(context,new MaterialPageRoute(builder: (context) => Chat( peerId: 'CJj1lkcicIXJ2WKIx71fM9nRiJU2'.toString(),type: 'staff',)));

        },
        onLogoutTap: signUserOut,
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            const SizedBox(
              height: 5,
            ),
            const Text(
              'DoorStep Guard',
              style: TextStyle(
                fontFamily: 'Montserrat Medium',
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topCenter,
              child: Column(
                children: [ //15

                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  // ROW # 1 ( ACCESS CONTROL & RESERVATIONS )
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 0.48,
                          color: Colors.white,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Container(
                                      height: size.height * 0.4,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade400,
                                            blurRadius: 13,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(9),
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: size.height * -0.03,
                                bottom: size.width * -0.08,
                                left: size.width * -0.05,
                                child: Image.asset(
                                  'assets/images/Scan.png',
                                  height: size.height * 0.28,
                                ),
                              ),
                              Positioned(
                                top: size.height * 0.05,
                                right: size.width * 0.08,
                                child: const Text(
                                  'Access Control',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat Medium',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccessControl(),
                            ),
                          ),
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          height: size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 0.48,
                          color: Colors.white,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Container(
                                      height: size.height * 0.4,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade400,
                                            blurRadius: 13,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: size.height * -0.001,
                                bottom: size.width * -0.001,
                                width: size.height * 0.32,
                                child: Image.asset(
                                  'assets/images/accessLog.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: size.height * 0.05,
                                left: size.width * 0.16,
                                child: Center(
                                  child: Text(
                                    'Chat',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat Medium',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyChats(),
                            ),
                          ),
                        },
                      ),
                    ],
                  ),
                  // ROW # 2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 0.48,
                          color: Colors.white,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Container(
                                      height: size.height * 0.4,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade400,
                                            blurRadius: 13,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(9),
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: size.height * -0.03,
                                bottom: size.width * -0.08,
                                left: size.width * -0.003,
                                child: Image.asset(
                                  'assets/images/sos.png',
                                  height: size.height * 0.28,
                                ),
                              ),
                              Positioned(
                                top: size.height * 0.05,
                                right: size.width * 0.08,
                                child: const Text(
                                  'Generated SOS',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat Medium',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SosListPage(),
                            ),
                          ),
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          height: size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 0.48,
                          color: Colors.white,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Container(
                                      height: size.height * 0.4,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade400,
                                            blurRadius: 13,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: size.height * -0.002,
                                bottom: size.width * -0.01 + 22, // Adjusted by subtracting 5 pixels
                                width: size.height * 0.22,
                                child: Image.asset(
                                  'assets/images/accesslogs.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: size.height * 0.05,
                                left: size.width * 0.11,
                                child: Center(
                                  child: const Text(
                                    'Access Log',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat Medium',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccessLog(),
                            ),
                          ),
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),



    );
  }
}
