import 'package:first_project/modules/shop_app/login_screen/login_shop_screen.dart';
import 'package:first_project/shared/components/components.dart';
import 'package:first_project/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../styles/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardScreen extends StatefulWidget {
  static const String routeName = 'OnBoardScreen';

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  var pageController = PageController();

// Boarding list images with text.
  List<BoardingModel> boardModel = [
    BoardingModel(
      image: 'assets/images/onboard1.jpg',
      title: 'Welcome to A4try🤍👋',
      body: 'This application content all you need',
    ),
    BoardingModel(
      image: 'assets/images/onboard2.jpg',
      title: 'What\'s provide ?',
      body: 'It\'s help you to buy all you need online',
    ),
    BoardingModel(
      image: 'assets/images/onboard3.jpg',
      title: 'Online payment!',
      body: 'You can pay all your purchases online',
    ),
  ];
  void submit() {
    cashesHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value!) {
        navigateAndReplace(context, LoginShopScreen());
      }
    });
  }

//boolean value to consider reach to last page or not.
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: submit,
            child: Text(
              'SKIP',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: pageController,
                onPageChanged: (int index) {
                  if (index == boardModel.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) => OnBoardItem(boardModel[index]),
                itemCount: boardModel.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    expansionFactor: 3,
                    spacing: 5,
                    radius: 30,
                    dotWidth: 12,
                    dotHeight: 12,
                  ),
                  onDotClicked: (int index) {
                    pageController.animateToPage(index,
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget OnBoardItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(model.image),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}
