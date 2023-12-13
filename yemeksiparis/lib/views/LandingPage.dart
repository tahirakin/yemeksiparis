import 'package:flutter/material.dart';
import 'package:yemeksiparis/models/ApiError.dart';
import 'package:yemeksiparis/models/ApiRespose.dart';
import 'package:yemeksiparis/models/UserDetails.dart';
import 'package:yemeksiparis/services/UserServices.dart';
import 'package:yemeksiparis/widgets/msgToast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String _userId = "";

  @override
  void initState() {
    super.initState();
    // _loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserDetails?>(
        future: _getDetails(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError || snapshot.data == null) {
              print('snapshot.connectionState error');
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              final userDetails = snapshot.data!;
              return Stack(
                children: <Widget>[
                  ClipPath(
                    child: Container(color: Color(0xfffeb324)),
                    clipper: GetClipper(),
                  ),
                  Positioned(
                    width: 375.0,
                    top: MediaQuery.of(context).size.height / 3.5,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                              color: Color(0xfffeb324),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://image.flaticon.com/icons/png/512/219/219970.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(75.0)),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 7.2,
                                    color: Colors.black,
                                    spreadRadius: 0.2)
                              ]),
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          userDetails.user_name,
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          userDetails.user_email,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Container(
                          height: 40.0,
                          width: 250.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Color(0xfffeb324),
                            color: Color(0xfffeb324),
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/loadDash',
                                  ModalRoute.withName('/loadDash'),
                                  arguments: userDetails.isAdmin,
                                );
                              },
                              child: Center(
                                child: Text(
                                  'Continue',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Container(
                          height: 40.0,
                          width: 250.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Color(0xfffeb324),
                            color: Color(0xfffeb324),
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {
                                _logoutHandler(context);
                              },
                              child: Center(
                                child: Text(
                                  'Log Out',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<UserDetails?> _getDetails(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = (prefs.getString("user_id") ?? "");
    if (_userId == "") {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        ModalRoute.withName('/home'),
      );
      return null; // _userId boşsa null döndür
    } else {
      UserServices userServices = new UserServices();
      ApiResponse _apiResponse = await userServices.details(_userId);
      if ((_apiResponse.apiError as ApiError?) == null) {
        return _apiResponse.data as UserDetails;
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('user_id');
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          ModalRoute.withName('/home'),
        );
        msgToast("invalid Login State!");
        return null; // Hata durumu için null döndür
      }
    }
  }

  void _logoutHandler(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_id');
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home',
      ModalRoute.withName('/home'),
    );
    msgToast("Logged Out!");
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height / 2.0);
    path.lineTo(size.width + 480, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
