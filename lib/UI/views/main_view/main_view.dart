import 'package:flutter/material.dart';
import 'package:online_store/UI/views/main_view/products_view/products_view.dart';
import 'package:online_store/core/enums/bottom_navigation.dart';
import 'cart_view/cart_view.dart';
import 'home_page_view/home_page_view.dart';
import 'main_view_widgets/bottom_navigation_widget.dart';




class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  TextEditingController searchController = TextEditingController();

  BottomNavigationEnum select = BottomNavigationEnum.HOME;
  PageController controller = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        key: key,
        resizeToAvoidBottomInset: false,
        body: Stack(
            children: [
              PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller,
                children: [
                  ProductsView(),
                  HomePageView(),
                  CartView(),
                ],
              ),

              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: BottomNavigationWidget(
                  bottomNavigation: select,
                  onTap: (selected , pageNumber ) {
                    // key.currentState!.openDrawer();
                    setState(() {
                      select = selected;
                    }
                    );
                    controller.jumpToPage(pageNumber);
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}