import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';

class VendorAddRequest extends StatelessWidget {
  const VendorAddRequest({Key? key}) : super(key: key);

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
                'Accounting',
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
            body: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Card(
                      elevation: 3.0,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                            ),
                            child: Image.asset(
                              'assets/home/shoseOffer.png',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * .60,
                              height: 100,
                            ),
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const AutoSizeText(
                                'days : 23',
                                maxFontSize: 12,
                                minFontSize: 8,
                              ),
                              const AutoSizeText(
                                'time stamp : 30/10/2021',
                                maxFontSize: 12,
                                minFontSize: 8,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  AutoSizeText(
                                    'Status :',
                                    maxFontSize: 12,
                                    minFontSize: 8,
                                  ),
                                  AutoSizeText(
                                    'pending',
                                    maxFontSize: 12,
                                    minFontSize: 8,
                                  ),
                                  Icon(
                                    Icons.pending,
                                    color: Colors.yellow,
                                  ),
                                ],
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Divider(),
                    ),
                itemCount: 10),
            floatingActionButton: FloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: () {
                buildAddRequestItem(context, cubit);
              },
              child: const Icon(
                Icons.add,
                size: 25,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  buildAddRequestItem(context, HomeCubit cubit) => showDialog(
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image(
                      image: cubit.productImage == null
                          ? const AssetImage('assets/home/shoseOffer.png')
                          : Image.file(cubit.productImage).image,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextButton(
                    onPressed: () {
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
                                        cubit.vendorAddProductImageFromCamera(
                                            context);
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
                                     //   cubit.getCustomerGalleryImage(context);
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
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.photo_camera_back,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        Text(
                          'choose image',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    enabled: false,
                    decoration: const InputDecoration(hintText: 'days'),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        color: primaryColor,
                        onPressed: () {},
                        child: const AutoSizeText(
                          'add',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          minFontSize: 8,
                          maxFontSize: 12,
                        ),
                      ),
                      MaterialButton(
                        color: primaryColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const AutoSizeText(
                          'cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          minFontSize: 8,
                          maxFontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          title: Text(
            'Add ads',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: primaryColor),
          ),
        ),
      );
}
