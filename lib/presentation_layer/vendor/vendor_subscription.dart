import 'dart:ui';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/models/vendor/vendor_subscribtion.dart';

class VendorSubscribtion extends StatelessWidget {
  const VendorSubscribtion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getSubScribtionData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          SubScribtionModel? subScribtionModel =
              HomeCubit.get(context).subScribtionModel;
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Text(
                  'Settings',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: primaryColor),
                ),
                centerTitle: true,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.deepOrange,
                    )),
              ),
              body: Conditional.single(
                  context: context,
                  conditionBuilder: (context) => subScribtionModel != null,
                  widgetBuilder: (context) => Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 25.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal:12.0),
                            child: Card(color: Colors.grey,
                                elevation: 5.0,
                                child: ListTile(
                                  isThreeLine: false,
                                  dense: true,
                                  leading: Icon(Icons.select_all,size: 30,color: Colors.white),
                                  subtitle: AutoSizeText('Ends At : 28/10/2021',style: TextStyle(color: Colors.black),),
                                  title: AutoSizeText(
                                    'Active subscribtion : plan 14',
                                    minFontSize: 14,
                                    maxFontSize: 18,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 25.0,
                                ),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Card(

                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          25.0,
                                        ),
                                      ),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    elevation: 4,
                                    color: Colors.deepOrangeAccent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        12,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 25,
                                            child: Icon(
                                              Icons.subscriptions_outlined,
                                              color: Colors.deepOrange,
                                              size: 30,
                                            ),
                                          ),
                                          Column(mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                           
                                              AutoSizeText(
                                                subScribtionModel!
                                                    .subScribtionData![index]
                                                    .name,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                minFontSize: 14,
                                                maxFontSize: 16,
                                              ),
                                              const SizedBox(height:10),
                                              AutoSizeText(
                                                subScribtionModel.subScribtionData![index].days + '   days'.tr(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                        minFontSize: 14,
                                                maxFontSize: 16,
                                              ),
                                              const SizedBox(height:10),
                                              AutoSizeText(
                                                subScribtionModel.subScribtionData![index].price + '  EGY',
                                                style:const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                        minFontSize: 14,
                                                maxFontSize: 16,
                                              ),
                                            ],
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: AutoSizeText(
                                                'Subscribe'.tr(),
                                                style: const TextStyle(
                                                    color: Colors.deepOrange,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                         minFontSize: 14,
                                                maxFontSize: 16,
                                              ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                Colors.white,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    32,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                  fallbackBuilder: (context) => const Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                          color: Colors.deepOrange))));
        },
      ),
    );
  }

  changeLanguageSheet(context) => showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          color: Colors.grey[300],
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Arabic',
                        style: TextStyle(
                            fontSize: 18,
                            color: primaryColor,
                            fontWeight: FontWeight.w500),
                      )),
                ),
                const Divider(
                  thickness: 3,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'English',
                        style: TextStyle(
                            fontSize: 18,
                            color: primaryColor,
                            fontWeight: FontWeight.w500),
                      )),
                ),
              ],
            ),
          ),
        ),
      );
}
