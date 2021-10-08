import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';

class ElectronicsScreen extends StatelessWidget {
  const ElectronicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Electronics',
                style: TextStyle(
                  fontSize: 18,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.orange,
                    ))
              ],
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      )),
                ],
              ),
              leadingWidth: MediaQuery.of(context).size.width / 3,
            ),
            body: ListView(
              children: [
                buildElectronicsScreenItems(),
              ],
            ));
      },
    );
  }

  buildElectronicsScreenItems() => StaggeredGridView.countBuilder(
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        padding: const EdgeInsets.only(
          top: 15.0,
          left: 5.0,
          right: 5.0,
        ),
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
        itemCount: 10,
      );
}
