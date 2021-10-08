import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/presentation_layer/vendor/vendor_account.dart';
import 'package:zohal/presentation_layer/vendor/vendor_accounting.dart';
import 'package:zohal/presentation_layer/vendor/vendor_add_request.dart';
import 'package:zohal/presentation_layer/vendor/vendor_dashboard.dart';
import 'package:zohal/presentation_layer/vendor/vendor_history.dart';
import 'package:zohal/presentation_layer/vendor/vendor_referrals.dart';
import 'package:zohal/presentation_layer/vendor/vendor_settings.dart';
import 'package:zohal/presentation_layer/vendor/vendor_technical_support.dart';

class VendorHomeScreen extends StatelessWidget {
  const VendorHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: Builder(builder: (context) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(
                      Icons.reorder,
                      color: Colors.deepOrange,
                    ));
              }),
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text(
                'VENDOR',
                style: TextStyle(
                  fontSize: 18,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              centerTitle: true,
            ),
            drawer: Drawer(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SafeArea(
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        height: 44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Hello,Vendor',
                              style: TextStyle(
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
                        height: 5.0,
                      ),
                      const Divider(
                        thickness: 2.5,
                      ),
                      ListTile(
                        title: drawerText(text: 'Dashboard'),
                        trailing: drawerIcon(),
                        leading: const Icon(Icons.dashboard),
                        onTap: () {
                          navigateTo(context, const VendorDashboard());
                        },
                      ),
                      ListTile(
                        title: drawerText(text: 'Account'),
                        trailing: drawerIcon(),
                        leading: const Icon(Icons.account_box_outlined),
                        onTap: () {
                          navigateTo(context, const VendorAccount());
                        },
                      ),
                      ListTile(
                        title: drawerText(text: 'Settings'),
                        trailing: drawerIcon(),
                        leading: const Icon(Icons.settings),
                        onTap: () {
                          navigateTo(context, const VendorSettings());
                        },
                      ),
                      ListTile(
                        title: drawerText(text: 'Orders'),
                        trailing: drawerIcon(),
                        leading: const Icon(Icons.reorder),
                      ),
                      ListTile(
                        title: drawerText(text: 'History'),
                        trailing: drawerIcon(),
                        leading: const Icon(Icons.history),
                        onTap: () {
                          navigateTo(context, const VendorHistory());
                        },
                      ),
                      ListTile(
                        title: drawerText(text: 'Referrals'),
                        trailing: drawerIcon(),
                        leading: const Icon(Icons.details),
                        onTap: () {
                          navigateTo(context, const VendorReferrals());
                        },
                      ),
                      ListTile(
                        title: drawerText(text: 'Add Request'),
                        trailing: drawerIcon(),
                        leading: const Icon(Icons.add),
                        onTap: () {
                          navigateTo(context, const VendorAddRequest());
                        },
                      ),
                      ListTile(
                        title: drawerText(text: 'Accounting'),
                        trailing: drawerIcon(),
                        leading: const Icon(Icons.money),
                        onTap: () {
                          navigateTo(context, const VendorAccounting());
                        },
                      ),
                      ListTile(
                        title: drawerText(text: 'Technical Support'),
                        trailing: drawerIcon(),
                        leading: const Icon(Icons.support_agent),
                        onTap: () {
                          navigateTo(context, const VendorTechnicalSupport());
                        },
                      ),
                      ListTile(
                        title: drawerText(text: 'Logout'),
                        trailing: drawerIcon(),
                        leading: const Icon(Icons.logout),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
