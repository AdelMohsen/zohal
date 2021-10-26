import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/end_point.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/elements/drawer_widgets.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/models/auth_model/get_user_data_model.dart';
import 'package:zohal/models/categories/categories_model.dart';
import 'package:zohal/models/search/search_model.dart';
import 'package:zohal/presentation_layer/authentication/signup_or_login.dart';
import 'package:zohal/presentation_layer/home_layout/cart_screen.dart';
import 'package:zohal/presentation_layer/home_layout/home_screen.dart';
import 'package:zohal/presentation_layer/home_layout/search_screen.dart';
import 'package:zohal/products_section/electronics_screen.dart';

class HomeLayout extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        if (type == 4) {
          return HomeCubit()..startMonitoring();
        } else {
          return HomeCubit()..getProfileData();
        }
      },
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is GetProfileInfoSuccessState) {
            HomeCubit.get(context).getCategoriesIcon();
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
      
          CategoriesModel? categoriesModel =
              HomeCubit.get(context).categoriesModel;
          var cubit = HomeCubit.get(context);
          if (cubit.isOnline != null) {
            return cubit.isOnline == true
                ? Conditional.single(
                    context: context,
                    conditionBuilder: (context) => type != 4
                        ? userAuthCubit != null
                        : state is StartMonitoringSuccessState,
                    widgetBuilder: (context) => Scaffold(
                        backgroundColor: Colors.white,
                        appBar: cubit.currentIndex != 3 &&
                                cubit.currentIndex != 2
                            ? AppBar(
                                elevation: 0.0,
                                backgroundColor: Colors.white,
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
                                          title: 'You must login first...!'
                                              .tr()
                                              .toString(),
                                          btnCancelOnPress: () {},
                                          btnOkOnPress: () {
                                            navigateAndReplace(
                                              context,
                                              const SignupOrLogin(),
                                            );
                                          },
                                          btnOkText: 'Go to login',
                                          btnCancelText:
                                              'Cancel'.tr().toString(),
                                          btnOkColor: Colors.red,
                                          btnCancelColor:
                                              const Color(0xFF00CA71),
                                        ).show();
                                      }
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
                                      type != 4
                                          ? userAuthCubit!.userInfo!.firstName
                                              .toString()
                                          : 'visitor',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor('#124965')),
                                    ),
                                    Text(
                                      type != 4
                                          ? userAuthCubit!.userInfo!.address
                                              .toString()
                                          : " ",
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
                                    type != 4
                                        ? BASE_URL2 +
                                            userAuthCubit!.userInfo!.photoUrl
                                                .toString() +
                                            refreshUrl
                                        : "https://img.freepik.com/free-icon/important-person_318-10744.jpg?size=338&ext=jpg",
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
                                            child:InkWell(onTap: (){
                                               navigateTo(
                                                  context,
                                                  SearchScreen());
                                            },child:defaultTextFormField(
                                              enabled: false,
                                              contentPadding:
                                                  const EdgeInsetsDirectional
                                                      .only(start: 5.0),
                                             
                                              hintText:'Search',
                                              hintStyle: const TextStyle(color: Colors.black),
                                              keyboardType:
                                                  TextInputType.text,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        1.0),
                                                borderSide: BorderSide.none,
                                              ),
                                            )),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        InkWell(onTap: (){
                                          navigateTo(context,SearchScreen());
                                        },
                                          child: Container(
                                            height: 40.0,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            child: const Icon(Icons.search,
                                                color: Colors.white),
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
                            : null,
                        bottomNavigationBar: BottomNavigationBar(
                            selectedItemColor: HexColor('#FF6600'),
                            unselectedItemColor: HexColor('#C0C0C0'),
                            items: type != 4 ? cubit.items : cubit.visitorItems,
                            currentIndex: cubit.currentIndex,
                            onTap: (index) => cubit.changeIndex(index),
                            type: BottomNavigationBarType.fixed),
                        body: type != 4
                                ? cubit.pages[cubit.currentIndex]
                                : cubit.visitorPages[cubit.currentIndex],
                        drawer: buildFullDrawerWidget(
                            cubit, context, userAuthCubit, categoriesModel)),
                    fallbackBuilder: (context) => const Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.grey,
                            color: Colors.deepOrange)),
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

  buildFullDrawerWidget(HomeCubit cubit, context, UserData? userAuthCubit,
          CategoriesModel? categoriesModel) =>
      SafeArea(
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
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
                            type != 4
                                ? 'Hello'.tr().toString() +
                                    userAuthCubit!.userInfo!.firstName
                                        .toString() +
                                    userAuthCubit.userInfo!.lastName.toString()
                                : 'Hello Visitor'.tr().toString(),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        'Shop By Department'.tr().toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#072C3F'),
                        ),
                      ),
                    ),
                  ],
                ),
                Conditional.single(
                    context: context,
                    conditionBuilder: (context) => categoriesModel != null,
                    widgetBuilder: (context) => Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => ListTile(
                              title: drawerText(
                                  text: categoriesModel!
                                      .categoriesData![index].categoriesName
                                      .toString()),
                              trailing: drawerIcon(),
                            ),
                            itemCount: categoriesModel!.categoriesData!.length,
                          ),
                        ),
                    fallbackBuilder: (context) => const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.grey,
                            color: Colors.deepOrange,
                          ),
                        )),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        'Help & Setting'.tr().toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#072C3F'),
                        ),
                      ),
                    ),
                    ListTile(
                      title: drawerText(text: 'Your Account'.tr().toString()),
                      trailing: drawerIcon(),
                    ),
                    ListTile(
                      title: drawerText(text: 'About website'.tr().toString()),
                      trailing: drawerIcon(),
                    ),
                    ListTile(
                      title: drawerText(text: 'Services'.tr().toString()),
                      trailing: drawerIcon(),
                    ),
                    ListTile(
                      title: drawerText(text: 'Contact us'.tr().toString()),
                      trailing: drawerIcon(),
                    ),
                    ListTile(
                      title: drawerText(text: 'English'.tr().toString()),
                      leading: IconButton(
                          onPressed: null,
                          icon: Image.asset('assets/home/outline.png')),
                      onTap: () async {
                        context.setLocale(const Locale('en'));
                        navigateAndRemove(context, HomeLayout());
                      },
                    ),
                    ListTile(
                      title: drawerText(text: 'Arabic'.tr().toString()),
                      leading: IconButton(
                          onPressed: null,
                          icon: Image.asset('assets/home/egypt.png')),
                      onTap: () async {
                        context.setLocale(const Locale('ar'));
                        navigateAndRemove(context, HomeLayout());
                      },
                    ),
                    ListTile(
                      title:
                          drawerText(text: 'Customer Services'.tr().toString()),
                    ),
                    ListTile(
                      title: drawerText(text: 'Sign Out'.tr().toString()),
                      onTap: () {
                        cubit.signOut(context);
                      },
                    )
                  ],
                )
              ],
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

  buildSearchList(
    HomeStates state,
    SearchModel? searchModel,
  ) =>
      Column(
        children: [
          if (state is SearchLoadingState)
            const LinearProgressIndicator(
              color: Colors.deepOrange,
              backgroundColor: Colors.grey,
            ),
          const SizedBox(
            height: 5.0,
          ),
          if (state is SearchSuccessState && searchModel != null)
            Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          height: 100.0,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.bottomStart,
                                  children: [
                                    Image(
                                        height: 100.0,
                                        width: 100.0,
                                        image: NetworkImage(BASE_URL2 +
                                            searchModel.itemsData[index]
                                                .decoration![0].img1Url
                                                .toString())),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        searchModel.itemsData[index].name
                                            .toString(),
                                        style: const TextStyle(
                                          height: 1.25,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      const Spacer(),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                              searchModel.itemsData[index].price
                                                  .toString(),
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 15),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.black87,
                        height: 1,
                        thickness: 1,
                      ),
                  itemCount: searchModel.itemsData.length),
            )
        ],
      );
}
