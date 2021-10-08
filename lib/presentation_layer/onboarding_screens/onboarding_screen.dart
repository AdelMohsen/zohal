import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/logic_layer/shared_pref/shared_pref.dart';
import 'package:zohal/presentation_layer/home_layout/home_nav_bar.dart';

class BoardingModel {
  final String image;
  final String text;

  BoardingModel({required this.image, required this.text});
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();

  final List<BoardingModel> boardingModelList = [
    BoardingModel(
        image: 'assets/onboarding/onboarding1.png',
        text: 'You can shopping everything online in easy and safe way'),
    BoardingModel(
        image: 'assets/onboarding/onboarding2.png',
        text: 'you can pay the order money by visa card'),
    BoardingModel(image: 'assets/onboarding/onboarding3.png', text: '    '),
  ];

  bool isLast = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 20),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * .70,
                      maxWidth: double.infinity),
                  child: buildPageViewItem(boardingModelList),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: orangeButton(
                              function: () {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 700),
                                    curve: Curves.fastLinearToSlowEaseIn);
                                if (isLast == true) {
                                  print('done');
                                }
                              },
                              child: const AutoSizeText(
                                'Next',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: whiteButton(
                              child: AutoSizeText(
                                'Skip',
                                style: TextStyle(
                                    color: HexColor('#FF6600'),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                                maxLines: 1,
                              ),
                              function: () {
                                submit();
                                navigateAndRemove(context, const HomeLayout());
                              },
                            ),
                          ),
                        ],
                      ),
                      AutoSizeText(
                        'Your privacy is important to us.we will not share your personal information.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: HexColor('#072C3F'),
                        ),
                        maxLines: 2,
                        minFontSize: 12,
                        maxFontSize: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width / 4),
                                child: AutoSizeText(
                                  'Term of use',
                                  style: TextStyle(
                                    color: HexColor('#FF6600'),
                                  ),
                                  maxLines: 1,
                                  minFontSize: 12,
                                  maxFontSize: 16,
                                ),
                              )),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width / 4),
                            child: const AutoSizeText(
                              'and',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              minFontSize: 12,
                              maxFontSize: 16,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width / 4),
                              child: AutoSizeText(
                                'Privacy policy',
                                style: TextStyle(
                                  color: HexColor('#FF6600'),
                                  fontSize: 15,
                                ),
                                maxLines: 1,
                                presetFontSizes: const [22, 18, 16, 12],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildPageViewItem(List<BoardingModel> boardingList) => PageView.builder(
        controller: pageController,
        onPageChanged: (index) {
          if (index == boardingList.length - 1) {
            setState(() {
              isLast = true;
            });
            submit();
          } else {
            isLast = false;
          }
        },
        physics: const BouncingScrollPhysics(),
        itemCount: boardingList.length,
        itemBuilder: (context, index) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(boardingList[index].image),
              fit: BoxFit.contain,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: 50.0,
                  maxWidth: MediaQuery.of(context).size.width - 50),
              child: AutoSizeText(
                boardingList[index].text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: HexColor('#072C3F'),
                ),
                maxLines: 2,
                presetFontSizes: const [25, 18, 16, 12],
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: 3,
              axisDirection: Axis.horizontal,
              effect: WormEffect(
                spacing: 5.0,
                dotWidth: 12,
                dotHeight: 12,
                paintStyle: PaintingStyle.stroke,
                dotColor: HexColor('#FF6600'),
                activeDotColor: HexColor('#FF6600'),
              ),
            ),
          ],
        ),
      );

  submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true);
  }
}
