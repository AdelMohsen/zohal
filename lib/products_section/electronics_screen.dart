import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/presentation_layer/authentication/signup_or_login.dart';
import 'package:zohal/presentation_layer/home_layout/cart_screen.dart';

class ElectronicsScreen extends StatelessWidget {
  const ElectronicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              title: AutoSizeText(
                'Electronics',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
                minFontSize: 14,
                maxFontSize: 18,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      if (type != 4) {
                        navigateTo(context, CartScreen());
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          animType: AnimType.TOPSLIDE,
                          title: 'You must login first...!'.tr().toString(),
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            navigateAndReplace(
                              context,
                              const SignupOrLogin(),
                            );
                          },
                          btnOkText: 'Go to login',
                          btnCancelText: 'Cancel'.tr().toString(),
                          btnOkColor: Colors.red,
                          btnCancelColor: const Color(0xFF00CA71),
                        ).show();
                      }
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.deepOrange,
                    ))
              ],
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.deepOrange,
                  )),
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
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
