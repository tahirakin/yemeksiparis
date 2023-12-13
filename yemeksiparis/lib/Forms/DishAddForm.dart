import 'package:flutter/material.dart';
import 'package:yemeksiparis/animation/FadeAnimation.dart';
import 'package:yemeksiparis/models/ApiError.dart';
import 'package:yemeksiparis/models/ApiRespose.dart';
import 'package:yemeksiparis/services/RestServices.dart';
import 'package:yemeksiparis/services/UserServices.dart';
import 'package:yemeksiparis/views/Restaurant/AdminDashboard.dart';
import 'package:yemeksiparis/widgets/msgToast.dart';

class DishAddForm extends StatefulWidget {
  @override
  _DishAddFormState createState() => _DishAddFormState();
}

class _DishAddFormState extends State<DishAddForm> {
  TextEditingController DishName = new TextEditingController();
  TextEditingController DishPrice = new TextEditingController();
  TextEditingController RestaurantID = new TextEditingController();
  String valueChoose = "starter"; // Initialize with a default value
  List listItem = ["starter", "main course", "desserts"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff409439),
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        title: Center(child: Text("ADD DISH")),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              child: TextField(
                controller: DishName,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffEEEEEE),
                  labelText: "Dish name",
                ),
                onChanged: (value) {},
              ),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
            ),
            Card(
              child: TextField(
                controller: DishPrice,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffEEEEEE),
                  labelText: "Dish Price",
                ),
                onChanged: (value) {},
              ),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
            ),
            Card(
              child: DropdownButton(
                hint: Text("Select Dish Type"),
                dropdownColor: Colors.white,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36,
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(color: Colors.black, fontSize: 15),
                value: valueChoose,
                onChanged: (newValue) {
                  setState(() {
                    valueChoose = newValue.toString(); // Convert newValue to String
                  });
                },
                items: listItem.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
            ),
            Card(
              child: TextField(
                controller: RestaurantID,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffEEEEEE),
                  labelText: "Restaurant ID",
                ),
                onChanged: (value) {},
              ),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
            ),
            FadeAnimation(
              1.2,
              Container(
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/food.png'),
                        fit: BoxFit.fitHeight)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          handleDishAdd(context);
        },
        child: Icon(Icons.save),
      ),
    );
  }

  void handleDishAdd(BuildContext context) async {
    const int isadmin = 1;
    RestServices restServices = new RestServices();
    ApiResponse _apiResponse = await restServices.addDish(
      DishName.text,
      int.parse(DishPrice.text),
      valueChoose,
      RestaurantID.text,
    );

    if ((_apiResponse.apiError as ApiError) == null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/loadDash',
        ModalRoute.withName('/loadDash'),
        arguments: isadmin,
      );
    } else {
      msgToast("DishAdd Failed!");
    }
  }
}
