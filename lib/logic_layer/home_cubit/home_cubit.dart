import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/presentation_layer/home_layout/favourite_screen.dart';
import 'package:zohal/presentation_layer/home_layout/home_screen.dart';
import 'package:zohal/presentation_layer/home_layout/new_screen.dart';
import 'package:zohal/presentation_layer/home_layout/personal_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialHomeState());

  static HomeCubit get(context) => BlocProvider.of(context);

//BOTTOM NAVIGATION BAR START
  int currentIndex = 0;
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Shop'),
    BottomNavigationBarItem(icon: Icon(Icons.flash_on), label: 'New'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(HomeBottomNavState());
  }

  List<Widget> pages = [
    const HomeScreen(),
    const NewScreen(),
    const FavouritesScreen(),
    const PersonalScreen(),
  ];

//BOTTOM NAVIGATION BAR END

//HomeScreenStart
  var searchController = TextEditingController();
  int activeIndex = 0;

  changeActiveIndex(int index) {
    activeIndex = index;
    emit(ChangeActiveIndexSuccess());
  }

  List urlImage = [
    'https://specials-images.forbesimg.com/imageserve/5d95d03767dd830006a295b6/960x0.jpg?fit=scale',
    'https://i1.wp.com/handelskammer.blog/wp-content/uploads/2021/06/AdobeStock_e-commerce_2048x1280.jpg?fit=1440%2C900&ssl=1',
    'https://www.arageek.com/wp-content/uploads/2021/09/ecommerce.jpg',
  ];

//HomeScreen_End

//Details_Screen_Start

  int quantityCount = 1;

  void incrementQuantity() {
    quantityCount++;
    emit(IncrementQuantitySuccessState());
  }

  void decrementQuantity() {
    if (quantityCount != 0) {
      quantityCount--;
      emit(DecrementQuantitySuccessState());
    }
  }
}
