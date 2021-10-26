import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/presentation_layer/home_layout/home_nav_bar.dart';
import 'package:zohal/products_section/electronics_screen.dart';

buildHelpAndSettingsSection(HomeCubit cubit, BuildContext context) =>
    BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
              //      ListView.builder(itemBuilder: (context,index)=>,itemCount: 5,),
                    ListTile(
                      title: drawerText(text: 'Home'.tr().toString()),
                      trailing: drawerIcon(),
                    ),
                    ListTile(
                      title: drawerText(text: 'Women'.tr().toString()),
                      trailing: drawerIcon(),
                    ),
                    ListTile(
                      title: drawerText(text: 'Men'.tr().toString()),
                      trailing: drawerIcon(),
                    ),
                    ListTile(
                      title: drawerText(text: 'Children'.tr().toString()),
                      trailing: drawerIcon(),
                    ),
                    ListTile(
                      title: drawerText(text: 'Toys'.tr().toString()),
                      trailing: drawerIcon(),
                    ),
                    ListTile(
                      title: drawerText(text: 'Sports'.tr().toString()),
                      trailing: drawerIcon(),
                    ),
                    ListTile(
                      title: drawerText(text: 'Electronics'.tr().toString()),
                      trailing: drawerIcon(),
                      onTap: () {
                        navigateTo(context, const ElectronicsScreen());
                      },
                    ),
                    ListTile(
                      title:
                          drawerText(text: 'Health and beauty'.tr().toString()),
                      trailing: drawerIcon(),
                    ),
                  ],
                ),
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
                  title: drawerText(text: 'Customer Services'.tr().toString()),
                ),
                ListTile(
                  title: drawerText(text: 'Sign Out'.tr().toString()),
                  onTap: () {
                    cubit.signOut(context);
                  },
                ),
              ],
            );
          }),
    );
