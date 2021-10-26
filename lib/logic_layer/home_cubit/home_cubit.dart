import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zohal/constance/end_point.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/logic_layer/home_cubit/home_state.dart';
import 'package:zohal/logic_layer/shared_pref/shared_pref.dart';
import 'package:zohal/models/auth_model/get_user_data_model.dart';
import 'package:zohal/models/auth_model/login_model.dart';
import 'package:zohal/models/banners/banners_model.dart';
import 'package:zohal/models/brand/brand_model.dart';
import 'package:zohal/models/categories/categories_model.dart';
import 'package:zohal/models/favourites_model/favourites_model.dart';
import 'package:zohal/models/products/new_items.dart';
import 'package:zohal/models/search/search_model.dart';
import 'package:zohal/models/shopping_cart/shopping_cart.dart';
import 'package:zohal/models/vendor/vendor_subscribtion.dart';
import 'package:zohal/network/dio_helper.dart';
import 'package:zohal/presentation_layer/authentication/signup_or_login.dart';
import 'package:zohal/presentation_layer/home_layout/cart_screen.dart';
import 'package:zohal/presentation_layer/home_layout/favourite_screen.dart';
import 'package:zohal/presentation_layer/home_layout/home_nav_bar.dart';
import 'package:zohal/presentation_layer/home_layout/home_screen.dart';
import 'package:zohal/presentation_layer/home_layout/new_screen.dart';
import 'package:zohal/presentation_layer/home_layout/personal_screen.dart';
import 'package:path/path.dart' as p;
import 'package:http_parser/http_parser.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialHomeState());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserLogin? userLogin;

//Get_User_Data_Start
  getUserData() {
    emit(GetUserDataLoadingState());
    DioHelper.getData(
      url: USER_INFO,
      token: token,
    ).then((value) {
      userLogin = UserLogin.fromJson(value.data);

      emit(GetUserDataSuccessState(userLogin));
    }).catchError((error) {
      emit(GetUserDataErrorState(userLogin));
    });
  }

//Get_User_Data_End

//Get_Banners_Data_Start
  BannersModel? bannersModel1;

  getTopBannersData() {
    emit(GetTopBannersDataLoadingState());
    DioHelper.getData(url: TOP_BANNERS, token: token).then((value) {
      bannersModel1 = BannersModel.fromJson(value.data);
      emit(GetTopBannersDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTopBannersDataErrorState());
    });
  }

  BannersModel? bannersModel2;
  getMiddelBannersData() {
    emit(GetMiddelBannersDataLoadingState());
    DioHelper.getData(url: MIDDEL_BANNERS, token: token).then((value) {
      bannersModel2 = BannersModel.fromJson(value.data);
      emit(GetMiddelBannersDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetMiddelBannersDataErrorState());
    });
  }

  BannersModel? bannersModel3;
  getBottomBannersData() {
    emit(GetBottomBannersDataLoadingState());
    DioHelper.getData(url: BOTTOM_BANNERS, token: token).then((value) {
      bannersModel3 = BannersModel.fromJson(value.data);
      emit(GetBottomBannersDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetBottomBannersDataErrorState());
    });
  }

//Get_Banners_Data_End

//Get_New_Items_Data_Start
  NewItems? newItems;

  getNewItemsData() {
    emit(GetNewItemsDataLoadingState());
    DioHelper.getData(url: NEW_ITEMS, token: token).then((value) {
      newItems = NewItems.fromJson(value.data);
      // print(newItems!.itemsData[0].description);
      // print(newItems!.success);
      // print(newItems!.itemsData[0].brand!.brandName);
      // print(newItems!.itemsData[0].decoration![0].img1Url);
      emit(GetNewItemsDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetNewItemsDataErrorState());
    });
  }

//Get_New_Items_Data_Start

//Get_Brand_Icon_Start
  BrandModel? brandModel;

  getBrandIcon() {
    emit(GetBrandIconLoadingState());
    DioHelper.getData(url: BRAND_ICON, token: token).then((value) {
      brandModel = BrandModel.fromJson(value.data);
      // print(brandModel!.success);
      // print(brandModel!.brandData[0].brandName);
      // print(brandModel!.brandData[0].brandPhotoUrl);
      emit(GetBrandIconSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetBrandIconErrorState());
    });
  }

//Get_Brand_Icon_End

//Get_Categories_Icons_Start
  CategoriesModel? categoriesModel;

  getCategoriesIcon() {
    emit(GetCategoriesIconLoadingState());
    DioHelper.getData(url: CATEGORIES_ITEM, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // print(categoriesModel!.success);
      // print(categoriesModel!.categoriesData![0].categoriesName);
      // print(categoriesModel!.categoriesData![0].categoriesIconUrl);
      emit(GetCategoriesIconSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoriesIconErrorState());
    });
  }

