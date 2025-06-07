
 import '../../../models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String error;

  ShopErrorHomeDataState(this.error);
}

class ShopLoadingGetCategoriesState extends ShopStates {}

class ShopSuccessGetCategoriesState extends ShopStates {}

class ShopErrorGetCategoriesState extends ShopStates {
  final String error;

  ShopErrorGetCategoriesState(this.error);
}

class ShopLoadingChangeFavoritesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {
  final String error;

  ShopErrorChangeFavoritesState(this.error);
}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {
  final String error;

  ShopErrorGetFavoritesState(this.error);
}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  ShopLoginModel updateProfileModel;

  ShopSuccessUserDataState(this.updateProfileModel);
}

class ShopErrorUserDataState extends ShopStates {
  final String error;

  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  ShopLoginModel updateProfileModel;

  ShopSuccessUpdateUserState(this.updateProfileModel);
}

class ShopErrorUpdateUserState extends ShopStates {
  final String error;

  ShopErrorUpdateUserState(this.error);
}
class ShopSuccessGetUserDataState extends ShopStates {}

class ProductDetailsCarouselIndexState extends ShopStates { }
class ShopChangeCarouselIndexState extends ShopStates { }

///
class ShopLoadingState extends ShopStates {}

class ShopSuccessState extends ShopStates {}

class ShopErrorState extends ShopStates {}