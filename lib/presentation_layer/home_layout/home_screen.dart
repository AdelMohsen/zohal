import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zohal/elements/home_screen_widgets.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Carousal_Slider_Start
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: CarouselSlider.builder(
                      itemCount: cubit.urlImage.length,
                      itemBuilder: (context, index, realIndex) =>
                          cubit.urlImage.isEmpty
                              ? carousalLoaderWidget(context)
                              : buildCarousalImageItem(cubit.urlImage[index]),
                      options: CarouselOptions(
                        onPageChanged: (index, carousalPageChangedReason) {
                          cubit.changeActiveIndex(index);
                        },
                        height: 135.0,
                        scrollDirection: Axis.horizontal,
                        initialPage: 1,
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                        autoPlayInterval: const Duration(seconds: 3),
                        viewportFraction: .99,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                      ),
                    ),
                  ),
                  Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: cubit.activeIndex,
                      count: 3,
                      effect: WormEffect(
                        spacing: 5.0,
                        dotWidth: 8,
                        dotHeight: 8,
                        paintStyle: PaintingStyle.stroke,
                        dotColor: HexColor('#FF6600'),
                        activeDotColor: HexColor('#FF6600'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: SizedBox(
                      height: 50.0,
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(
                                      color: cubit.activeIndex != 0
                                          ? HexColor('#D6D4D3')
                                          : HexColor('#FF6600'),
                                      width: 1.29)),
                              child: Image.network(
                                  'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX10223332.jpg'),
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(
                                    color: cubit.activeIndex != 1
                                        ? HexColor('#D6D4D3')
                                        : HexColor('#FF6600'),
                                    width: 1.29,
                                  )),
                              child: Image.network(
                                  'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX10223332.jpg'),
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(
                                    color: cubit.activeIndex != 2
                                        ? HexColor('#D6D4D3')
                                        : HexColor('#FF6600'),
                                    width: 1.29,
                                  )),
                              child: Image.network(
                                  'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX10223332.jpg'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Carousal_Slider_End

                  //Categories_Product_Start
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#072C3F'),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildCategoriesItem(),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: 40,
                        height: 35,
                        child: Center(
                          child: Text(
                            'All',
                            style: TextStyle(
                                color: HexColor('#195F82'), fontSize: 10.0),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                                color: HexColor('#195F82'), width: 1.29)),
                      ),
                    ],
                  ),
                  //Categories_Product_End

                  //New_Item_Start
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'New item',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#072C3F'),
                      ),
                    ),
                  ),
                  buildNewItemProducts(),
                  //New_Item_End

                  //TRADE_MARKS_START
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Text(
                      'Trademarks',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#072C3F'),
                      ),
                    ),
                  ),
                  buildTradeMarksItems(),
                  //TRADE_MARKS_End

                  //Popular_Items_Start
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Text(
                      'Popular item',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#072C3F'),
                      ),
                    ),
                  ),
                  buildPopularItemProducts(),
                  //Popular_Items_End

                  //Special_Offer_Start
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Text(
                      'Special Offers',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#072C3F'),
                      ),
                    ),
                  ),
                  buildCardForSpecialOffer(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  buildSpecialOfferItemProducts(),
                  //Special_Offer_End

                  //Electronics_Start
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Text(
                      'Electronics',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#072C3F'),
                      ),
                    ),
                  ),
                  buildElectronicsItemProducts(),
                  //Electronics_End
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 125,
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/home/shoseOffer.png',
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),

                  //Bags_Start
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Text(
                      'Bags',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#072C3F'),
                      ),
                    ),
                  ),
                  buildBagsItemProduct(),
                  //Bags_End
                  const SizedBox(
                    height: 20.0,
                  ),
                  buildCardUnderBagsItemProducts(),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