//Get_Categories_Icons_End

//BOTTOM NAVIGATION BAR START
  int currentIndex = 0;
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Shop'),
    BottomNavigationBarItem(icon: Icon(Icons.flash_on), label: 'New'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
  ];

  List<BottomNavigationBarItem> visitorItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Shop'),
    BottomNavigationBarItem(icon: Icon(Icons.flash_on), label: 'New'),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(HomeBottomNavState());
  }

  List<Widget> pages = [
    const HomeScreen(),
    const NewScreen(),
    const FavouritesScreen(),
    PersonalScreen(),
  ];

  List<Widget> visitorPages = [
    const HomeScreen(),
    const NewScreen(),
  ];

//BOTTOM NAVIGATION BAR END

//HomeScreenStart
  var searchController = TextEditingController();
  int activeIndex = 0;

  changeActiveIndex(int index) {
    activeIndex = index;
    emit(ChangeActiveIndexSuccess());
  }

  signOut(context) {
    emit(SignOutLoadingState());
    CacheHelper.removeData(key: 'token').then((value) {
      navigateAndRemove(context, const SignupOrLogin());
      emit(SignOutSuccessState());
    }).catchError((error) {
      emit(SignOutErrorState());
    });
  }

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

  addOrUpdateOrRemoveToShoppingCart({
    required String productId,
    required String quantity,
    required String toDelete,
    required BuildContext context,
  }) {
    emit(AddOrRemoveOrUpdateToShoppingCartLoadingState());
    DioHelper.postData(
            url: ADD_OR_REMOVE_OR_UPDATE_SHOPPING_CART,
            data: {
              'productId': productId,
              'quantity': quantity,
              'toDelete': toDelete,
            },
            token: token.toString())
        .then((value) {
      if (value.data['success'] == 1) {
        Fluttertoast.showToast(
                msg: value.data['message'],
                backgroundColor: likeGreen,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_SHORT)
            .then((_) {
          quantityCount = 1;
          navigateAndReplace(context, CartScreen());
        });

        emit(AddOrRemoveOrUpdateToShoppingCartSuccessState());
      } else {
        Fluttertoast.showToast(
          msg: value.data['message'],
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
        );
        emit(AddOrRemoveOrUpdateToShoppingCartErrorState());
      }
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT);
      emit(AddOrRemoveOrUpdateToShoppingCartErrorState());
    });
  }

//Details_Screen_End

//Vendor_Account_Start
  var vendorCurrentPasswordController = TextEditingController();
  var vendorNewPasswordController = TextEditingController();
  var vendorReEnterNewPasswordController = TextEditingController();
  var vendorChangePasswordKey = GlobalKey<FormState>();

//Vendor_Account_Start

//image_picker
  File? customerImage;
  var picker = ImagePicker();

  Future<void> getCustomerGalleryImage({
    required BuildContext context,
    required String userId,
  }) async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      customerImage = File(pickedImage.path);
      emit(PickedVendorImageLoadingState());
      String fileName = pickedImage.name;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(customerImage!.path,
            filename: fileName,
            contentType: MediaType(
              'image',
              p
                  .extension(
                    pickedImage.path,
                  )
                  .substring(1),
            )),
      });
      DioHelper.postImage(
              url: UPDATE_IMAGE,
              userId: userId,
              token: token.toString(),
              data: formData)
          .then((value) {
        if (value.data['success'] == 0) {
          Fluttertoast.showToast(
              msg: value.data['message'],
              backgroundColor: Colors.red,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG);
          emit(PickedVendorImageSuccessState());
        } else {
          Fluttertoast.showToast(
              msg: value.data['message'],
              backgroundColor: likeGreen,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG);
          emit(PickedVendorImageSuccessState());
        }
      }).catchError((e) {
        Fluttertoast.showToast(
            msg: e.toString(),
            backgroundColor: Colors.red,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG);
        emit(PickedVendorImageErrorState());
      });

      emit(PickedVendorImageErrorState());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "You didn't choose a picture".tr(),
          ),
        ),
      );
      emit(PickedVendorImageErrorState());
    }
  }

  Future<void> getCustomerCameraImage({
    required BuildContext context,
    required String userId,
  }) async {
    var pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      customerImage = File(pickedImage.path);
      emit(PickedVendorImageLoadingState());
      String fileName = pickedImage.name;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(customerImage!.path,
            filename: fileName,
            contentType: MediaType(
              'image',
              p
                  .extension(
                    pickedImage.path,
                  )
                  .substring(1),
            )),
      });
      DioHelper.postImage(
              url: UPDATE_IMAGE,
              userId: userId,
              token: token.toString(),
              data: formData)
          .then((value) {
        if (value.data['success'] == 0) {
          Fluttertoast.showToast(
              msg: value.data['message'],
              backgroundColor: Colors.red,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG);
          emit(PickedVendorImageSuccessState());
        } else {
          imageCache?.clear();
          Fluttertoast.showToast(
              msg: value.data['message'],
              backgroundColor: likeGreen,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG);
          emit(PickedVendorImageSuccessState());
        }
      }).catchError((e) {
        Fluttertoast.showToast(
            msg: e.toString(),
            backgroundColor: Colors.red,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG);
        emit(PickedVendorImageErrorState());
      });

      emit(PickedVendorImageErrorState());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "You didn't choose a picture".tr(),
          ),
        ),
      );
      emit(PickedVendorImageErrorState());
    }
  }

