import 'package:carousel_slider/carousel_slider.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/end_point.dart';
import 'package:zohal/elements/home_screen_widgets.dart';
import 'package:zohal/logic_layer/authentication_cubit/authentication_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()..getBannersData()),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is GetBannersDataSuccessState) {
            HomeCubit.get(context).getCategoriesIcon();
            HomeCubit.get(context).getNewItemsData();
          }
          if (state is GetCategoriesIconSuccessState) {
            HomeCubit.get(context).getBrandIcon();
          }
          if (state is GetBannersDataErrorState) {
            HomeCubit.get(context).getCategoriesIcon();
            HomeCubit.get(context).getNewItemsData();
          }
          if (state is GetCategoriesIconErrorState) {
            HomeCubit.get(context).getBrandIcon();
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Carousal_Slider_Start
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          state is! GetBannersDataLoadingState,
                      widgetBuilder: (context) => Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            onPageChanged: (index, carousalPageChangedReason) {
                              // cubit.changeActiveIndex(index);
                            },
                            height: 135.0,
                            scrollDirection: Axis.horizontal,
                            initialPage: 1,
                            scrollPhysics: const BouncingScrollPhysics(),
                            autoPlay: true,
                            autoPlayAnimationDuration:
                                const Duration(seconds: 1),
                            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                            autoPlayInterval: const Duration(seconds: 3),
                            viewportFraction: .99,
                            enableInfiniteScroll: true,
                            enlargeCenterPage: true,
                          ),
                          items: cubit.bannersModel!.data
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.network(
                                        BASE_URL2 + e.bannerUrl.toString(),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      fallbackBuilder: (context) => const SizedBox(
                          height: 135.0,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.deepOrange,
                            backgroundColor: Colors.grey,
                          ))),
                    ),
                    // Center(
                    //   child: AnimatedSmoothIndicator(
                    //     activeIndex: cubit.activeIndex,
                    //     count: 3,
                    //     effect: WormEffect(
                    //       spacing: 5.0,
                    //       dotWidth: 8,
                    //       dotHeight: 8,
                    //       paintStyle: PaintingStyle.stroke,
                    //       dotColor: HexColor('#FF6600'),
                    //       activeDotColor: HexColor('#FF6600'),
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 10.0, horizontal: 20.0),
                    //   child: SizedBox(
                    //     height: 50.0,
                    //     child: Row(
                    //       children: [
                    //         Expanded(
                    //           child: Card(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(5.0),
                    //                 side: BorderSide(
                    //                     color: cubit.activeIndex != 0
                    //                         ? HexColor('#D6D4D3')
                    //                         : HexColor('#FF6600'),
                    //                     width: 1.29)),
                    //             child: Image.network(
                    //                 'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX10223332.jpg'),
                    //           ),
                    //         ),
                    //         const SizedBox(
                    //           width: 15.0,
                    //         ),
                    //         Expanded(
                    //           child: Card(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(5.0),
                    //                 side: BorderSide(
                    //                   color: cubit.activeIndex != 1
                    //                       ? HexColor('#D6D4D3')
                    //                       : HexColor('#FF6600'),
                    //                   width: 1.29,
                    //                 )),
                    //             child: Image.network(
                    //                 'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX10223332.jpg'),
                    //           ),
                    //         ),
                    //         const SizedBox(
                    //           width: 15.0,
                    //         ),
                    //         Expanded(
                    //           child: Card(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(5.0),
                    //                 side: BorderSide(
                    //                   color: cubit.activeIndex != 2
                    //                       ? HexColor('#D6D4D3')
                    //                       : HexColor('#FF6600'),
                    //                   width: 1.29,
                    //                 )),
                    //             child: Image.network(
                    //                 'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX10223332.jpg'),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    //Carousal_Slider_End

                    //Categories_Product_Start
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'Categories'.tr().toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#072C3F'),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Conditional.single(
                            context: context,
                            conditionBuilder: (context) =>
                                cubit.categoriesModel != null,
                            widgetBuilder: (context) => Expanded(
                                  child: buildCategoriesItem(
                                      cubit.categoriesModel),
                                ),
                            fallbackBuilder: (context) => const Expanded(
                                  child: SizedBox(
                                    height: 35.0,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.deepOrange,
                                        backgroundColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                )),
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
                        'New items'.tr().toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#072C3F'),
                        ),
                      ),
                    ),
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) => cubit.newItems != null,
                      widgetBuilder: (context) => buildNewItemProducts(
                          cubit.newItems, context, state, cubit),
                      fallbackBuilder: (context) => const SizedBox(
                        height: 220.0,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepOrange,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    //New_Item_End

                    //TRADE_MARKS_START
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: Text(
                        'Trademarks'.tr().toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#072C3F'),
                        ),
                      ),
                    ),
                    Conditional.single(
                        context: context,
                        conditionBuilder: (context) => cubit.brandModel != null,
                        widgetBuilder: (context) =>
                            buildTradeMarksItems(cubit.brandModel),
                        fallbackBuilder: (context) => const SizedBox(
                              height: 40.0,
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Colors.deepOrange,
                                backgroundColor: Colors.grey,
                              )),
                            )),
                    //TRADE_MARKS_End

                    //Popular_Items_Start
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: Text(
                        'Popular item'.tr().toString(),
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
                        'Special Offers'.tr().toString(),
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
                        'Electronics'.tr().toString(),
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
                        'Bags'.tr().toString(),
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
      ),
    );
  }
}
