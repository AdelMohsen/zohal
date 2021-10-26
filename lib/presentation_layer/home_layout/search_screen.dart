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
import 'package:zohal/models/search/search_model.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          SearchModel? searchModel = cubit.searchModel;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading:  IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.deepOrange),),
              title: SizedBox(
                  height: 40.0,
                  child: defaultTextFormField(
                    contentPadding:
                        const EdgeInsetsDirectional.only(start: 5.0),
                    onFieldSubmitted: (text) {
                      if (text.isNotEmpty) {
                        cubit.searchData(text: text);
                      }
                    },
                    controller: searchController,
                    hintText: 'search'.tr().toString(),
                    keyboardType: TextInputType.text,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      borderSide: BorderSide.none,
                    ),
                  )),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  
                  if (state is SearchLoadingState)
                    const LinearProgressIndicator(
                      color: Colors.deepOrange,
                      backgroundColor: Colors.grey,
                    ),
                  const SizedBox(
                    height: 5.0,
                  ),
                 Conditional.single(context: context, 
                  conditionBuilder: (context)=>
                  searchModel != null && searchModel.itemsData.isNotEmpty ,
                   widgetBuilder: (context)=> Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SizedBox(
                                  height: 100.0,
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment:
                                              AlignmentDirectional.bottomStart,
                                          children: [
                                            Image(
                                                height: 100.0,
                                                width: 100.0,
                                                image: NetworkImage(BASE_URL2 +
                                                    searchModel!.itemsData[index]
                                                        .decoration![0].img1Url
                                                        .toString())),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                searchModel
                                                    .itemsData[index].name
                                                    .toString(),
                                                style: const TextStyle(
                                                  height: 1.25,
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                              const Spacer(),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      searchModel
                                                          .itemsData[index]
                                                          .price
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    const Spacer(),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                          separatorBuilder: (context, index) => const Divider(
                                color: Colors.black87,
                                height: 1,
                                thickness: 1,
                              ),
                          itemCount: searchModel!.itemsData.length),
                    ), 
                   fallbackBuilder: (context)=>  Center(child: Image.asset('assets/images/noData.png'))
                   ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
