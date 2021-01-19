import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/shared/app_colors.dart';
import 'package:Crypto_wallet/theme/light_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Crypto_wallet/shared/logout_alert_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';


class UsersSettingsScreen extends StatefulWidget {
  @override
  _UsersSettingsScreenState createState() => _UsersSettingsScreenState();
}

class _UsersSettingsScreenState extends State<UsersSettingsScreen> {
  dynamic _auth = AuthService();
  var user = FirebaseAuth.instance.currentUser;
  bool userIsNull = false;
  @override
  void initState() {
    if (user == null) {
      setState(() {
        userIsNull = true;
      });
    } else {
      setState(() {
        userIsNull = false;
      });
    }
    super.initState();
  }
  void _showDialogueBox({yesPressed}) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
              // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: LogoutAlertDialog(yesPressed: yesPressed,));
        },
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlueStart,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: yellowEndWallet,
                gradient: LinearGradient(
                  // yellowStartWallet, yellowEndWallet
                  colors: [
                    // LightColor.navyBlue2,
                    // Colors.green,
                    blueMain,
                    blueMain,
                    // LightColor.navyBlue2,
                    // Colors.lightGreen,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment(0.6, 0.3),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 55),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.pop(context);
                            //   },
                            //   child: SvgPicture.asset('assets/images/back.svg'),
                            // ),
                            Text(
                              'Users Settings',
                              // widget.currency['name'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            // SvgPicture.asset('assets/images/back.svg',
                            //     color: Colors.transparent),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .12,
                    left: -5,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .16,
                    left: MediaQuery.of(context).size.width * 0.05,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .05,
                    right: 30,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .09,
                    right: -15,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                Navigator.pushNamed(context, 'user_profile');
              },
              child: Container(
                height: 85,
                child: Card(
                  elevation: 0,
                  // decoration: ,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  // height: 80,
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ListTile(
                            leading: Container(
                              height: 30,
                              width: 30,
                              // color: LightColor.navyBlue2,
                              child: ImageIcon(
                                AssetImage(
                                  'assets/images/profile.png',
                                ),
                                color: LightColor.navyBlue2,
                              ),
                            ),

                            //  Image.asset(
                            //   'assets/images/34.png',
                            //   height: 30,
                            //   width: 30,
                            // ),
                            title: Text('User Profile'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () async {
                Navigator.pushNamed(context, 'pin_code_screen');
              },
              child: Container(
                height: 85,
                child: Card(
                  elevation: 0,
                  // decoration: ,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  // height: 80,
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ListTile(
                            leading: Container(
                              height: 30,
                              width: 30,
                              child: ImageIcon(
                                AssetImage('assets/images/conversation.png'),
                                color: LightColor.navyBlue2,
                              ),
                            ),

                            //  Image.asset(
                            //   'assets/images/34.png',
                            //   height: 30,
                            //   width: 30,
                            // ),
                            title: Text('FAQ'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Visibility(
              visible: userIsNull ? false : true,
              child: InkWell(
                onTap: ()  {
                 _showDialogueBox(yesPressed: ()async{
                    Map res = await _auth.signOut();

              if (res['status']) {
                Fluttertoast.showToast(
                    msg: 'You are logged out',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white);
                setState(() {
                  userIsNull = true;
                });
                Navigator.of(context).pop();
              } else {
                Fluttertoast.showToast(
                    msg: res['message'].toString(),
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white);
                setState(() {
                  userIsNull = false;
                });
                Navigator.of(context).pop();
              }
                 });
                },
                child: Container(
                  height: 85,
                  child: Card(
                    elevation: 0,
                    // decoration: ,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    // height: 80,
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ListTile(
                              leading: Container(
                                height: 30,
                                width: 30,
                                child: ImageIcon(
                                  AssetImage('assets/images/undo(1).png'),
                                  color: LightColor.navyBlue2,
                                ),
                              ),

                              //  Image.asset(
                              //   'assets/images/34.png',
                              //   height: 30,
                              //   width: 30,
                              // ),
                              title: Text('Logout'),
                            ),
                          ),
                          // AlertDialog(
                            
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