//image_picker

//TODO:Vendor_SubScribtion_Start
  SubScribtionModel? subScribtionModel;
  getSubScribtionData() {
    emit(GetSubScribtionDataLoadingState());
    DioHelper.getData(url: SUB_SCRIPTION, token: token).then((value) {
      subScribtionModel = SubScribtionModel.fromJson(value.data);
      emit(GetSubScribtionDataSuccessState());
    }).catchError((error) {
      Fluttertoast.showToast(msg: error.toString());
      emit(GetSubScribtionDataErrorState());
    });
  }
//TODO:Vendor_SubScribtion_End

//VENDOR_IMAGE_START
  File? vendorImage;

  Future<void> getVendorGalleryImage(context) async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      customerImage = File(pickedImage.path);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Image Changed')));
      emit(PickedVendorImageSuccessState());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error has been occurred')));
      emit(PickedVendorImageErrorState());
    }
  }

  Future<void> getVendorCameraImage(context) async {
    var pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      customerImage = File(pickedImage.path);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Image Changed')));
      emit(PickedVendorImageSuccessState());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error has been occurred')));
      emit(PickedVendorImageErrorState());
    }
  }

//Check_Camera_Permission_Start
  late Permission permission;
  PermissionStatus permissionStatus = PermissionStatus.denied;

  void listenForCameraPermission(context, userId) async {
    final cameraStatus = await Permission.camera.status;
    permissionStatus = cameraStatus;
    emit(PermissionStatusGetValueSuccess());
    switch (cameraStatus) {
      case PermissionStatus.denied:
        requestForCameraPermission();
        break;
      case PermissionStatus.granted:
        getCustomerCameraImage(context: context, userId: userId);
        break;
      case PermissionStatus.limited:
        Navigator.pop(context);
        break;
      case PermissionStatus.permanentlyDenied:
        Navigator.pop(context);
        break;
      case PermissionStatus.restricted:
        Navigator.pop(context);
        break;
    }
  }

  Future<void> requestForCameraPermission() async {
    final status = await Permission.camera.request();
    permissionStatus = status;
    emit(PermissionStatusGetValueSuccess());
  }

//Check_Camera_Permission_End

//Check_Storage_Permission_Start
  late Permission storagePermission;
  PermissionStatus storagePermissionStatus = PermissionStatus.denied;

  void listenForStoragePermission({context, required String userId}) async {
    final storageStatus = await Permission.storage.status;
    storagePermissionStatus = storageStatus;
    emit(PermissionStatusGetValueSuccess());
    switch (storageStatus) {
      case PermissionStatus.denied:
        requestForStoragePermission();
        break;
      case PermissionStatus.granted:
        getCustomerGalleryImage(context: context, userId: userId);
        break;
      case PermissionStatus.limited:
        Navigator.pop(context);
        break;
      case PermissionStatus.permanentlyDenied:
        Navigator.pop(context);
        break;
      case PermissionStatus.restricted:
        Navigator.pop(context);
        break;
    }
  }

  Future<void> requestForStoragePermission() async {
    final status = await Permission.storage.request();
    storagePermissionStatus = status;
    emit(PermissionStatusGetValueSuccess());
  }

//Check_Storage_Permission_End

