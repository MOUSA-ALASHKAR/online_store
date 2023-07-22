import 'package:get/get.dart';
import 'package:online_store/UI/shared/utils.dart';
import 'package:online_store/UI/views/main_view/cart_view/cart_view.dart';
import 'package:online_store/core/data/models/apis/products_model.dart';
import 'package:online_store/core/services/base_controller.dart';

class DetailsController extends BaseController {

  DetailsController(ProductsModel productModel) { model = productModel; }



  ProductsModel model = ProductsModel();
  RxInt count = 1.obs;

  void changeCount(bool increase) {
    if (increase)
      count++;
    else {
      if (count > 1) count--;
    }
  }

  double calcTotal() {
    return (count.value * model.price!).toDouble();
  }

  void addToCart() {
    cartService.addToCart(
        model: model,
        count: count.value,
        afterAdd: () {
          Get.to(() => CartView());
        });
  }

}