import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/end_point.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/elements/drawer_widgets.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/models/auth_model/get_user_data_model.dart';
import 'package:zohal/presentation_layer/home_layout/cart_screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProfileData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is GetProfileInfoSuccessState) {
            HomeCubit.get(context).startMonitoring();
          }
          if (state is GetProfileInfoErrorState) {
            Fluttertoast.showToast(
                msg: state.error.toString(), toastLength: Toast.LENGTH_LONG);
            HomeCubit.get(context).getProfileData();
          }
        },
        builder: (context, state) {
          UserData? userAuthCubit = HomeCubit.get(context).userData;
          var cubit = HomeCubit.get(context);
          if (cubit.isOnline != null) {
            return cubit.isOnline == true
                ? Scaffold(
                    backgroundColor: Colors.white,
                    appBar: cubit.currentIndex != 3
                        ? AppBar(
                            elevation: 0.0,
                            backgroundColor: Colors.white,
                            actions: [
                              IconButton(
                                onPressed: () {
                                  navigateTo(context,  CartScreen());
                                },
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: HexColor('#FF6600'),
                                ),
                              ),
                            ],
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userAuthCubit!.userInfo!.firstName.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: HexColor('#124965')),
                                ),
                                Text(
                                  userAuthCubit.userInfo!.address.toString(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: HexColor('#C0C0C0'),
                                  ),
                                ),
                              ],
                              mainAxisSize: MainAxisSize.min,
                            ),
                            titleSpacing: 10.0,
                            leadingWidth: 50.0,
                            leading: IconButton(
                              onPressed: null,
                              icon: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                BASE_URL2 +
                                    userAuthCubit.userInfo!.photoUrl.toString(),
                              )),
                            ),
                            bottom: PreferredSize(
                              child: Builder(builder: (context) {
                                return Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Scaffold.of(context).openDrawer();
                                      },
                                      icon: const Icon(Icons.list_sharp),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 40,
                                        child: defaultTextFormField(
                                            contentPadding:
                                                const EdgeInsetsDirectional
                                                    .only(start: 5.0),
                                            controller: cubit.searchController,
                                            hintText: 'search'.tr().toString(),
                                            keyboardType: TextInputType.text,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(1.0),
                                              borderSide: BorderSide.none,
                                            )),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 40.0,
                                        child: Image.asset(
                                            'assets/home/select.png'),
                                        decoration: BoxDecoration(
                                          color: HexColor('#FF6600'),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }),
                              preferredSize: const Size.fromHeight(60.0),
                            ),
                          )
                        : AppBar(
                            backgroundColor: Colors.white,
                            elevation: 0.0,
                          ),
                    bottomNavigationBar: BottomNavigationBar(
                        selectedItemColor: HexColor('#FF6600'),
                        unselectedItemColor: HexColor('#C0C0C0'),
                        items: cubit.items,
                        currentIndex: cubit.currentIndex,
                        onTap: (index) => cubit.changeIndex(index),
                        type: BottomNavigationBarType.fixed),
                    body: cubit.pages[cubit.currentIndex],
                    drawer:
                        buildFullDrawerWidget(cubit, context, userAuthCubit),
                  )
                : noInternet(context);
          } else {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.deepOrange,
                  backgroundColor: Colors.grey,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  buildFullDrawerWidget(HomeCubit cubit, context, UserData? userAuthCubit) =>
      SafeArea(
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 44,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Hello'.tr().toString() +
                              userAuthCubit!.userInfo!.firstName.toString() +
                              userAuthCubit.userInfo!.lastName.toString(),
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: HexColor('#FF6600')),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Divider(
                    thickness: 2.5,
                  ),
                  buildHelpAndSettingsSection(cubit, context),
                ],
              ),
            ),
          ),
        ),
      );

  noInternet(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/images/error404.png',
              height: MediaQuery.of(context).size.height * .5,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            const AutoSizeText(
              'check your internet connection ....!',
              style: TextStyle(
                  color: Colors.deepOrange, fontWeight: FontWeight.w500),
              minFontSize: 18,
              maxFontSize: 25,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
