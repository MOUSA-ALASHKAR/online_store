import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:online_store/UI/shared/custom_widgets/button_widget.dart';
import 'package:online_store/UI/shared/utils.dart';
import 'package:online_store/UI/views/main_view/cart_view/cart_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_store/UI/views/main_view/main_view.dart';
import 'package:online_store/core/services/cart_service.dart';

class CartView extends StatefulWidget {
  CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

  CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Center(
              child: Text('Cart' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: screenWidth(16)),)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Obx(() {
          return CartService().getCartCount() == 0 ?
          Container(
            child: Column(
              children: [
                Center(child: Lottie.asset('images/cart.json')),
                SizedBox(height: screenWidth(30),),
                Text('The is Empty' , style: TextStyle(fontSize: screenWidth(18)),),
                SizedBox(height: screenWidth(30),),
                InkWell(
                    onTap: (){
                      Get.offAll(MainView());
                    },
                    child: Text(
                      'Click here to go shopping' ,
                      style: TextStyle(fontSize: screenWidth(25),fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ) :
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenWidth(50),),

                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: controller.cartList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [

                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            width: screenWidth(1),
                            height: screenWidth(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: ()
                            {
                              controller.removeFromCart(controller.cartList[index]);
                            },
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 5 , top: 5),
                                    child: SvgPicture.asset('images/delete.svg' , color: Colors.red,),
                                  ),
                              ),
                          ),
                        ),

                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 25,left: 5,right: 5),
                              child: Container(
                                width: screenWidth(4),
                                height: screenWidth(4),
                                child: Padding(
                                  padding: EdgeInsets.only(left: screenWidth(60)),
                                  child: CachedNetworkImage(
                                    imageUrl: controller.cartList[index].mealModel!.image.toString(),
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    controller.cartList[index].mealModel?.title!.substring(0,15) ?? '',
                                    style: TextStyle(fontSize: screenWidth(30)),
                                ),
                                SizedBox(height: screenWidth(50)),
                                Row(
                                  children: [
                                    Text('Price: ' , style: TextStyle(color: Color.fromRGBO(69, 95, 185, 1) , fontSize: screenWidth(25)),),
                                    Text(
                                      controller.cartList[index].mealModel?.price.toString() ?? '',
                                      style: TextStyle(fontSize: screenWidth(30)),overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenWidth(200)),
                                Row(
                                  children: [
                                    Text('Total: ' , style: TextStyle(color: Color.fromRGBO(69, 95, 185, 1) , fontSize: screenWidth(25)),),
                                    Text(
                                      controller.cartList[index].total.toString(),
                                      style: TextStyle(fontSize: screenWidth(30)),overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: ()
                                  {
                                    controller.changeCount(false, controller.cartList[index]);
                                  },
                                  child: Container(
                                    width: screenWidth(15),
                                    height: screenWidth(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color.fromRGBO(69, 95, 185, 1)
                                    ),
                                    child: Center(child: Text('-' , style: TextStyle(color: Colors.white),)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    controller.cartList[index].count.toString(),
                                    style: TextStyle(fontSize: screenWidth(20)),
                                  ),
                                ),
                                InkWell(
                                  onTap: ()
                                  {
                                    controller.changeCount(true, controller.cartList[index]);
                                  },
                                  child: Container(
                                    width: screenWidth(15),
                                    height: screenWidth(15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Color.fromRGBO(69, 95, 185, 1)
                                    ),
                                    child: Center(child: Text('+' , style: TextStyle(color: Colors.white),)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    );
                  },
                ),

                Padding(
                  padding: EdgeInsetsDirectional.only(top: screenWidth(30) , start: screenWidth(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: screenWidth(30)),
                        child: Container(
                          width: screenWidth(1.1),
                          height: screenWidth(150),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(69, 95, 185, 1)
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text('Sub Total : ', style: TextStyle(color: Color.fromRGBO(69, 95, 185, 1) , fontWeight: FontWeight.bold , fontSize: screenWidth(20)),),
                          Spacer(),
                          Text('${cartService.subTotal.value.toStringAsFixed(2)}'+'  SP', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold , fontSize: screenWidth(20)),),
                          SizedBox(width: screenWidth(20)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: screenWidth(80) , horizontal: screenWidth(20)),
                        child: Divider(color: Colors.blue.withOpacity(0.3),thickness: screenWidth(150),),
                      ),
                      Row
                        (
                        children: [
                          Text('Tax : ' , style: TextStyle(color: Color.fromRGBO(69, 95, 185, 1) , fontWeight: FontWeight.bold , fontSize: screenWidth(20))),
                          Spacer(),
                          Text('${cartService.tax.value.toStringAsFixed(2)}'+'  SP' , style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold , fontSize: screenWidth(20))),
                          SizedBox(width: screenWidth(20)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: screenWidth(80) , horizontal: screenWidth(20)),
                        child: Divider(color: Colors.blue.withOpacity(0.3),thickness: screenWidth(150),),
                      ),
                      Row(
                        children: [
                          Text('Delivery : ' , style: TextStyle(color: Color.fromRGBO(69, 95, 185, 1) , fontWeight: FontWeight.bold , fontSize: screenWidth(20))),
                          Spacer(),
                          Text('${cartService.delivery.value.toStringAsFixed(2)}'+'  SP' , style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold , fontSize: screenWidth(20))),
                          SizedBox(width: screenWidth(20)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: screenWidth(80) , horizontal: screenWidth(20)),
                        child: Divider(color: Colors.blue.withOpacity(0.3),thickness: screenWidth(150),),
                      ),
                      Row(
                        children: [
                          Text('Total : ' , style: TextStyle(color: Colors.red , fontWeight: FontWeight.bold , fontSize: screenWidth(20))),
                          Spacer(),
                          Text('${cartService.total.value.toStringAsFixed(2)}'+'  SP' , style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold , fontSize: screenWidth(20))),
                          SizedBox(width: screenWidth(20)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: screenWidth(30)),
                        child: Container(
                          width: screenWidth(1.1),
                          height: screenWidth(150),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(69, 95, 185, 1)
                          ),
                        ),
                      ),
                      // Spacer(),

                    ],
                  ),
                ),
                SizedBox(height: screenWidth(8)),
                ButtonWidget(
                  text: 'Placed Order',
                  onPressed: ()
                  {
                    if(cartService.cartCount != 0) controller.checkout();
                  },
                ),
                SizedBox(height: screenWidth(25)),

                InkWell(
                  onTap: (){
                    cartService.clearCart();
                  },
                    child: Text('Empty Cart' , style: TextStyle(color: Colors.red , fontSize: screenWidth(30) , decoration: TextDecoration.underline,),)
                ),
                SizedBox(height: screenWidth(5)),
              ],
            ),
          );
        }
        ),
      ),
    );
  }
}