//Shopping_Cart_Start
  ShoppingCart? shoppingCart;

  getShoppingCartData() {
    emit(GetShoppingCartLoadingState());
    DioHelper.getData(
      url: SHOPPING_CART,
      token: token,
    ).then((value) {
      shoppingCart = ShoppingCart.fromJson(value.data);
      emit(GetShoppingCartSuccessState());
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      print(error.toString());
      emit(GetShoppingCartErrorState());
    });
  }

  deleteShoppingCartData() {
    emit(DeleteShoppingCartDataLoadingState());
    DioHelper.getData(url: DELETE_SHOPPING_CART, token: token).then((value) {
      if (value.data['success'] == 1) {
        Fluttertoast.showToast(
            msg: value.data['message'],
            backgroundColor: const Color(0xFF00CA71),
            toastLength: Toast.LENGTH_LONG);
        getShoppingCartData();
        emit(DeleteShoppingCartDataSuccessState());
      } else {
        Fluttertoast.showToast(
            msg: value.data['message'],
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_LONG);
        emit(DeleteShoppingCartDataErrorState());
      }
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG);
      emit(DeleteShoppingCartDataErrorState());
    });
  }

//Shopping_Cart_End

//Favourites_Start

  FavouritesModel? favouritesModel;

  getFavouritesData() {
    emit(GetFavouritesDataLoadingState());
    DioHelper.getData(
      url: GET_FAVOURITES,
      token: token,
    ).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      emit(GetFavouritesDataSuccessState());
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG);
      emit(GetFavouritesDataErrorState());
    });
  }

  addOrDeleteItemToFavourites(
      {required String productId, required String toDelete}) {
    emit(AddToFavouritesLoadingState());
    DioHelper.postData(
            url: ADD_TO_FAVOURITES,
            data: {
              "productId": productId,
              "toDelete": toDelete,
            },
            token: token.toString())
        .then((value) {
      if (value.data['success'] == 1) {
        Fluttertoast.showToast(
                msg: value.data['message'],
                backgroundColor: const Color(0xFF00CA71),
                toastLength: Toast.LENGTH_SHORT)
            .then((value) {
          if (toDelete == "1") {
            getFavouritesData();
          }
        });
        emit(AddToFavouritesSuccessState());
      } else {
        Fluttertoast.showToast(
            msg: value.data['message'],
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_SHORT);
        emit(AddToFavouritesErrorState());
      }
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG);
      emit(AddToFavouritesErrorState());
    });
  }

  deleteAllFromFavourites() {
    emit(DeleteAllFromFavouritesLoadingState());
    DioHelper.getData(url: DELETE_ALL_FAVOURITES, token: token).then((value) {
      if (value.data['success'] == 1) {
        Fluttertoast.showToast(
                msg: value.data['message'],
                backgroundColor: const Color(0xFF00CA71),
                toastLength: Toast.LENGTH_LONG)
            .then((value) {
          getFavouritesData();
          emit(DeleteAllFromFavouritesSuccessState());
        });
      } else {
        Fluttertoast.showToast(
            msg: value.data['message'],
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_LONG);
        emit(DeleteAllFromFavouritesErrorState());
      }
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG);
      emit(DeleteAllFromFavouritesErrorState());
    });
  }

//Favourites_End
//chats
  var chatController = TextEditingController();

//chats

//vendor_add_request
  var productImage;

  Future<void> vendorAddProductImageFromGallery(context) async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      productImage = File(pickedImage.path);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Image Changed')));
      emit(PickedVendorImageSuccessState());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error has been occurred')));
      emit(PickedVendorImageErrorState());
    }
  }

  Future<void> vendorAddProductImageFromCamera(context) async {
    var pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      productImage = File(pickedImage.path);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Image Changed')));
      emit(PickedVendorImageSuccessState());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error has been occurred')));
      emit(PickedVendorImageErrorState());
    }
  }

//Personal_Screen_Start
  bool isExpanded = false;

  var customerCurrentPasswordController = TextEditingController();
  var customerNewPasswordController = TextEditingController();
// var vendorReEnterNewPasswordController = TextEditingController();
  var customerChangePasswordKey = GlobalKey<FormState>();

  changeExpandedWidget() {
    isExpanded = !isExpanded;
    emit(ChangeExpandedWidgetSuccessState());
  }

  changeCustomerPassword({
    required String oldPassword,
    required String newPassword,
    required BuildContext context,
  }) {
    emit(ChangePersonalPasswordLoadingState());
    DioHelper.postData(
            url: PROFILE_UPDATE,
            data: {
              "passwords": {
                "oldPassword": oldPassword,
                "newPassword": newPassword,
              },
            },
            token: token.toString())
        .then((value) {
      if (value.data['success'] == 1) {
        Fluttertoast.showToast(
          msg: value.data['message'],
          backgroundColor: likeGreen,
          textColor: Colors.white,
        ).then((value) {
          Navigator.pop(context);
        });

        emit(ChangePersonalPasswordSuccessState());
      } else {
        Fluttertoast.showToast(
                msg: value.data['message'],
                backgroundColor: Colors.red,
                textColor: Colors.white)
            .then((value) {
          customerCurrentPasswordController.text = '';
          customerNewPasswordController.text = '';
        });
        emit(ChangePersonalPasswordErrorState());
      }
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          backgroundColor: Colors.red,
          textColor: Colors.white);

      emit(ChangePersonalPasswordErrorState());
    });
  }
  // FormData formData = FormData.fromMap({
  //   "image" : MultipartFile.fromBytes(value)
  // });
  // changeCustomerImage({required String userId,})async{
  //   DioHelper.postImage(url: PROFILE_IMAGE, userId: userId,
  //    token: token.toString(), data: formData);
  // }

