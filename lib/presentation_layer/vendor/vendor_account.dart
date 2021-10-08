import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';

class VendorAccount extends StatelessWidget {
  const VendorAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text(
                'Account',
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
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                CircleAvatar(
                  backgroundImage: (cubit.vendorImage == null)
                      ? const NetworkImage(
                          'https://www.bentbusinessmarketing.com/wp-content/uploads/2013/02/35844588650_3ebd4096b1_b-1024x683.jpg')
                      : Image.file(cubit.vendorImage).image,
                  backgroundColor: Colors.orange,
                  minRadius: 40,
                  maxRadius: 80,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: orangeButton(
                              height: 30.0,
                              function: () {
                                buildBottomSheet(context, cubit);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.photo_camera_back,
                                    color: Colors.white,
                                  ),
                                  AutoSizeText(
                                    'Change photo',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    minFontSize: 9,
                                    maxFontSize: 15,
                                  ),
                                ],
                              ),
                            ))),
                    Expanded(
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: orangeButton(
                              height: 30,
                              function: () {
                                buildDialog(context, cubit);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.password,
                                    color: Colors.white,
                                  ),
                                  AutoSizeText(
                                    'Change Password',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    minFontSize: 9,
                                    maxFontSize: 15,
                                  ),
                                ],
                              ),
                            ))),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultTextFormField(
                          enabled: false,
                          hintText: 'First Name',
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(Icons.person)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultTextFormField(
                          enabled: false,
                          hintText: 'Last Name',
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(Icons.person)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultTextFormField(
                          enabled: false,
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(Icons.person)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultTextFormField(
                          enabled: false,
                          hintText: 'Address',
                          keyboardType: TextInputType.text,
                          prefixIcon: const Icon(Icons.home)),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ],
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
                    hintText: 'Current Password',
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
                      hintText: 'New Password',
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
                    hintText: 'Re-enter New Password',
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
            'Change Password',
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
              child: const Text(
                'Change Password',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            )
          ],
        ),
      );

  buildIosDialog(context, HomeCubit cubit) => showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          actions: [
            CupertinoButton(
                child: const Text(
                  'Change Password',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                onPressed: () {}),
          ],
          content: SingleChildScrollView(
            child: Form(
              key: cubit.vendorChangePasswordKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoTextFormFieldRow(
                    prefix: const Text('Enter text'),
                    placeholder: 'Enter text',
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: const Text('Enter text'),
                    placeholder: 'Enter text',
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: const Text('Enter text'),
                    placeholder: 'Enter text',
                  ),
                ],
              ),
            ),
          ),
          title: Text(
            'Change Password',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: primaryColor),
          ),
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
                        cubit.getVendorCameraImage(context);
                      },
                      child: Text(
                        'Camera',
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
                        cubit.getVendorGalleryImage(context);
                      },
                      child: Text(
                        'Gallery',
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
