import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';

class VendorAccounting extends StatelessWidget {
  const VendorAccounting({Key? key}) : super(key: key);

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
                itemBuilder: (context, index) => ListTile(
                      leading: const Icon(Icons.event),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Order count : 210'),
                          Text('Profit : 2200 EGP'),
                        ],
                      ),
                      subtitle: const Text('20-10-2021'),
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
