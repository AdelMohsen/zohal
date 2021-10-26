import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/end_point.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/models/favourites_model/favourites_model.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getFavouritesData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          FavouritesModel? favouritesModel =
              HomeCubit.get(context).favouritesModel;
          var cubit = HomeCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                centerTitle: true,
                backgroundColor: Colors.white,
                title: AutoSizeText(
                  'Your Favourites'.tr().toString(),
                  minFontSize: 13,
                  maxFontSize: 18,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        if (favouritesModel!.favouritesItemData.isEmpty) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.WARNING,
                            animType: AnimType.TOPSLIDE,
                            title: 'Your favourites is already empty ...!'
                                .tr()
                                .toString(),
                           
                            btnOkOnPress: () {},
                            btnOkColor: Colors.red,
                            btnCancelColor: const Color(0xFF00CA71),
                          ).show();
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.WARNING,
                            animType: AnimType.TOPSLIDE,
                            title: 'Do you want to confirm deleting all.!?'
                                .tr()
                                .toString(),
                            btnCancelOnPress: () {
                              Navigator.pop(context);
                            },
                            btnOkOnPress: () {
                              cubit.deleteAllFromFavourites();
                            },
                            btnOkColor: Colors.red,
                            btnCancelColor: const Color(0xFF00CA71),
                          ).show();
                        }
                      },
                      icon: const Icon(
                        Icons.clear_all,
                        color: Colors.deepOrange,
                      ))
                ],
              ),
              body: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            favouritesModel != null &&
                            favouritesModel.favouritesItemData.isNotEmpty,
                        widgetBuilder: (context) => ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 10.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: const BorderSide(
                                              color: Colors.deepOrange),
                                        ),
                                        margin: EdgeInsets.zero,
                                        elevation: 3.0,
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                alignment: AlignmentDirectional
                                                    .bottomStart,
                                                children: [
                                                  Image(
                                                    fit: BoxFit.contain,
                                                    height: 100.0,
                                                    width: 100.0,
                                                    image: NetworkImage(
                                                      BASE_URL2 +
                                                          favouritesModel!
                                                              .favouritesItemData[
                                                                  index]
                                                              .product!
                                                              .decoration!
                                                              .indexPhotoUrl
                                                              .toString(),
                                                    ),
                                                  ),
                                                  if (favouritesModel
                                                          .favouritesItemData[
                                                              index]
                                                          .product!
                                                          .discountPrice !=
                                                      '0')
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0),
                                                      color: Colors.redAccent,
                                                      child: const Text(
                                                        'Discount',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10.0),
                                                      ),
                                                    )
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: AutoSizeText(
                                                            favouritesModel
                                                                .favouritesItemData[
                                                                    index]
                                                                .product!
                                                                .name
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              height: 1.25,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            minFontSize: 12,
                                                            maxFontSize: 15,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            cubit.addOrDeleteItemToFavourites(
                                                                productId: favouritesModel
                                                                    .favouritesItemData[
                                                                        index]
                                                                    .product!
                                                                    .id
                                                                    .toString(),
                                                                toDelete: "1");
                                                          },
                                                          icon: const Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.red),
                                                        )
                                                      ],
                                                    ),
                                                    AutoSizeText(
                                                      favouritesModel
                                                          .favouritesItemData[
                                                              index]
                                                          .product!
                                                          .model
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                      minFontSize: 12,
                                                      maxFontSize: 15,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                    // Row(
                                                    //   mainAxisAlignment:
                                                    //       MainAxisAlignment
                                                    //           .spaceEvenly,
                                                    //   children: [
                                                    //     AutoSizeText(
                                                    //       'Quantatiy : '
                                                    //           .tr()
                                                    //           .toString(),
                                                    //       style:
                                                    //           const TextStyle(
                                                    //         color: Colors.grey,
                                                    //       ),
                                                    //       minFontSize: 12,
                                                    //       maxFontSize: 15,
                                                    //       overflow: TextOverflow
                                                    //           .ellipsis,
                                                    //       maxLines: 1,
                                                    //     ),
                                                    //     AutoSizeText(
                                                    //       shoppingCart
                                                    //           .shoppingCartData!
                                                    //           .cart![index]
                                                    //           .quantity
                                                    //           .toString(),
                                                    //       style:
                                                    //           const TextStyle(
                                                    //         color: Colors.grey,
                                                    //       ),
                                                    //       minFontSize: 12,
                                                    //       maxFontSize: 15,
                                                    //       overflow: TextOverflow
                                                    //           .ellipsis,
                                                    //       maxLines: 1,
                                                    //     ),
                                                    //     IconButton(
                                                    //         onPressed: () {
                                                    //           changeQuantatiyDialog(
                                                    //             context,
                                                    //             cubit,
                                                    //             shoppingCart,
                                                    //             index,
                                                    //           );
                                                    //         },
                                                    //         icon: const Icon(
                                                    //             Icons.edit,
                                                    //             color: Colors
                                                    //                 .deepOrange)),
                                                    //   ],
                                                    // ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        (favouritesModel
                                                                    .favouritesItemData[
                                                                        index]
                                                                    .product!
                                                                    .discountPrice ==
                                                                '0')
                                                            ? Expanded(
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    AutoSizeText(
                                                                      favouritesModel
                                                                          .favouritesItemData[
                                                                              index]
                                                                          .product!
                                                                          .price
                                                                          .toString(),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .redAccent,
                                                                      ),
                                                                      minFontSize:
                                                                          10,
                                                                      maxFontSize:
                                                                          15,
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            : Expanded(
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    AutoSizeText(
                                                                      favouritesModel
                                                                          .favouritesItemData[
                                                                              index]
                                                                          .product!
                                                                          .discountPrice
                                                                          .toString(),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .redAccent,
                                                                      ),
                                                                      minFontSize:
                                                                          10,
                                                                      maxFontSize:
                                                                          15,
                                                                    ),
                                                                    const SizedBox(
                                                                      width:
                                                                          10.0,
                                                                    ),
                                                                    AutoSizeText(
                                                                      favouritesModel
                                                                          .favouritesItemData[
                                                                              index]
                                                                          .product!
                                                                          .price
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              12,
                                                                          decoration:
                                                                              TextDecoration.lineThrough),
                                                                      minFontSize:
                                                                          8,
                                                                      maxFontSize:
                                                                          12,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                        orangeButton(
                                                            minWidth: 1,
                                                            height: 25,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            35.0)),
                                                            function: () {
                                                              setQuantatiyDialog(
                                                                  context,
                                                                  cubit,
                                                                  favouritesModel,
                                                                  index);
                                                            },
                                                            child: AutoSizeText(
                                                              'TO CART'.tr(),
                                                              minFontSize: 8,
                                                              maxFontSize: 12,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                            separatorBuilder: (context, index) => const Divider(
                                  thickness: 1,
                                ),
                            itemCount:
                                favouritesModel!.favouritesItemData.length),
                        fallbackBuilder: (context) {
                          if (favouritesModel != null) {
                            if (favouritesModel.favouritesItemData.isEmpty) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 64,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Center(
                                    child: AutoSizeText(
                                      'Your Favourites Is Empty.....!'
                                          .tr()
                                          .toString(),
                                      minFontSize: 16,
                                      maxFontSize: 22,
                                      style: const TextStyle(
                                          color: Colors.deepOrange),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  color: Colors.deepOrange,
                                ),
                              );
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.grey,
                                color: Colors.deepOrange,
                              ),
                            );
                          }
                        }),
                  ),
                  // ConstrainedBox(
                  //     constraints:
                  //         const BoxConstraints(maxWidth: double.infinity),
                  //     child: Divider(
                  //       thickness: .5,
                  //       color: primaryColor,
                  //       indent: 12.0,
                  //       endIndent: 12.0,
                  //     )),
                  // if (favouritesModel != null &&
                  //     favouritesModel.favouritesItemData.isNotEmpty)
                  //   SizedBox(
                  //     height: 50,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       mainAxisSize: MainAxisSize.max,
                  //       children: [
                  //         ConstrainedBox(
                  //           constraints: BoxConstraints(
                  //               maxWidth: MediaQuery.of(context).size.width / 2,
                  //               minHeight: 50),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             mainAxisSize: MainAxisSize.max,
                  //             children: [
                  //               const AutoSizeText(
                  //                 'Total Price : ',
                  //                 style: TextStyle(color: Colors.black),
                  //               ),
                  //               Expanded(
                  //                 child: Text(
                  //                   shoppingCart.shoppingCartData!.totalPrice
                  //                       .toString(),
                  //                   style: TextStyle(color: primaryColor),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //         ConstrainedBox(
                  //           constraints: BoxConstraints(
                  //               maxWidth:
                  //                   MediaQuery.of(context).size.width / 3),
                  //           child: orangeButton(
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(35),
                  //               ),
                  //               function: () {},
                  //               child: AutoSizeText(
                  //                 'Checkout'.tr().toString(),
                  //                 style: const TextStyle(
                  //                     color: Colors.white,
                  //                     fontWeight: FontWeight.w500),
                  //                 minFontSize: 14,
                  //                 maxFontSize: 22,
                  //               )),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                ],
              ));
        },
      ),
    );
  }

  setQuantatiyDialog(
    context,
    HomeCubit cubit,
    FavouritesModel? favouritesModel,
    int? index,
  ) {
    int quantity = 1;
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.grey,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(builder: (context, qState) {
              return Row(
                children: [
                  Text(
                    'Quantity :  ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#072C3F'),
                    ),
                  ),
                  Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                        color: HexColor('#E1E1E1'),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        qState(() {
                          quantity--;
                        });
                      },
                      icon: const Icon(
                        Icons.indeterminate_check_box_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    child: Center(
                      child: Text(
                        quantity.toString(),
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: HexColor('#E1E1E1'),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        qState(() {
                          quantity++;
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      color: HexColor('#E1E1E1'),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(
              height: 20.0,
            ),
            orangeButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              function: () {
                cubit.addOrUpdateOrRemoveToShoppingCart(
                    productId: favouritesModel!
                        .favouritesItemData[index!.toInt()].product!.id
                        .toString(),
                    quantity: quantity.toString(),
                    toDelete: "0",
                    context: ctx);
              },
              child: AutoSizeText(
                'ADD TO CART'.tr().toString(),
                minFontSize: 12,
                maxFontSize: 18,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
