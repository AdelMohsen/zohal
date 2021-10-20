import 'dart:math';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/end_point.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/elements/products_details_widgets.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/models/products/new_items.dart';
import 'package:zohal/presentation_layer/chat_screens/chat_with_vendor.dart';
import 'package:zohal/presentation_layer/home_layout/cart_screen.dart';
import 'package:zohal/presentation_layer/vendor/vendor_profile_with_customer.dart';

// ignore: must_be_immutable
class ProductsDetails extends StatefulWidget {
  int? index;
  NewItems? newItemDetails;

  ProductsDetails(this.index, this.newItemDetails, {Key? key})
      : super(key: key);

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  String _largeImage = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _largeImage = widget
        .newItemDetails!.itemsData[widget.index!.toInt()].decoration![0].img1Url
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: AutoSizeText(
              widget.newItemDetails!.itemsData[widget.index!.toInt()].name
                  .toString(),
              style: TextStyle(color: primaryColor),
              minFontSize: 12,
              maxFontSize: 18,
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.deepOrange,
                )),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, CartScreen());
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: HexColor('#FF6600'),
                  )),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Hero(
                tag: widget.newItemDetails!.itemsData[widget.index!.toInt()].id
                    .toString(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Build_Images_Items_Start
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        BASE_URL2 + _largeImage,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: 230,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 80.0,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (widget
                                        .newItemDetails!
                                        .itemsData[widget.index!.toInt()]
                                        .decoration![0]
                                        .img1Url !=
                                    null) {
                                  setState(() {
                                    _largeImage = "" +
                                        widget
                                            .newItemDetails!
                                            .itemsData[widget.index!.toInt()]
                                            .decoration![0]
                                            .img1Url
                                            .toString();
                                  });
                                }
                              },
                              child: FadeInImage(
                                placeholder:
                                    const AssetImage('assets/gif/loading.gif'),
                                image: widget
                                            .newItemDetails!
                                            .itemsData[widget.index!.toInt()]
                                            .decoration![0]
                                            .img1Url !=
                                        null
                                    ? NetworkImage(BASE_URL2 +
                                        widget
                                            .newItemDetails!
                                            .itemsData[widget.index!.toInt()]
                                            .decoration![0]
                                            .img1Url
                                            .toString())
                                    : Image.asset(
                                            'assets/images/noImageAvaliable.jpg')
                                        .image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (widget
                                        .newItemDetails!
                                        .itemsData[widget.index!.toInt()]
                                        .decoration![0]
                                        .img2Url !=
                                    null) {
                                  setState(() {
                                    _largeImage = "" +
                                        widget
                                            .newItemDetails!
                                            .itemsData[widget.index!.toInt()]
                                            .decoration![0]
                                            .img2Url
                                            .toString();
                                  });
                                }
                              },
                              child: FadeInImage(
                                placeholder:
                                    const AssetImage('assets/gif/loading.gif'),
                                image: widget
                                            .newItemDetails!
                                            .itemsData[widget.index!.toInt()]
                                            .decoration![0]
                                            .img2Url !=
                                        null
                                    ? NetworkImage(BASE_URL2 +
                                        widget
                                            .newItemDetails!
                                            .itemsData[widget.index!.toInt()]
                                            .decoration![0]
                                            .img2Url
                                            .toString())
                                    : Image.asset(
                                            'assets/images/noImageAvaliable.jpg')
                                        .image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (widget
                                        .newItemDetails!
                                        .itemsData[widget.index!.toInt()]
                                        .decoration![0]
                                        .img3Url !=
                                    null) {
                                  setState(() {
                                    _largeImage = "" +
                                        widget
                                            .newItemDetails!
                                            .itemsData[widget.index!.toInt()]
                                            .decoration![0]
                                            .img3Url
                                            .toString();
                                  });
                                }
                              },
                              child: FadeInImage(
                                placeholder:
                                    const AssetImage('assets/gif/loading.gif'),
                                image: widget
                                            .newItemDetails!
                                            .itemsData[widget.index!.toInt()]
                                            .decoration![0]
                                            .img3Url !=
                                        null
                                    ? NetworkImage(BASE_URL2 +
                                        widget
                                            .newItemDetails!
                                            .itemsData[widget.index!.toInt()]
                                            .decoration![0]
                                            .img3Url
                                            .toString())
                                    : Image.asset(
                                            'assets/images/noImageAvaliable.jpg')
                                        .image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (widget
                                        .newItemDetails!
                                        .itemsData[widget.index!.toInt()]
                                        .decoration![0]
                                        .img4Url !=
                                    null) {
                                  setState(() {
                                    _largeImage = "" +
                                        widget
                                            .newItemDetails!
                                            .itemsData[widget.index!.toInt()]
                                            .decoration![0]
                                            .img4Url
                                            .toString();
                                  });
                                }
                              },
                              child: FadeInImage(
                                placeholder:
                                    const AssetImage('assets/gif/loading.gif'),
                                image: widget
                                            .newItemDetails!
                                            .itemsData[widget.index!.toInt()]
                                            .decoration![0]
                                            .img4Url !=
                                        null
                                    ? NetworkImage(BASE_URL2 +
                                        widget
                                            .newItemDetails!
                                            .itemsData[widget.index!.toInt()]
                                            .decoration![0]
                                            .img4Url
                                            .toString())
                                    : Image.asset(
                                            'assets/images/noImageAvaliable.jpg')
                                        .image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Build_Images_Items_End

                    //Build_Image_Details_Start
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ExpansionPanelList(
                        dividerColor: Colors.deepOrange[300],
                        elevation: 3.0,
                        animationDuration: const Duration(milliseconds: 600),
                        expansionCallback: (panelIndex, isExpanded) =>
                            cubit.changeExpandedWidget(),
                        children: [
                          ExpansionPanel(
                            canTapOnHeader: true,
                            backgroundColor: Colors.grey[300],
                            headerBuilder: (context, expanded) => ListTile(
                              title: Text(
                                'Product Details'.tr().toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              leading: const Icon(
                                Icons.person,
                                color: Colors.deepOrange,
                              ),
                            ),
                            body: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  AutoSizeText(widget
                                      .newItemDetails!
                                      .itemsData[widget.index!.toInt()]
                                      .description
                                      .toString()),
                                ],
                              ),
                            ),
                            isExpanded: cubit.isExpanded,
                          )
                        ],
                      ),
                    ),
                    AutoSizeText(
                      widget
                          .newItemDetails!.itemsData[widget.index!.toInt()].name
                          .toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: HexColor('#4E4E4E'),
                      ),
                      minFontSize: 12,
                      maxFontSize: 16,
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      widget.newItemDetails!.itemsData[widget.index!.toInt()]
                          .model
                          .toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      minFontSize: 10,
                      maxFontSize: 14,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        AutoSizeText(
                          'EGY  ' +
                              widget.newItemDetails!
                                  .itemsData[widget.index!.toInt()].price
                                  .toString() +
                              "   ",
                          style: TextStyle(
                            color: HexColor('#FF0000'),
                          ),
                          minFontSize: 12,
                          maxFontSize: 16,
                          maxLines: 1,
                        ),
                        AutoSizeText(
                          widget.newItemDetails!
                              .itemsData[widget.index!.toInt()].discountPrice
                              .toString(),
                          style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                          minFontSize: 12,
                          maxFontSize: 16,
                          maxLines: 1,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          Text(
                            'Colors :  '.tr().toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: HexColor('#072C3F'),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: 30,
                              width: double.infinity,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 5.0,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (context, index) => Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                        color: Colors.primaries[Random()
                                            .nextInt(Colors.primaries.length)],
                                        shape: BoxShape.circle)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Build_Image_Details_End

                    //Quantity_Button_Start
                    buildQuantityButton(cubit),
                    //Quantity_Button_End

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Divider(
                        thickness: 3.0,
                        color: HexColor('#E9E9E9'),
                      ),
                    ),
                    //Products_more_details_Start
                    Text(
                      'Product Detail'.tr().toString(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: HexColor('#4E4E4E')),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                'Category :'.tr().toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#072C3F'),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ' Home Furniture',
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: HexColor('#4E4E4E'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                'Barcode :'.tr().toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#072C3F'),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ' 52487523',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor('#4E4E4E')),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                'SKU :',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#072C3F'),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ' Shopin15894',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor('#4E4E4E')),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                'Brand :'.tr().toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#072C3F'),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Image.network(
                                      BASE_URL2 +
                                          widget
                                              .newItemDetails!
                                              .itemsData[widget.index!.toInt()]
                                              .brand!
                                              .brandPhotoUrl
                                              .toString(),
                                      height: 20.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //Last_Button_in_page_Start

                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        bottom: 10.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                color: HexColor('#F3F3F3'),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  cubit.addItemToFavourites(
                                      productId: widget.newItemDetails!
                                          .itemsData[widget.index!.toInt()].id
                                          .toString(),
                                      toDelete: "1");
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                              flex: 3,
                              child: Conditional.single(
                                  context: context,
                                  conditionBuilder: (context) => state
                                      is! AddOrRemoveOrUpdateToShoppingCartLoadingState,
                                  widgetBuilder: (context) => orangeButton(
                                        function: () {
                                          cubit
                                              .addOrUpdateOrRemoveToShoppingCart(
                                                  productId: widget
                                                      .newItemDetails!
                                                      .itemsData[
                                                          widget.index!.toInt()]
                                                      .id
                                                      .toString(),
                                                  quantity: cubit.quantityCount
                                                      .toString(),
                                                  toDelete: "0",
                                                  context: context);

                                          // if (state
                                          //         is! AddOrRemoveOrUpdateToShoppingCartLoadingState &&
                                          //     state
                                          //         is! AddOrRemoveOrUpdateToShoppingCartErrorState) {
                                          //   navigateTo(context, CartScreen());
                                          //   cubit.quantityCount = 1;
                                          // }
                                        },
                                        child: Text(
                                          'ADD TO BAG'.tr().toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                  fallbackBuilder: (context) => const Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.grey,
                                          color: Colors.deepOrange,
                                        ),
                                      ))),
                        ],
                      ),
                    ),
                    //Last_Button_in_page_End

                    //Products_more_details_End
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Divider(
                        thickness: 3.0,
                        color: HexColor('#E9E9E9'),
                      ),
                    ),

                    //Review__Start
                    Text(
                      'Review'.tr().toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#072C3F'),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    buildReviewItems(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Divider(
                        thickness: 2.5,
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      elevation: 2.0,
                      child: ListTile(
                        onTap: () {
                          navigateTo(
                              context, const VendorProfileWithCustomer());
                        },
                        leading: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://www.bentbusinessmarketing.com/wp-content/uploads/2013/02/35844588650_3ebd4096b1_b-1024x683.jpg')),
                        title: const Text('vendor name'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AutoSizeText(
                              'vendor company',
                              minFontSize: 12,
                              maxFontSize: 16,
                              maxLines: 1,
                            ),
                            Center(
                              child: MaterialButton(
                                color: Colors.deepOrange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                onPressed: () {
                                  navigateTo(
                                      context, const ChatWithVendorScreen());
                                },
                                child: Text(
                                  'Message sellar'.tr().toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    ),
                    //Review__End
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Divider(
                        thickness: 2.5,
                      ),
                    ),
                    //you_may_also_like_Start
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        'You May Also Like'.tr().toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#072C3F'),
                        ),
                      ),
                    ),
                    buildYouMayAlsoLikeItems(),
                    //you_may_also_like_End
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
