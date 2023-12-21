import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/UI/shared/utils.dart';
import 'package:online_store/core/enums/bottom_navigation.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationWidget extends StatefulWidget {

  final BottomNavigationEnum bottomNavigation;
  final Function (BottomNavigationEnum ,int) onTap;

  const BottomNavigationWidget({Key? key, required this.bottomNavigation, required this.onTap}) : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    Color? iconColor;
    Color? textColor;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [

        Container(
          width: double.infinity,
          height: screenWidth(7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
              color: Colors.grey,
              offset: Offset(0,5),
              blurRadius: 15
            ),
            ]
          ),
        ),

        PositionedDirectional(
          bottom: size.width * 0.035,
          start: size.width * 0.05,
          end: size.width * 0.05,
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: size.width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                navItem(
                    onTap: (){
                      widget.onTap(BottomNavigationEnum.PRODUCTS,0);
                    },
                    size: Size(700,700),
                    imageName: 'product_icon',
                    // text: 'home',
                    isSelected: widget.bottomNavigation == BottomNavigationEnum.PRODUCTS),
                SizedBox(
                  width: size.width * 0.1,
                ),
                navItem(
                    onTap: (){
                      widget.onTap(BottomNavigationEnum.HOME,1);
                    },
                    size: Size(700,700),
                    imageName: 'home',
                    // text: 'prod',
                    isSelected: widget.bottomNavigation == BottomNavigationEnum.HOME),
                SizedBox(
                  width: size.width * 0.1,
                ),
                Stack(
                  children: [

                    navItem(
                        onTap: (){
                          widget.onTap(BottomNavigationEnum.CART,2);
                        },
                        size: Size(700,700),
                        imageName: 'cart_icon',
                        // text: 'cart',
                        isSelected: widget.bottomNavigation == BottomNavigationEnum.CART),

                    Obx(() {
                      return Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: screenWidth(25),
                          height: screenWidth(25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: cartService.cartCount == 0 ?
                              iconColor = Colors.transparent : Colors.red
                          ),
                          child: Center(
                              child: Text(
                                '${cartService.cartCount}',
                                style: TextStyle(
                                    color: cartService.cartCount == 0 ?
                                    textColor = Colors.transparent : Colors
                                        .black),
                              )

                          ),
                        ),
                      );
                    }
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget navItem({
    required Size size,
    required String imageName,
    // required String text,
    required bool isSelected,
    required Function onTap,
  }) {
    return InkWell(
      onTap: (){ onTap(); },
      child: Column(
        children: [
          SvgPicture.asset(
            "images/$imageName.svg",
            width: isSelected ? size.width * 0.05 :  size.width * 0.045,
            color:
            isSelected ? Color.fromRGBO(69, 95, 185, 1) : Colors.black,
          ),
          // Text(text,style: TextStyle(color: isSelected ? Colors.blue : Colors.grey),),
        ],
      ),
    );
  }
}



class ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
