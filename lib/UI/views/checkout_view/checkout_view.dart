import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/UI/shared/custom_widgets/button_widget.dart';
import 'package:online_store/UI/shared/utils.dart';
import 'package:online_store/UI/views/main_view/main_view.dart';
import 'checkout_controller.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {

  CheckoutController controller = Get.put(CheckoutController());

  @override
  void initState() {
    storage.setOrderPlaced(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      //  WillPopScope(
      //     child:
      SafeArea(
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth(20) , vertical: screenWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('Your order placed\n successfully' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: screenWidth(12)),),
                  Row(
                    children: [
                      Text('Order NO:    ' , style: TextStyle(color: Color.fromRGBO(69, 95, 185, 1) , fontSize: screenWidth(22)),),
                      Text('#1234510' , style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  
                  SizedBox(height: screenWidth(50)),

                  Row(
                    children: [
                      Text('Item Count:   ' , style: TextStyle(color: Color.fromRGBO(69, 95, 185, 1) , fontSize: screenWidth(22)),),
                      Text(cartService.cartCount.toString() , style: TextStyle(fontWeight: FontWeight.bold , fontSize: screenWidth(22)),),
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
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenWidth(20)),
                    child: ButtonWidget(
                        text: 'Continue Shopping',
                        onPressed: ()
                        {
                          cartService.clearCart();
                          Get.to(MainView());
                        }
                    ),
                  )

                ],
              ),
            ),
          ));
    // onWillPop: () async {
    //   cartService.clearCart();
    //   Get.off(MainView());

    //   return false;
    // });
  }
}
