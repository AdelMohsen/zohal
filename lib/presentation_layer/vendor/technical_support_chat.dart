import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';

class TechnicalSupportChats extends StatelessWidget {
  const TechnicalSupportChats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text(
                'chat with technical support agent',
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
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * .5),
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: const BorderRadiusDirectional.only(
                                  bottomStart: Radius.circular(0.0),
                                  bottomEnd: Radius.circular(10.0),
                                  topEnd: Radius.circular(10.0),
                                  topStart: Radius.circular(10.0))),
                          child: const Text(
                              'technical support  with you how i can help you ...?'),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * .5),
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.all(12.0),
                          decoration: const BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadiusDirectional.only(
                                  bottomStart: Radius.circular(10.0),
                                  bottomEnd: Radius.circular(0.0),
                                  topEnd: Radius.circular(10.0),
                                  topStart: Radius.circular(10.0))),
                          child: const Text(
                              'i have a problem and i need you to think with me to reach solve'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.grey)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cubit.chatController,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsetsDirectional.only(start: 5.0),
                              border: InputBorder.none,
                              hintText: 'type your message..',
                              hintStyle: Theme.of(context).textTheme.caption),
                        ),
                      ),
                      MaterialButton(
                        height: 50.0,
                        color: Colors.lightBlueAccent,
                        minWidth: 1.0,
                        onPressed: () {},
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      )
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
}
