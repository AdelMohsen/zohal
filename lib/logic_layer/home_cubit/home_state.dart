import 'package:zohal/models/auth_model/login_model.dart';

abstract class HomeStates {}

class InitialHomeState extends HomeStates {}

class HomeBottomNavState extends HomeStates {}

class ChangeActiveIndexSuccess extends HomeStates {}

class IncrementQuantitySuccessState extends HomeStates {}

class DecrementQuantitySuccessState extends HomeStates {}

class PickedVendorImageSuccessState extends HomeStates {}

class PickedVendorImageErrorState extends HomeStates {}

class ChangeImageSuccess extends HomeStates {}

class SignOutLoadingState extends HomeStates {}

class SignOutSuccessState extends HomeStates {}

class SignOutErrorState extends HomeStates {}

class GetUserDataLoadingState extends HomeStates {}

class GetUserDataSuccessState extends HomeStates {
  UserLogin? userLogin;

  GetUserDataSuccessState(this.userLogin);
}

class GetUserDataErrorState extends HomeStates {
  UserLogin? userLogin;

  GetUserDataErrorState(this.userLogin);
}

class ChangeExpandedWidgetSuccessState extends HomeStates {}

class GetBannersDataLoadingState extends HomeStates {}

class GetBannersDataSuccessState extends HomeStates {}

class GetBannersDataErrorState extends HomeStates {}

class GetNewItemsDataLoadingState extends HomeStates {}

class GetNewItemsDataSuccessState extends HomeStates {}

class GetNewItemsDataErrorState extends HomeStates {}

class GetBrandIconLoadingState extends HomeStates {}

class GetBrandIconSuccessState extends HomeStates {}

class GetBrandIconErrorState extends HomeStates {}

class GetCategoriesIconLoadingState extends HomeStates {}

class GetCategoriesIconSuccessState extends HomeStates {}

class GetCategoriesIconErrorState extends HomeStates {}

class ClearLargeProductDetailsImage extends HomeStates {}

class CheckConnectivityIsNone extends HomeStates {}

class CheckConnectivityIsNotNone extends HomeStates {}

class CheckConnectivityError extends HomeStates {}

class StartMonitoringSuccessState extends HomeStates {}

class StartMonitoringErrorState extends HomeStates {}

class ChangeLanguageSuccessState extends HomeStates {}

class GetProfileInfoSuccessState extends HomeStates {}

class GetProfileInfoErrorState extends HomeStates {
  dynamic error;

  GetProfileInfoErrorState(this.error);
}

class PersonalScreenChange extends HomeStates {}

class PermissionStatusGetValueSuccess extends HomeStates {}

class UpdateProfileInfoLoadindState extends HomeStates {}

class UpdateProfileInfoSuccessState extends HomeStates {
  String message;

  UpdateProfileInfoSuccessState(this.message);
}

class UpdateProfileInfoErrorState extends HomeStates {
  String errorMsg;

  UpdateProfileInfoErrorState(this.errorMsg);
}

class GetShoppingCartLoadingState extends HomeStates {}

class GetShoppingCartSuccessState extends HomeStates {}

class GetShoppingCartErrorState extends HomeStates {}

class ChangeTotalPriceValueSuccess extends HomeStates {}

class DeleteShoppingCartDataLoadingState extends HomeStates {}

class DeleteShoppingCartDataSuccessState extends HomeStates {}

class DeleteShoppingCartDataErrorState extends HomeStates {}

class AddOrRemoveOrUpdateToShoppingCartLoadingState extends HomeStates {}

class AddOrRemoveOrUpdateToShoppingCartSuccessState extends HomeStates {}

class AddOrRemoveOrUpdateToShoppingCartErrorState extends HomeStates {}

class GetFavouritesDataLoadingState extends HomeStates {}

class GetFavouritesDataSuccessState extends HomeStates {}

class GetFavouritesDataErrorState extends HomeStates {}

class AddToFavouritesLoadingState extends HomeStates {}

class AddToFavouritesSuccessState extends HomeStates {}

class AddToFavouritesErrorState extends HomeStates {}
