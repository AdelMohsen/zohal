import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/end_point.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/models/shopping_cart/shopping_cart.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class CartScreen extends StatelessWidget {
  //int totalPrice = 0;

  CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getShoppingCartData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            ShoppingCart? shoppingCart = cubit.shoppingCart;
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0.0,
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  title: AutoSizeText(
                    'Shopping Cart'.tr().toString(),
                    minFontSize: 13,
                    maxFontSize: 18,
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.w500),
                  ),
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.deepOrange,
                      )),
                  actions: [
                    IconButton(
                        onPressed: () {
                          if (shoppingCart!.shoppingCartData!.cart!.isEmpty) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.WARNING,
                              animType: AnimType.TOPSLIDE,
                              title: 'Your cart is already empty ...!'
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
                                cubit.deleteShoppingCartData();
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
                              shoppingCart != null &&
                              shoppingCart.shoppingCartData!.cart!.isNotEmpty,
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
                                                  alignment:
                                                      AlignmentDirectional
                                                          .bottomStart,
                                                  children: [
                                                    Image(
                                                      fit: BoxFit.contain,
                                                      height: 100.0,
                                                      width: 100.0,
                                                      image: NetworkImage(
                                                        BASE_URL2 +
                                                            shoppingCart!
                                                                .shoppingCartData!
                                                                .cart![index]
                                                                .decoration!
                                                                .indexPhotoUrl
                                                                .toString(),
                                                      ),
                                                    ),
                                                    if (shoppingCart
                                                            .shoppingCartData!
                                                            .cart![index]
                                                            .discountPrice !=
                                                        '0')
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    5.0),
                                                        color: Colors.redAccent,
                                                        child: const Text(
                                                          'Discount',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: AutoSizeText(
                                                              shoppingCart
                                                                  .shoppingCartData!
                                                                  .cart![index]
                                                                  .product!
                                                                  .productName
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                height: 1.25,
                                                                color: Colors
                                                                    .black,
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
                                                                cubit.addOrUpdateOrRemoveToShoppingCart(
                                                                    productId: shoppingCart
                                                                        .shoppingCartData!
                                                                        .cart![
                                                                            index]
                                                                        .product!
                                                                        .productId
                                                                        .toString(),
                                                                    quantity: shoppingCart
                                                                        .shoppingCartData!
                                                                        .cart![
                                                                            index]
                                                                        .quantity
                                                                        .toString(),
                                                                    toDelete:
                                                                        "1",
                                                                    context:
                                                                        context);
                                                              },
                                                              icon: const Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .red))
                                                        ],
                                                      ),
                                                      AutoSizeText(
                                                        shoppingCart
                                                            .shoppingCartData!
                                                            .cart![index]
                                                            .product!
                                                            .productModel
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                        minFontSize: 12,
                                                        maxFontSize: 15,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          AutoSizeText(
                                                            'Quantatiy : '
                                                                .tr()
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            minFontSize: 12,
                                                            maxFontSize: 15,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                          AutoSizeText(
                                                            shoppingCart
                                                                .shoppingCartData!
                                                                .cart![index]
                                                                .quantity
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            minFontSize: 12,
                                                            maxFontSize: 15,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                changeQuantatiyDialog(
                                                                  context,
                                                                  cubit,
                                                                  shoppingCart,
                                                                  index,
                                                                );
                                                              },
                                                              icon: const Icon(
                                                                  Icons.edit,
                                                                  color: Colors
                                                                      .deepOrange)),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          (shoppingCart
                                                                      .shoppingCartData!
                                                                      .cart![
                                                                          index]
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
                                                                        shoppingCart
                                                                            .shoppingCartData!
                                                                            .cart![index]
                                                                            .price
                                                                            .toString(),
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.redAccent,
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
                                                                        shoppingCart
                                                                            .shoppingCartData!
                                                                            .cart![index]
                                                                            .discountPrice
                                                                            .toString(),
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.redAccent,
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
                                                                        shoppingCart
                                                                            .shoppingCartData!
                                                                            .cart![index]
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
                                                          CircleAvatar(
                                                            radius: 15,
                                                            backgroundColor:
                                                                Colors
                                                                    .redAccent,
                                                            child: IconButton(
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .shopping_cart,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                onPressed:
                                                                    () {}),
                                                          ),
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
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    thickness: 1,
                                  ),
                              itemCount:
                                  shoppingCart!.shoppingCartData!.cart!.length),
                          fallbackBuilder: (context) {
                            if (shoppingCart != null) {
                              if (shoppingCart
                                  .shoppingCartData!.cart!.isEmpty) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 64,
                                      color: primaryColor,
                                    ),
                                    AutoSizeText(
                                      'Your Cart Is Empty.....!'
                                          .tr()
                                          .toString(),
                                      minFontSize: 16,
                                      maxFontSize: 22,
                                      style: const TextStyle(
                                          color: Colors.deepOrange),
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
                    ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: double.infinity),
                        child: Divider(
                          thickness: .5,
                          color: primaryColor,
                          indent: 12.0,
                          endIndent: 12.0,
                        )),
                    if (shoppingCart != null &&
                        shoppingCart.shoppingCartData!.cart!.isNotEmpty)
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width / 2,
                                  minHeight: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const AutoSizeText(
                                    'Total Price : ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Expanded(
                                    child: Text(
                                      shoppingCart.shoppingCartData!.totalPrice
                                          .toString(),
                                      style: TextStyle(color: primaryColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width / 3),
                              child: orangeButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  function: () {},
                                  child: AutoSizeText(
                                    'Checkout'.tr().toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                    minFontSize: 14,
                                    maxFontSize: 22,
                                  )),
                            )
                          ],
                        ),
                      ),
                  ],
                ));
          }),
    );
  }

  changeQuantatiyDialog(
    context,
    HomeCubit cubit,
    ShoppingCart? shoppingCart,
    int? index,
  ) {
    int quantity = int.parse(shoppingCart!
        .shoppingCartData!.cart![index!.toInt()].quantity
        .toString());
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
                      productId: shoppingCart.shoppingCartData!
                          .cart![index.toInt()].product!.productId
                          .toString(),
                      quantity: quantity.toString(),
                      toDelete: "0",
                      context: ctx);
                },
                child: AutoSizeText(
                  'save'.tr().toString(),
                  minFontSize: 12,
                  maxFontSize: 18,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                )),
          ],
        ),
      ),
    );
  }
}
