import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';

buildQuantityButton(HomeCubit cubit) => Row(
      children: [
        AutoSizeText(
          'Quantity :  ',
          style: TextStyle(
            
            fontWeight: FontWeight.bold,
            color: HexColor('#072C3F'),
          ),
          minFontSize: 14
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
              cubit.decrementQuantity();
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
              cubit.quantityCount.toString(),
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
              cubit.incrementQuantity();
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

buildReviewItems() => LimitedBox(
      maxHeight: 250.0,
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.29)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'name',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#072C3F'),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Review',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            '11/8/2020',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                height: 5.0,
              ),
          itemCount: 5),
    );

buildYouMayAlsoLikeItems() => StaggeredGridView.countBuilder(
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
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
                      style:
                          TextStyle(color: HexColor('#072C3F'), fontSize: 15),
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
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      itemCount: 20,
    );
