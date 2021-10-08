import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/elements/drawer_widgets.dart';
import 'package:zohal/logic_layer/home_cubit/home_cubit.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.shopping_cart_outlined,
                    color: HexColor('#FF6600')),
              ),
            ],
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'May Alaa',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#124965')),
                ),
                Text(
                  'Mansoura,egypt',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: HexColor('#C0C0C0'),
                  ),
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
            titleSpacing: 10.0,
            leadingWidth: 50.0,
            leading: const IconButton(
              onPressed: null,
              icon: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.kxan.com/wp-content/uploads/sites/40/2021/03/Liza-Scott-surgery.jpg?w=800'),
              ),
            ),
            bottom: PreferredSize(
              child: Builder(builder: (context) {
                return Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(Icons.list_sharp),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: defaultTextFormField(
                            contentPadding:
                                const EdgeInsetsDirectional.only(start: 5.0),
                            controller: cubit.searchController,
                            hintText: 'search',
                            keyboardType: TextInputType.text,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1.0),
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 40.0,
                        child: Image.asset('assets/home/select.png'),
                        decoration: BoxDecoration(
                          color: HexColor('#FF6600'),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    )
                  ],
                );
              }),
              preferredSize: const Size.fromHeight(60.0),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: HexColor('#FF6600'),
              unselectedItemColor: HexColor('#C0C0C0'),
              items: cubit.items,
              currentIndex: cubit.currentIndex,
              onTap: (index) => cubit.changeIndex(index),
              type: BottomNavigationBarType.fixed),
          body: cubit.pages[cubit.currentIndex],
          drawer: buildFullDrawerWidget(),
        );
      },
    );
  }

  buildFullDrawerWidget() => SafeArea(
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          'Hello,MAY ALAA',
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
                  buildProgramAndFeaturesSection(),
                  const Divider(
                    thickness: 2.5,
                  ),
                  buildShopByDepartmentSection(),
                  const Divider(
                    thickness: 2.5,
                  ),
                  buildHelpAndSettingsSection(),
                ],
              ),
            ),
          ),
        ),
      );
}
