import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:online_store/UI/shared/utils.dart';
import 'package:online_store/UI/views/details_view/details_view.dart';
import 'package:online_store/UI/views/main_view/products_view/product_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {

  ProductController controller = Get.put(ProductController());

  TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth(50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth(50) , vertical: screenWidth(50)),
                child: Text('All Products' , style: TextStyle(fontSize: screenWidth(10)),),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: screenWidth(50)),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: searchController,
                  onChanged: (value) => controller.filterProduct(value),
                  decoration: InputDecoration(
                    hintText: 'search...',
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(vertical: screenWidth(30)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.black)
                    )
                  ),

                ),
              ),

              Obx((){
                return controller.isProductsLoading
                    ? SpinKitCircle(color: Color.fromRGBO(69, 95, 185, 1),) : controller.productList.isEmpty
                    ? Text('No Products')
                    : Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.8),
                      itemCount: controller.foundProducts.value.length,
                      itemBuilder: (BuildContext context , int index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: InkWell(
                            onTap: (){Get.to(DetailsView(model: controller.productList[index]));},
                            child: Container(
                              // width: screenWidth(3.8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black)
                              ),
                              child: Column(
                                children: [

                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: screenWidth(3.2),
                                      height: screenWidth(18),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(20) , bottomLeft: Radius.circular(20)),
                                          color: Colors.grey
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: RatingBar.builder(
                                          updateOnDrag: true,
                                          itemSize: screenWidth(30),
                                          initialRating: controller.foundProducts.value[index]['rating']['rate'].toDouble(),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsetsDirectional.symmetric(horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Color.fromRGBO(69, 95, 185, 1),
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    height: screenWidth(2.8),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: CachedNetworkImage(
                                        imageUrl: controller.foundProducts.value[index]['image'].toString(),
                                        placeholder: (context, url) => CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Text(controller.foundProducts.value[index]['title'] , textAlign: TextAlign.center , maxLines: 1,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Price: ' , style: TextStyle(color:Color.fromRGBO(69, 95, 185, 1)),),
                                      Text(controller.foundProducts.value[index]['price'].toString() , textAlign: TextAlign.center , maxLines: 1,),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                );
              }),
              SizedBox(height: screenWidth(7.5)),
            ],
          ),
        ),
      ),
    );

  }

}
