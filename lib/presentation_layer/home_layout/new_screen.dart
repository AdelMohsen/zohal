import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/end_point.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/models/products/new_items.dart';
import 'package:zohal/presentation_layer/products_details/products_details.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getNewItemsData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewItems? newItemsDetails = HomeCubit.get(context).newItems;
          return Conditional.single(
              context: context,
              conditionBuilder: (context) => newItemsDetails != null,
              widgetBuilder: (context) => StaggeredGridView.countBuilder(
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  itemCount: newItemsDetails!.itemsData.length,
                  itemBuilder: (context, index) =>
                      buildNewItemsPage(context, index, newItemsDetails),
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(1),),
              fallbackBuilder: (context) => const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                      color: Colors.deepOrange,
                    ),
                  ));
        },
      ),
    );
  }

  buildNewItemsPage(
    context,
    int index,
    NewItems? newItemDetails,
  ) =>
      SizedBox(
        height: 220,
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: InkWell(
                  onTap: () {
                    navigateTo(context, ProductsDetails(index, newItemDetails));
                  },
                  child: Hero(
                    tag: newItemDetails!.itemsData[index].id.toString(),
                    child: FadeInImage(
                      image: NetworkImage(
                        BASE_URL2 +
                            newItemDetails
                                .itemsData[index].decoration![0].img1Url
                                .toString(),
                      ),
                      fit: BoxFit.contain,
                      width: 148,
                      height: 108,
                      placeholder: const AssetImage('assets/gif/loading.gif'),
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AutoSizeText(
                      'EG ' +
                          newItemDetails.itemsData[index].price.toString() +
                          "  ",
                      style: TextStyle(
                        color: HexColor('#072C3F'),
                      ),
                      minFontSize: 8,
                      maxFontSize: 12,
                    ),
                    AutoSizeText(
                      newItemDetails.itemsData[index].discountPrice.toString(),
                      style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                      minFontSize: 7,
                      maxFontSize: 10,
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
      );
}
