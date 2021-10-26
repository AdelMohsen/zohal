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
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/elements/home_screen_widgets.dart';
import 'package:zohal/logic_layer/authentication_cubit/authentication_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/products_section/electronics_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()..getTopBannersData()),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (type != 4) {
            if (state is GetTopBannersDataSuccessState) {
              HomeCubit.get(context).getProfileData();
              HomeCubit.get(context).getCategoriesIcon();
            }
            if (state is GetCategoriesIconSuccessState) {
              HomeCubit.get(context).getNewItemsData();
              HomeCubit.get(context).getBrandIcon();
            }
            if (state is GetNewItemsDataSuccessState) {
              HomeCubit.get(context).getMiddelBannersData();
              HomeCubit.get(context).getBottomBannersData();
            }
            if (state is GetTopBannersDataErrorState) {
              HomeCubit.get(context).getProfileData();
              HomeCubit.get(context).getCategoriesIcon();
            }
            if (state is GetCategoriesIconErrorState) {
              HomeCubit.get(context).getNewItemsData();
              HomeCubit.get(context).getBrandIcon();
            }
            if (state is GetNewItemsDataErrorState) {
              HomeCubit.get(context).getMiddelBannersData();
              HomeCubit.get(context).getBottomBannersData();
            }
          } else {
            if (state is GetTopBannersDataSuccessState) {
              HomeCubit.get(context).getCategoriesIcon();
              HomeCubit.get(context).getNewItemsData();
            }
            if (state is GetCategoriesIconSuccessState) {
              HomeCubit.get(context).getBrandIcon();
              HomeCubit.get(context).getMiddelBannersData();
              HomeCubit.get(context).getBottomBannersData();
            }
            if (state is GetTopBannersDataErrorState) {
              HomeCubit.get(context).getCategoriesIcon();
              HomeCubit.get(context).getNewItemsData();
            }
            if (state is GetCategoriesIconErrorState) {
              HomeCubit.get(context).getBrandIcon();
              HomeCubit.get(context).getMiddelBannersData();
              HomeCubit.get(context).getBottomBannersData();
            }
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          var userData = HomeCubit.get(context).userData;
          return Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Todo : Top_Carousal_Slider_Start
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          cubit.bannersModel1 != null,
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
                          items: cubit.bannersModel1!.data
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.network(
                                        BASE_URL2 + e.bannerUrl.toString(),
                                        fit: BoxFit.contain,
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

                    //Todo :Top_Carousal_Slider_End

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
                                color: HexColor('#195F82'),
                                fontSize: 10.0,
                              ),
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
                      conditionBuilder: (context) => type != 4
                          ? cubit.newItems != null && userData != null
                          : cubit.newItems != null,
                      widgetBuilder: (context) => buildNewItemProducts(
                        cubit.newItems,
                        context,
                        state,
                        cubit,
                      ),
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

                    //Todo : Middel_Carousal_Start
                    const SizedBox(
                      height: 10.0,
                    ),
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                         cubit.bannersModel2 !=null,
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
                          items: cubit.bannersModel2!.data
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.network(
                                        BASE_URL2 + e.bannerUrl.toString(),
                                        fit: BoxFit.contain,
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
                    //buildCardForSpecialOffer(),
                    //Todo : Middel_Carousal_End

                    //Todo : SpcialOfferItemProducts_START
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
                    buildSpecialOfferItemProducts(),
                    //Todo : SpcialOfferItemProducts_END

                    //Electronics_Start
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: InkWell(
                        onTap: () {
                          navigateTo(context, const ElectronicsScreen());
                        },
                        child: Text(
                          'Electronics'.tr().toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#072C3F'),
                          ),
                        ),
                      ),
                    ),
                    buildElectronicsItemProducts(),
                    //Electronics_End

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

                    //Todo : Bottom_Carousal_Start
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                         cubit.bannersModel3 != null,
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
                          items: cubit.bannersModel3!.data
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child:e.bannerUrl != '' ? Image.network(
                                        BASE_URL2 + e.bannerUrl.toString(),
                                        fit: BoxFit.contain,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ) :Image.asset(
                                       'assets/images/noImageAvaliable.jpg',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ) ,
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
                    const SizedBox(
                      height: 20.0,
                    ),
                    //Todo : Bottom_Carousal_End
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
