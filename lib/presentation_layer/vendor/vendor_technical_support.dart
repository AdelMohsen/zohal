import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/presentation_layer/vendor/technical_support_chat.dart';

class VendorTechnicalSupport extends StatelessWidget {
  const VendorTechnicalSupport({Key? key}) : super(key: key);

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
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text(
                'Technical Support',
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
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundColor: primaryColor,
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                            )),
                        title: const Text('mohamed ahmed'),
                        subtitle: const Text('mohamed_ahmed@zohal.com'),
                        onTap: (){
                          navigateTo(context, const TechnicalSupportChats());
                        },
                      ),
                    ),
                separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Divider(
                        thickness: 3,
                      ),
                    ),
                itemCount: 10),
          );
        },
      ),
    );
  }
}
