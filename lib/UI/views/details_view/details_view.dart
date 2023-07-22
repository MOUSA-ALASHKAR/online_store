import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:online_store/UI/shared/utils.dart';
import 'package:online_store/UI/views/details_view/datails_controller.dart';
import 'package:online_store/UI/views/main_view/cart_view/cart_view.dart';
import 'package:online_store/core/data/models/apis/products_model.dart';


class DetailsView extends StatefulWidget {
  const DetailsView({Key? key, required this.model}) : super(key: key);
  final ProductsModel model;

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {

  late DetailsController controller;
  @override
  void initState() {
    controller = Get.put(DetailsController(widget.model));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth(50) , vertical: screenWidth(50)),
                      child: Column(
                        children: [

                          Padding(
                            padding: EdgeInsets.all(screenWidth(40)),
                            child: Text(widget.model.title ?? '' , style: TextStyle(fontSize: screenWidth(20)),),
                          ),

                          Container(
                            height: screenWidth(1.2),
                            child: CachedNetworkImage(
                              imageUrl: '${widget.model.image}',
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                              fit: BoxFit.contain,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth(50) , vertical: screenWidth(30)),
                            child: Row(
                              children: [
                                Text('Description: ' , style: TextStyle(color: Color.fromRGBO(69, 95, 185, 1) , fontSize: screenWidth(20)),),
                                Spacer(),
                                RatingBar.builder(
                                  updateOnDrag: true,
                                  itemSize: screenWidth(25),
                                  initialRating: widget.model.rating!.rate!.toDouble(),
                                  minRating: 1,
                                  ignoreGestures: true,
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
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth(50) , vertical: screenWidth(40)),
                            child: Text(widget.model.description ?? '' , style: TextStyle(fontSize: screenWidth(25)),),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth(50) , vertical: screenWidth(40)),
                            child: Row(
                              children: [
                                Text('Category: ' , style: TextStyle(color: Color.fromRGBO(69, 95, 185, 1)),),
                                Text(widget.model.category.toString()),
                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth(50)),
                            child: Row(
                              children: [
                                Text('Price: ' , style: TextStyle(color: Color.fromRGBO(69, 95, 185, 1)),),
                                Text(widget.model.price.toString()),
                              ],
                            ),
                          ),
                          SizedBox(height: screenWidth(3),),
                        ],

                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Obx((){
                  return Container(
                    width: double.infinity,
                    height: screenWidth(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0,1),
                              blurRadius: 5
                          )
                        ]
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: ()
                          {
                            controller.addToCart();
                            Get.to(() => CartView());
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: screenWidth(30)),
                            child: Container(
                              width: screenWidth(3.5),
                              height: screenWidth(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color.fromRGBO(69, 95, 185, 1)
                              ),
                              child: Center(child: Text('add to cart' , style: TextStyle(fontSize: screenWidth(20),color: Colors.white))),
                            ),
                          ),
                        ),

                        Spacer(),

                        InkWell(
                          onTap: controller.count.value == 1
                              ? null
                              : (){controller.changeCount(false);},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenWidth(10),
                              height: screenWidth(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color.fromRGBO(69, 95, 185, 1)
                              ),
                              child: Center(child: Text('-' , style: TextStyle(fontSize: screenWidth(20),color: Colors.white))),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(controller.count.value.toString() , style: TextStyle(fontSize: screenWidth(20) , fontWeight: FontWeight.bold),),
                        ),

                        InkWell(
                          onTap: ()
                          {
                            controller.changeCount(true);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: screenWidth(20)),
                            child: Container(
                              width: screenWidth(10),
                              height: screenWidth(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color.fromRGBO(69, 95, 185, 1)
                              ),
                              child: Center(child: Text('+' , style: TextStyle(fontSize: screenWidth(20),color: Colors.white))),
                            ),
                          ),
                        ),

                      ],
                    ),
                  );
                }
                ),
              ),
            ],
          ),
        )
    );
  }
}
