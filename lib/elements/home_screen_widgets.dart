import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/reuse_widget.dart';
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

buildCarousalImageItem(String urlImage) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
//Carousal_End

//Categories_Start
buildCategoriesItem() => SizedBox(
      height: 35,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
                width: 40,
                height: 35,
                child: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: HexColor('#195F82'),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10.0,
              ),
          itemCount: 7),
    );
//Categories_End

//New_Item_Start
buildNewItemProducts() => SizedBox(
      height: 220,
      width: double.infinity,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  navigateTo(context, const ProductsDetails());
                },
                child: SizedBox(
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
                            'assets/home/sofa.png',
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
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10.0,
              ),
          itemCount: 10),
    );
//New_Item_End

//TradeMarks_Start
buildTradeMarksItems() => SizedBox(
      height: 40,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
                width: 80,
                height: 40,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    'https://wallpaperbat.com/img/377921-samsung-galaxy-logo-wallpaper.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10.0,
              ),
          itemCount: 10),
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
