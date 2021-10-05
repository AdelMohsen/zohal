import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/elements/products_details_widgets.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';

class ProductsDetails extends StatelessWidget {
  const ProductsDetails({Key? key}) : super(key: key);

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
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: HexColor('#FF6600'),
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Build_Images_Items_Start
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.asset(
                      'assets/home/sofa.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 230,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 80.0,
                    child: StaggeredGridView.countBuilder(
                      itemCount: 4,
                      crossAxisCount: 4,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Image.asset(
                          'assets/home/sofa.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      staggeredTileBuilder: (index) =>
                          const StaggeredTile.fit(1),
                    ),
                  ),
                  //Build_Images_Items_End

                  //Build_Image_Details_Start
                  Text(
                    'Modern Sofe',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: HexColor('#4E4E4E')),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'EGY2500',
                    style: TextStyle(fontSize: 16, color: HexColor('#FF0000')),
                  ),
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Text(
                          'Colors :  ',
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
                    'Product Detail',
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
                        child: Text(
                          'Category :',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#072C3F'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          ' Home Furniture',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: HexColor('#4E4E4E')),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: Text(
                          'Barcode :',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#072C3F'),
                          ),
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
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'SKU :',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#072C3F'),
                          ),
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
                      const Spacer(),
                      Expanded(
                        child: Text(
                          'Brand :',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#072C3F'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          ' Casio',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: HexColor('#4E4E4E')),
                        ),
                      ),
                    ],
                  ),
                  //Products_more_details_End
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(
                      thickness: 3.0,
                      color: HexColor('#E9E9E9'),
                    ),
                  ),

                  //Review__Start
                  Text(
                    'Review',
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
                  //Review__End

                  //you_may_also_like_Start
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'You May Also Like',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#072C3F'),
                      ),
                    ),
                  ),
                  buildYouMayAlsoLikeItems(),
                  //you_may_also_like_End

                  //Last_Button_in_page_Start
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                              onPressed: () {},
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
                          child: orangeButton(
                            function: () {},
                            child: const Text(
                              'ADD TO BAG',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Last_Button_in_page_End
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
