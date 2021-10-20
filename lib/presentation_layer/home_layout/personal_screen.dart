import 'dart:ui';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:zohal/constance/end_point.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/models/auth_model/get_user_data_model.dart';

class PersonalScreen extends StatelessWidget {
  var personalFirstNameController = TextEditingController();
  var personalLastNameController = TextEditingController();
  var personalEmailController = TextEditingController();
  var personalAddressController = TextEditingController();
  var personalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProfileData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          UserData? userData = HomeCubit.get(context).userData;
          var cubit = HomeCubit.get(context);
          if (state is GetProfileInfoSuccessState) {
            personalFirstNameController.text =
                userData!.userInfo!.firstName.toString();
            personalLastNameController.text =
                userData.userInfo!.lastName.toString();
            personalEmailController.text = userData.userInfo!.email.toString();
            personalAddressController.text =
                userData.userInfo!.address.toString();
          }
          return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                HomeCubit.get(context).userData != null,
            widgetBuilder: (context) => Scaffold(
              backgroundColor: Colors.white,
              body: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  CircleAvatar(
                    backgroundImage: (cubit.vendorImage == null)
                        ? NetworkImage(
                            BASE_URL2 + userData!.userInfo!.photoUrl.toString(),
                            scale: 2)
                        : Image.file(cubit.vendorImage).image,
                    backgroundColor: Colors.orange,
                    minRadius: 40,
                    maxRadius: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: orangeButton(
                                height: 30.0,
                                function: () {
                                  buildBottomSheet(context, cubit);
                                },
                                child: AutoSizeText(
                                  'Change photo'.tr().toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  minFontSize: 9,
                                  maxFontSize: 15,
                                ),
                              ))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: orangeButton(
                                height: 30,
                                function: () {
                                  buildDialog(context, cubit);
                                },
                                child: AutoSizeText(
                                  'Change Password'.tr().toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  minFontSize: 9,
                                  maxFontSize: 15,
                                  maxLines: 1,
                                ),
                              ))),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: ExpansionPanelList(
                      dividerColor: Colors.deepOrange[300],
                      elevation: 3.0,
                      animationDuration: const Duration(milliseconds: 600),
                      expansionCallback: (panelIndex, isExpanded) =>
                          cubit.changeExpandedWidget(),
                      children: [
                        ExpansionPanel(
                          canTapOnHeader: true,
                          backgroundColor: Colors.grey[300],
                          headerBuilder: (context, expanded) => ListTile(
                            title: Text(
                              'Personal Information'.tr().toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            leading: const Icon(
                              Icons.person,
                              color: Colors.deepOrange,
                            ),
                          ),
                          body: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: personalKey,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      defaultTextFormField(
                                        controller: personalFirstNameController,
                                        labelText: 'First Name',
                                        keyboardType: TextInputType.name,
                                        prefixIcon: const Icon(
                                          Icons.person,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      defaultTextFormField(
                                          controller:
                                              personalLastNameController,
                                          labelText: 'Last Name',
                                          keyboardType: TextInputType.name,
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: Colors.deepOrange,
                                          )),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      defaultTextFormField(
                                          controller: personalEmailController,
                                          labelText: 'Email',
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: Colors.deepOrange,
                                          )),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      defaultTextFormField(
                                          controller: personalAddressController,
                                          labelText: 'Address',
                                          keyboardType: TextInputType.text,
                                          prefixIcon: const Icon(
                                            Icons.home,
                                            color: Colors.deepOrange,
                                          )),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Conditional.single(
                                          context: context,
                                          conditionBuilder: (context) => state
                                              is! UpdateProfileInfoLoadindState,
                                          widgetBuilder: (context) =>
                                              orangeButton(
                                                  function: () {
                                                    if (personalKey
                                                                .currentState !=
                                                            null &&
                                                        personalKey
                                                            .currentState!
                                                            .validate()) {
                                                      Map<String, dynamic>
                                                          updateMap = {};

                                                      if (personalFirstNameController
                                                              .text !=
                                                          userData!.userInfo!
                                                              .firstName) {
                                                        updateMap['firstName'] =
                                                            personalFirstNameController
                                                                .text;
                                                      }
                                                      if (personalLastNameController
                                                              .text !=
                                                          userData.userInfo!
                                                              .lastName) {
                                                        updateMap['lastName'] =
                                                            personalLastNameController
                                                                .text;
                                                      }
                                                      if (personalEmailController
                                                              .text !=
                                                          userData.userInfo!
                                                              .email) {
                                                        updateMap['email'] =
                                                            personalEmailController
                                                                .text;
                                                      }
                                                      if (personalAddressController
                                                              .text !=
                                                          userData.userInfo!
                                                              .address) {
                                                        updateMap['address1'] =
                                                            personalAddressController
                                                                .text;
                                                      }
                                                      cubit.updateProfileData(
                                                          updateMap);
                                                    }
                                                  },
                                                  child: const AutoSizeText(
                                                    'save',
                                                    minFontSize: 13,
                                                    maxFontSize: 18,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                          fallbackBuilder: (context) =>
                                              const LinearProgressIndicator(
                                                backgroundColor: Colors.grey,
                                                color: Colors.deepOrange,
                                              )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isExpanded: cubit.isExpanded,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                    height: 300,
                    child: Card(
                      elevation: 5.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: 10.0,
                            ),
                            child: AutoSizeText(
                              'Services'.tr().toString(),
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500),
                              maxFontSize: 25,
                              minFontSize: 18,
                              maxLines: 1,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    CircleAvatar(
                                        backgroundColor: Colors.deepOrange,
                                        child: Icon(Icons.shop_2,
                                            color: Colors.white)),
                                    AutoSizeText(
                                      'Shipping Addresssss',
                                      maxLines: 2,
                                      minFontSize: 10,
                                      maxFontSize: 14,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    CircleAvatar(
                                        backgroundColor: Colors.deepOrange,
                                        child: Icon(Icons.shop_2,
                                            color: Colors.white)),
                                    AutoSizeText(
                                      'Shipping Addresssss',
                                      maxLines: 2,
                                      minFontSize: 10,
                                      maxFontSize: 14,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    CircleAvatar(
                                        backgroundColor: Colors.deepOrange,
                                        child: Icon(Icons.shop_2,
                                            color: Colors.white)),
                                    AutoSizeText(
                                      'Shipping Addresssss',
                                      maxLines: 2,
                                      minFontSize: 10,
                                      maxFontSize: 14,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    CircleAvatar(
                                        backgroundColor: Colors.deepOrange,
                                        child: Icon(Icons.shop_2,
                                            color: Colors.white)),
                                    AutoSizeText(
                                      'Shipping Addresssss',
                                      maxLines: 2,
                                      minFontSize: 10,
                                      maxFontSize: 14,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    CircleAvatar(
                                        backgroundColor: Colors.deepOrange,
                                        child: Icon(Icons.shop_2,
                                            color: Colors.white)),
                                    AutoSizeText(
                                      'Shipping Addresssss',
                                      maxLines: 2,
                                      minFontSize: 10,
                                      maxFontSize: 14,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    CircleAvatar(
                                        backgroundColor: Colors.deepOrange,
                                        child: Icon(Icons.shop_2,
                                            color: Colors.white)),
                                    AutoSizeText(
                                      'Shipping Addresssss',
                                      maxLines: 2,
                                      minFontSize: 10,
                                      maxFontSize: 14,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    CircleAvatar(
                                        backgroundColor: Colors.deepOrange,
                                        child: Icon(Icons.shop_2,
                                            color: Colors.white)),
                                    AutoSizeText(
                                      'Shipping Addresssss',
                                      maxLines: 2,
                                      minFontSize: 10,
                                      maxFontSize: 14,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    CircleAvatar(
                                        backgroundColor: Colors.deepOrange,
                                        child: Icon(Icons.shop_2,
                                            color: Colors.white)),
                                    AutoSizeText(
                                      'Shipping Addresssss',
                                      maxLines: 2,
                                      minFontSize: 10,
                                      maxFontSize: 14,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    CircleAvatar(
                                        backgroundColor: Colors.deepOrange,
                                        child: Icon(Icons.shop_2,
                                            color: Colors.white)),
                                    AutoSizeText(
                                      'Shipping Addresssss',
                                      maxLines: 2,
                                      minFontSize: 10,
                                      maxFontSize: 14,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            fallbackBuilder: (context) => const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                color: Colors.deepOrange,
              ),
            ),
          );
        },
      ),
    );
  }

  buildDialog(BuildContext context, HomeCubit cubit) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          content: SingleChildScrollView(
            child: Form(
              key: cubit.vendorChangePasswordKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  passwordTextFormField(
                    hintText: 'Current Password'.tr().toString(),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: cubit.vendorCurrentPasswordController,
                    fillColor: Colors.grey[300],
                    borderSide:
                        const BorderSide(color: Colors.deepOrange, width: 2),
                    focusBorderSide: const BorderSide(color: Colors.deepOrange),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  passwordTextFormField(
                      hintText: 'New Password'.tr().toString(),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      controller: cubit.vendorNewPasswordController,
                      borderSide:
                          const BorderSide(color: Colors.deepOrange, width: 2),
                      focusBorderSide:
                          const BorderSide(color: Colors.deepOrange),
                      fillColor: Colors.grey[300]),
                  const SizedBox(
                    height: 10.0,
                  ),
                  passwordTextFormField(
                    hintText: 'Re-enter New Password'.tr().toString(),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: cubit.vendorReEnterNewPasswordController,
                    borderSide:
                        const BorderSide(color: Colors.deepOrange, width: 2),
                    focusBorderSide: const BorderSide(color: Colors.deepOrange),
                    fillColor: Colors.grey[300],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
          title: Text(
            'Change Password'.tr().toString(),
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: primaryColor),
          ),
          actions: [
            orangeButton(
              function: () {
                if (cubit.vendorChangePasswordKey.currentState!.validate()) {
                  print('done');
                }
              },
              child: Text(
                'Change Password'.tr().toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            )
          ],
        ),
      );

  buildBottomSheet(BuildContext context, HomeCubit cubit) =>
      showModalBottomSheet(
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
                      onPressed: () {
                        cubit.listenForCameraPermission(context);
                      },
                      child: Text(
                        'Camera'.tr().toString(),
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
                      onPressed: () {
                        cubit.getCustomerGalleryImage(context);
                      },
                      child: Text(
                        'Gallery'.tr().toString(),
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
