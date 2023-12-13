import 'package:flutter/material.dart';
import 'package:yemeksiparis/Forms/DishAddForm.dart';
import 'package:yemeksiparis/models/ApiError.dart';
import 'package:yemeksiparis/models/ApiRespose.dart';
import 'package:yemeksiparis/models/DishList.dart';
import 'package:yemeksiparis/models/UserDetails.dart';
import 'package:yemeksiparis/services/UserServices.dart';
import 'package:yemeksiparis/views/Restaurant/AdminCatalogItem.dart';
import 'package:yemeksiparis/widgets/msgToast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    final DishList? args =
    ModalRoute.of(context)?.settings.arguments as DishList?;
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            _profileHandler(context);
          },
        ),
        title: Text("Swiggato - DashBoard"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: CatalogList(dishList: args),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DishAddForm()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void _profileHandler(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _userId = (prefs.getString("user_id") ?? "");
  if (_userId == "") {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home',
      ModalRoute.withName('/home'),
    );
    msgToast("invalid Login State!");
  } else {
    UserServices userServices = UserServices();
    ApiResponse _apiResponse = await userServices.details(_userId);
    if (_apiResponse.apiError == null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/profile',
        ModalRoute.withName('/profile'),
        arguments: (_apiResponse.data as UserDetails),
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        ModalRoute.withName('/home'),
      );
      msgToast("invalid Login State!");
    }
  }
}

class CatalogList extends StatelessWidget {
  final DishList? dishList;

  CatalogList({Key? key, required this.dishList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (dishList == null)
        ? "Nothing to show".text.make().centered()
        : ListView.builder(
      shrinkWrap: true,
      itemCount: dishList!.length,
      itemBuilder: (context, index) {
        return CatalogItemAdmin(dish: dishList!.getIndex(index));
      },
    );
  }
}
