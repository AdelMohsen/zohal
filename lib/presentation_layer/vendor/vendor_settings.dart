import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';

class VendorSettings extends StatelessWidget {
  const VendorSettings({Key? key}) : super(key: key);

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
            body: Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: orangeButton(
                        function: () {
                          changeLanguageSheet(context);
                        },
                        child: const Text(
                          'Change Language',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )))),
          );
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
