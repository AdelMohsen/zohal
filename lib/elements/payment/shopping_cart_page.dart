import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/reuse_widget.dart';

buildShoppingCartPage() => Column(
  children: [
    ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10.0, vertical: 10.0),
          child: Container(
            height: 110.0,
            decoration:
            BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Row(
              children: [
                const SizedBox(
                  width: 5.0,
                ),
                Image.asset(
                  'assets/checkout/blueSofa.png',
                  fit: BoxFit.cover,
                  width: 80,
                  height: 100,
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey,
                        height: 108.0,
                        width: 1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Modern sofa :',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#072C3F'),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'EGP2000',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: HexColor('#4E4E4E')),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Size : 40*50',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: HexColor('#4E4E4E')),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              'Color : Blue',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: HexColor('#4E4E4E')),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.remove_shopping_cart,
                                  color: HexColor('#FF6600'),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        itemCount: 5),
    const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Divider(
        thickness: 2.5,
      ),
    ),
    Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Sub Total',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: HexColor('#909090'),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          Expanded(
            child: Text(
              '2500',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: HexColor('#072C3F'),
              ),
            ),
          ),
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(
          top: 40.0, bottom: 100.0, left: 20.0, right: 20.0),
      child: orangeButton(
          function: () {},
          child: const Text(
            'CHECK OUT',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          )),
    )
  ],
);