import 'package:get/get.dart';
import 'package:online_store/UI/shared/custom_widgets/custom_toast.dart';
import 'package:online_store/core/data/models/apis/products_model.dart';
import 'package:online_store/core/data/network/endpoints/categories_endpoint.dart';
import 'package:online_store/core/data/repositories/category_repository.dart';
import 'package:online_store/core/data/repositories/get_by_type_repository.dart';
import 'package:online_store/core/data/repositories/products_repository.dart';
import 'package:online_store/core/enums/Operation_type.dart';
import 'package:online_store/core/enums/message_type.dart';
import 'package:online_store/core/enums/request_status.dart';
import 'package:online_store/core/services/base_controller.dart';


class HomePageController extends BaseController {

  RxList<ProductsModel> productList = <ProductsModel>[].obs;
  RxList<ProductsModel> electronicsList = <ProductsModel>[].obs;
  RxList<ProductsModel> jeweleryList = <ProductsModel>[].obs;
  RxList<ProductsModel> menList = <ProductsModel>[].obs;
  RxList<ProductsModel> womenList = <ProductsModel>[].obs;
  RxList<String> items = <String>[].obs;

  RxList<ProductsModel> categoryList = <ProductsModel>[].obs;

  List<String> type = ["All", "electronics", "jewelery" , "men" , "woman"];
  RxList<bool> selected = [false, true, false, false, false].obs;


  RxInt selectedIndex = 0.obs;

  RxBool isSelected= false.obs;

  bool get isProductsLoading =>
      requestStatus.value == RequestStatus.LOADING &&
          listType.contains(OperationType.PRODUCTS);

  bool get isCategoriesLoading =>
      requestStatus.value == RequestStatus.LOADING &&
          listType.contains(OperationType.CATEGORIES);


  @override
  void onInit() {
    getAllProducts();
    getCategories();
    getElectronics();
    getJewelery();
    getMen();
    getWomen();
    super.onInit();
  }

  void changeCategory({required String category}) {
    categoryList.clear();

    getCategory(cateegory: category);
  }

  void getCategory({required String cateegory}) {
    if (cateegory == "electronics") {getElectronics();}
    else if (cateegory == "jewelery") {getJewelery();}
    else if (cateegory == "men") {getMen();}
    else if (cateegory == "woman") {getWomen();}
    else
      getAllProducts();
  }

  void getAllProducts() {
    runLoadingFutureFunction(
        type: OperationType.PRODUCTS,
        function: ProductsRepository().getAll().then((value) {
          value.fold((l) {
            CustomToast.showMessage(
                message: l, messageType: MessageType.REJECTED);
          }, (r) {
            productList.addAll(r);
          });
        }));
  }



  void getCategories() async {
    runLoadingFutureFunction(
        type: OperationType.CATEGORIES,
        function: CategoryRepository().getAll().then((value) {
          value.fold((l) {
            CustomToast.showMessage(
                message: l, messageType: MessageType.REJECTED);
          }, (r) {
            items.addAll(r);
          });
        }));
  }


  void getElectronics() {
    runLoadingFutureFunction(
        type: OperationType.PRODUCTS,
        function: TypeRepository().getAll(CategoriesEndpoint.getElectronics).then((value) {
          value.fold((l) {
            CustomToast.showMessage(
                message: l, messageType: MessageType.REJECTED);
          }, (r) {
            electronicsList.addAll(r);
          });
        }));
  }

  void getJewelery() {
    runLoadingFutureFunction(
        type: OperationType.PRODUCTS,
        function: TypeRepository().getAll(CategoriesEndpoint.getJewelery).then((value) {
          value.fold((l) {
            CustomToast.showMessage(
                message: l, messageType: MessageType.REJECTED);
          }, (r) {
            jeweleryList.addAll(r);
          });
        }));
  }

  void getMen() {
    runLoadingFutureFunction(
        type: OperationType.PRODUCTS,
        function: TypeRepository().getAll(CategoriesEndpoint.getMenClothing).then((value) {
          value.fold((l) {
            CustomToast.showMessage(
                message: l, messageType: MessageType.REJECTED);
          }, (r) {
            menList.addAll(r);
          });
        }));
  }

  void getWomen() {
    runLoadingFutureFunction(
        type: OperationType.PRODUCTS,
        function: TypeRepository().getAll(CategoriesEndpoint.getWomenClothing).then((value) {
          value.fold((l) {
            CustomToast.showMessage(
                message: l, messageType: MessageType.REJECTED);
          }, (r) {
            womenList.addAll(r);
          });
        }));
  }

}