//Personal_Screen_END

//Check_Connectivity_START
  Connectivity connectivity = Connectivity();
  bool? isOnline;

  startMonitoring() async {
    await initConnectivity();
    connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        isOnline = false;
        emit(CheckConnectivityIsNone());
      } else {
        await updateConnectionStatus().then((bool isConnected) {
          isOnline = isConnected;
          emit(StartMonitoringSuccessState());
        }).catchError((error) {
          print(error.toString());
          Fluttertoast.showToast(msg: error.toString());
          emit(StartMonitoringErrorState());
        });
      }
    });
  }

  Future<void> initConnectivity() async {
    try {
      var status = await connectivity.checkConnectivity();
      if (status == ConnectivityResult.none) {
        isOnline = false;
        emit(CheckConnectivityIsNone());
      } else {
        isOnline = true;
        emit(CheckConnectivityIsNotNone());
      }
    } on PlatformException catch (e) {
      print('plat form exception :' + e.toString());
      Fluttertoast.showToast(msg: e.toString());
      emit(CheckConnectivityError());
    }
  }

  Future<bool> updateConnectionStatus() async {
    bool isConnected = false;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('zohaal.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
        emit(CheckConnectivityIsNotNone());
      }
    } on SocketException catch (e) {
      isConnected = false;
      print('on socket exception :' + e.toString());
      Fluttertoast.showToast(msg: e.toString());
      emit(CheckConnectivityIsNone());
    }
    return isConnected;
  }

//Check_Connectivity_END

  changeLanguage() {
    emit(ChangeLanguageSuccessState());
  }

  //Get_User_Profile_Data_Start
  UserData? userData;

  getProfileData() {
    DioHelper.getData(
      url: PROFILE_INFO,
      token: token,
    ).then((value) {
      userData = UserData.fromJson(value.data);
      print(userData!.userInfo!.email);
      emit(GetProfileInfoSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProfileInfoErrorState(error));
    });
  }

//Update_Profile_Data_Start
  updateProfileData(Map<String, dynamic> data) {
    emit(UpdateProfileInfoLoadindState());
    DioHelper.postData(url: PROFILE_UPDATE, data: data, token: token.toString())
        .then((value) {
      if (value.data['success'] == 0) {
        Fluttertoast.showToast(
            msg: value.data['message'].toString(),
            backgroundColor: Colors.deepOrange,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG);
        emit(UpdateProfileInfoErrorState(value.data['message']));
      } else {
        Fluttertoast.showToast(
            msg: value.data['message'].toString(),
            backgroundColor: Colors.green,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG);
        emit(UpdateProfileInfoSuccessState(value.data['message']));
      }
    }).catchError((error) {
      print(error.toString());
      Fluttertoast.showToast(msg: error.toString());
      emit(UpdateProfileInfoErrorState(error.toString()));
    });
  }

//Get_User_Profile_Data_END
//VISITOR_LOGIN
  loginAsVisitor(context) {
    emit(LoginAsVisitorLoadingState());
    DioHelper.getVisitorToken(url: VISITOR_LOG_IN).then((value) {
      if (value.data['success'] == 1) {
        userData = UserData.fromJson(value.data);
        token = value.data['token']['id'];
        type = 4;
        navigateTo(context, HomeLayout());
        emit(LoginAsVisitorSuccessState(value.data['token']['id']));
      }
    }).catchError((error) {
      print(error.toString());
      emit(LoginAsVisitorErrorState());
    });
  }
//VISITOR_END

//Search_START
  SearchModel? searchModel;
  searchData({required text}) {
    emit(SearchLoadingState());
    DioHelper.postData(
            url: SEARCH_TEXT, data: {'name': text}, token: token.toString())
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.itemsData[0].name);
      emit(SearchSuccessState());
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      emit(SearchErrorState());
    });
  }

//Search_END
  getEmit() {
    emit(PersonalScreenChange());
  }
}
