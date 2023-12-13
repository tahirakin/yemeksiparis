import 'package:flutter/material.dart';
import 'package:yemeksiparis/models/ApiError.dart';
import 'package:yemeksiparis/models/ApiRespose.dart';
import 'package:yemeksiparis/models/DishList.dart';
import 'package:yemeksiparis/services/RestServices.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DashboardLoader extends StatefulWidget {
  @override
  _DashboardLoaderState createState() => _DashboardLoaderState();
}

class _DashboardLoaderState extends State<DashboardLoader> {
  int args = 0; // args değişkeni başlangıçta bir değer almalıdır.

  @override
  void initState() {
    super.initState();
    getDishData();
  }

  void getDishData() async {
    RestServices restServices = RestServices();
    ApiResponse _apiResponse = await restServices.getDishes();
    print(_apiResponse.apiError);
    DishList? dishList;

    if (_apiResponse.apiError == null) {
      dishList = _apiResponse.data as DishList?;
    }

    if (args == 1) {
      Navigator.pushNamed(
        context,
        '/admindash',
        arguments: dishList,
      );
    } else {
      Navigator.pushNamed(
        context,
        '/dash',
        arguments: dishList,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // settings değişkeninin null kontrolü eklenmiştir.
    args = ModalRoute.of(context)?.settings?.arguments as int ?? 0;

    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
