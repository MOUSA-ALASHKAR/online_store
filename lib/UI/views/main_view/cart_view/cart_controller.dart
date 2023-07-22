import 'package:get/get.dart';
import 'package:online_store/UI/shared/utils.dart';
import 'package:online_store/UI/views/checkout_view/checkout_view.dart';
import 'package:online_store/core/data/models/apis/cart_model.dart';
import 'package:online_store/core/services/base_controller.dart';

class CartController extends BaseController {
  List<CartModel> get cartList => cartService.cartList;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void removeFromCart(CartModel model) {
    cartService.removeFromCart(
      model: model,
    );
  }

  void changeCount(bool increase, CartModel model) {
    cartService.changeCount(
      incress: increase,
      model: model,
    );
  }

  void checkout() {
    runFullLoadingFutureFunction(
        function: Future.delayed(Duration(seconds: 2)).then((value) {
          Get.off(CheckoutView());
        }));
  }
}