import 'package:flutter/material.dart';
import 'package:yemeksiparis/models/Cart.dart';
import 'package:yemeksiparis/models/Dish.dart';
import 'package:yemeksiparis/widgets/msgToast.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../widgets/CatalogImage.dart';

class CatalogItemUser extends StatelessWidget {
  final Dish dish;

  const CatalogItemUser({
    Key? key,
    required this.dish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartModel _cart = CartModel();

    return VxBox(
      child: Row(
        children: [
          Hero(
            tag: Key(dish.dish_id.toString()),
            child: CatalogImage(
              image: "https://static.toiimg.com/thumb/53110049.cms?width=1200&height=900",
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dish.dish_name.text.lg.color(Color(0xff403b58)).bold.make(),
                dish.dish_type.text
                    .textStyle(context.captionStyle)
                    .color(Color(0xff403b58))
                    .make(),
                10.heightBox,
                ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  buttonPadding: EdgeInsets.zero,
                  children: [
                    "\₹${dish.dish_price}".text.xl.bold.make(),
                    AddToCart(dish: dish, cart: _cart),
                  ],
                ).pOnly(right: 16.0)
              ],
            ),
          )
        ],
      ),
    ).color(Colors.white).roundedLg.square(140).make().py8();
  }
}

class AddToCart extends StatelessWidget {
  final Dish dish;
  final CartModel cart;

  const AddToCart({
    Key? key,
    required this.dish,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final index = cart.cart.findItemIndexFromCart(dish.dish_id);
        if (index == null) {
          cart.addToCart(dish);
          msgToast('${dish.dish_name} added to the cart');
        } else {
          cart.addItemToCart(index);
          msgToast('${dish.dish_name} added to the cart');
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Vx.indigo500,
        ),
        shape: MaterialStateProperty.all(
          StadiumBorder(),
        ),
      ),
      child: "Add to Cart".text.make(),
    );
  }
}
