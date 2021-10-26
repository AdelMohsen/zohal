import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/end_point.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/models/auth_model/get_user_data_model.dart';
import 'package:zohal/models/brand/brand_model.dart';
import 'package:zohal/models/categories/categories_model.dart';
import 'package:zohal/models/products/new_items.dart';
import 'package:zohal/presentation_layer/products_details/products_details.dart';

//Carousal_Start
carousalLoaderWidget(context) => SizedBox(
      height: 133,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            margin:
                const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).focusColor.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5)),
              ],
            ),
            child: Image.asset(
              'assets/home/loading.gif',
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
//Carousal_End

//Categories_Start
buildCategoriesItem(CategoriesModel? categoriesModel) => SizedBox(
      height: 35,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
                width: 40,
                height: 35,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/gif/loading.gif',
                  image: BASE_URL2 +
                      categoriesModel!.categoriesData![index].categoriesIconUrl
                          .toString(),
                  fit: BoxFit.contain,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: HexColor('#195F82'),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10.0,
              ),
          itemCount: categoriesModel!.categoriesData!.length),
    );
//Categories_End

//New_Item_Start
buildNewItemProducts(NewItems? newItemDetails, BuildContext context,
        HomeStates state, HomeCubit cubit)=>
    Builder(builder: (context) {
       
      return SizedBox(
        height: 220,
        width: double.infinity,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => SizedBox(
                  height: 220,
                  width: 160,
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: InkWell(
                            onTap: () {
                              navigateTo(context,
                                  ProductsDetails(index, newItemDetails));
                            },
                            child: Hero(
                              tag: newItemDetails!.itemsData[index].id
                                  .toString(),
                              child: FadeInImage(
                                image: NetworkImage(
                                  BASE_URL2 +
                                      newItemDetails.itemsData[index]
                                          .decoration![0].img1Url
                                          .toString(),
                                ),
                                fit: BoxFit.contain,
                                width: 148,
                                height: 108,
                                placeholder:
                                    const AssetImage('assets/gif/loading.gif'),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              top: 10.0, bottom: 10.0, start: 5.0),
                          child: Center(
                            child: Text(
                              newItemDetails.itemsData[index].name.toString(),
                              style: TextStyle(
                                color: HexColor('#8A8A8A'),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 4.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AutoSizeText(
                                'EG ' +
                                    newItemDetails.itemsData[index].price
                                        .toString() +
                                    "  ",
                                style: TextStyle(
                                  color: HexColor('#072C3F'),
                                ),
                                minFontSize: 8,
                                maxFontSize: 12,
                              ),
                              AutoSizeText(
                                newItemDetails.itemsData[index].discountPrice
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                                minFontSize: 7,
                                maxFontSize: 10,
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color:  HexColor('#8B8B8B') ,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            separatorBuilder: (context, index) => const SizedBox(
                  width: 10.0,
                ),
            itemCount: 4),
      );
    });
//New_Item_End

//TradeMarks_Start
buildTradeMarksItems(BrandModel? brandModel) => SizedBox(
      height: 40,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
                width: 80,
                height: 40,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/gif/loading.gif',
                    image: BASE_URL2 +
                        brandModel!.brandData[index].brandPhotoUrl.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10.0,
              ),
          itemCount: brandModel!.brandData.length),
    );
//TradeMarks_End

//Popular_Item_Start
buildPopularItemProducts() => SizedBox(
      height: 220,
      width: double.infinity,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => SizedBox(
                height: 220,
                width: 160,
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/home/bag.png',
                          fit: BoxFit.cover,
                          width: 148,
                          height: 108,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: Text(
                            'bink bag',
                            style: TextStyle(
                              color: HexColor('#8A8A8A'),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'EG 1500',
                              style: TextStyle(
                                  color: HexColor('#072C3F'), fontSize: 15),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: HexColor('#8B8B8B'),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10.0,
              ),
          itemCount: 10),
    );
//Popular_Item_End

//Special_Offer_Start
buildCardForSpecialOffer() => SizedBox(
      height: 125,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                height: 125,
                child: ClipRRect(
                  child: Image.asset(
                    'assets/home/shoseOffer.png',
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 20.0,
              ),
          itemCount: 10),
    );

buildSpecialOfferItemProducts() => SizedBox(
      height: 220,
      width: double.infinity,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => SizedBox(
                height: 220,
                width: 160,
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/home/pinkSofa.png',
                          fit: BoxFit.cover,
                          width: 148,
                          height: 108,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: Text(
                            'Modern Sofe',
                            style: TextStyle(
                              color: HexColor('#8A8A8A'),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'EG 1500',
                              style: TextStyle(
                                  color: HexColor('#072C3F'), fontSize: 15),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: HexColor('#8B8B8B'),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10.0,
              ),
          itemCount: 10),
    );
//Special_Offer_End

//Electronics_Item_Start
buildElectronicsItemProducts() => SizedBox(
      height: 220,
      width: double.infinity,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => SizedBox(
                height: 220,
                width: 160,
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/home/headphone.png',
                          fit: BoxFit.cover,
                          width: 148,
                          height: 108,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: Text(
                            'Headphone',
                            style: TextStyle(
                              color: HexColor('#8A8A8A'),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'EG 1500',
                              style: TextStyle(
                                  color: HexColor('#072C3F'), fontSize: 15),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: HexColor('#8B8B8B'),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10.0,
              ),
          itemCount: 10),
    );
//Electronics_Item_End

//Bags_Item_Start
buildBagsItemProduct() => SizedBox(
      height: 220,
      width: double.infinity,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => SizedBox(
                height: 220,
                width: 160,
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/home/orangeBag.png',
                          fit: BoxFit.cover,
                          width: 148,
                          height: 108,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: Text(
                            'Bag',
                            style: TextStyle(
                              color: HexColor('#8A8A8A'),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'EG 1500',
                              style: TextStyle(
                                  color: HexColor('#072C3F'), fontSize: 15),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: HexColor('#8B8B8B'),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10.0,
              ),
          itemCount: 10),
    );

buildCardUnderBagsItemProducts() => SizedBox(
      height: 125,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                height: 125,
                child: ClipRRect(
                  child: Image.asset(
                    'assets/home/redShose.png',
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 20.0,
              ),
          itemCount: 10),
    );
//Bags_Item_End
