import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:online_store/UI/shared/custom_widgets/shimmer_widget.dart';
import 'package:online_store/UI/shared/utils.dart';
import 'package:online_store/UI/views/details_view/details_view.dart';
import 'home_page_controller.dart';


class HomePageView extends StatefulWidget {

  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {

  HomePageController controller = Get.put(HomePageController());


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
                  child: Text('Categories' , style: TextStyle(fontSize: screenWidth(10)),),
                ),

                Obx((){print(controller.selectedIndex.value);
                  return SizedBox(
                    height: screenWidth(6),
                    child: Obx(() {
                      return controller.isCategoriesLoading ? buildShimmer1() :
                      controller.productList.isEmpty
                          ? Text('No Categories') :
                      ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.items.length+1,
                          itemBuilder: (context,index) {
                            return index ==0 ?
                            InkWell(
                              onTap: (){
                                controller.selectedIndex.value = index;
                                controller.isSelected.value = false;
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: screenWidth(60) , bottom: screenWidth(60)),
                                child: Container(
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black),
                                    color: controller.selectedIndex.value == 0 ? Color.fromRGBO(69, 95, 185, 1) : Colors.white,
                                  ),
                                  child: Center(child: Text('All')),
                                ),
                              ),
                            ) :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                  controller.selectedIndex.value = index;
                                  controller.isSelected.value = true;
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black),
                                      color: controller.selectedIndex.value == index ? Color.fromRGBO(69, 95, 185, 1) : Colors.white,
                                    ),
                                    child: Center(child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(controller.items[index-1]),
                                    ))
                                ),
                              ),
                            );
                          }
                      );
                    }
                    ),
                  );
                }
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth(50) , vertical: screenWidth(50)),
                  child: Text('Products' , style: TextStyle(fontSize: screenWidth(10)),),
                ),

                Obx((){
                  return controller.isProductsLoading
                      ? buildShimmer2() : controller.productList.isEmpty
                      ? Text('No Products')
                      : Expanded(
                        child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.8),
                        itemCount:
                        controller.selectedIndex.value == 0 ? controller.productList.length :
                        controller.selectedIndex.value == 1 ? controller.electronicsList.length :
                        controller.selectedIndex.value == 2 ? controller.jeweleryList.length :
                        controller.selectedIndex.value == 3 ? controller.menList.length :
                        controller.selectedIndex.value == 4 ? controller.womenList.length :
                        controller.productList.length,
                        itemBuilder: (BuildContext context , int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                Get.to(
                                    DetailsView(
                                      model:
                                      controller.selectedIndex.value == 0 ? controller.productList[index] :
                                      controller.selectedIndex.value == 1 ? controller.electronicsList[index] :
                                      controller.selectedIndex.value == 2 ? controller.jeweleryList[index] :
                                      controller.selectedIndex.value == 3 ? controller.menList[index] :
                                      controller.selectedIndex.value == 4 ? controller.womenList[index] : controller.productList[index],
                                    )
                                );
                                },
                              child: Container(
                                width: screenWidth(4),
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
                                            initialRating:
                                            controller.selectedIndex.value == 0 ? controller.productList[index].rating!.rate!.toDouble() :
                                            controller.selectedIndex.value == 1 ? controller.electronicsList[index].rating!.rate!.toDouble() :
                                            controller.selectedIndex.value == 2 ? controller.jeweleryList[index].rating!.rate!.toDouble() :
                                            controller.selectedIndex.value == 3 ? controller.menList[index].rating!.rate!.toDouble() :
                                            controller.selectedIndex.value == 4 ? controller.womenList[index].rating!.rate!.toDouble() :
                                            controller.productList[index].rating!.rate!.toDouble(),
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

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: screenWidth(2.8),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          controller.selectedIndex.value == 0 ? controller.productList[index].image.toString() :
                                          controller.selectedIndex.value == 1 ? controller.electronicsList[index].image.toString() :
                                          controller.selectedIndex.value == 2 ? controller.jeweleryList[index].image.toString() :
                                          controller.selectedIndex.value == 3 ? controller.menList[index].image.toString() :
                                          controller.selectedIndex.value == 4 ? controller.womenList[index].image.toString() :
                                          controller.productList[index].image.toString(),
                                          placeholder: (context, url) => CircularProgressIndicator(),
                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    if(controller.isSelected.value == false && controller.selectedIndex.value == 0)...[
                                      Text(controller.productList[index].title ?? '' , textAlign: TextAlign.center , maxLines: 1,),
                                    ],
                                    if(controller.isSelected.value && controller.selectedIndex.value == 1)...[
                                      Text(controller.electronicsList[index].title ?? '' , textAlign: TextAlign.center , maxLines: 1,),
                                    ],
                                    if(controller.isSelected.value && controller.selectedIndex.value == 2)...[
                                      Text(controller.jeweleryList[index].title ?? '' , textAlign: TextAlign.center , maxLines: 1,),
                                    ],
                                    if(controller.isSelected.value && controller.selectedIndex.value == 3)...[
                                      Text(controller.menList[index].title ?? '' , textAlign: TextAlign.center , maxLines: 1,),
                                    ],
                                    if(controller.isSelected.value && controller.selectedIndex.value == 4)...[
                                      Text(controller.womenList[index].title ?? '' , textAlign: TextAlign.center , maxLines: 1,),
                                    ],

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Price: ' , style: TextStyle(color: Color.fromRGBO(69, 95, 185, 1)),),


                                        if(controller.isSelected.value == false && controller.selectedIndex.value == 0)...[
                                          Text(controller.productList[index].price.toString() , textAlign: TextAlign.center , maxLines: 1,),
                                        ],
                                        if(controller.isSelected.value && controller.selectedIndex.value == 1)...[
                                          Text(controller.electronicsList[index].price.toString() , textAlign: TextAlign.center , maxLines: 1,),
                                        ],
                                        if(controller.isSelected.value && controller.selectedIndex.value == 2)...[
                                          Text(controller.jeweleryList[index].price.toString() , textAlign: TextAlign.center , maxLines: 1,),
                                        ],
                                        if(controller.isSelected.value && controller.selectedIndex.value == 3)...[
                                          Text(controller.menList[index].price.toString() , textAlign: TextAlign.center , maxLines: 1,),
                                        ],
                                        if(controller.isSelected.value && controller.selectedIndex.value == 4)...[
                                          Text(controller.womenList[index].price.toString() , textAlign: TextAlign.center , maxLines: 1,),
                                        ]
                                        // Text(controller.productList[index].price.toString() , textAlign: TextAlign.center , maxLines: 1,),
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
                }
                ),
                SizedBox(height: screenWidth(7.5)),
              ],
            ),
          ),
        ),
    );
  }


  Widget buildShimmer1() => Container(
    height: MediaQuery.of(context).size.height * 0.09,
    child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsetsDirectional.only(start: 5, end: 5),
            child: Container(
              child: ShimmerWidget.circular(
                height: 10,
                width: 100,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          );
        }),
  );

  Widget buildShimmer2() => Padding(
    padding: EdgeInsetsDirectional.all(10.0),
    child: Container(
      child: GridView.builder(
        shrinkWrap: true,
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.8),
        itemBuilder: (BuildContext context, int index)  {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ShimmerWidget.circular(
              height: 50,
              width: 50,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
      ),
    ),
  );

}


