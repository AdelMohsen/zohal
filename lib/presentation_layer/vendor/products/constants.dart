class MyServerConst {
  static const _BASE_URL = 'http://ecommerce.icon-ts.com/api';
  static const BASE_URL = 'http://ecommerce.icon-ts.com/';

//  static const _BASE_URL = 'http://localhost:3000/api';
  // static const BASE_URL = 'http://localhost:3000/';

  static const TMP_IMAGE = BASE_URL + 'storage/misc/loading.gif';

  //Auth
  static const LOGIN = '$_BASE_URL/auth/login';
  static const REGISTER = '$_BASE_URL/auth/register.php';
  static const USER_PROFILE = '$_BASE_URL/auth/profile_info';
  static const UPDATE_IMAGE = '$_BASE_URL/auth/profile_image';
  static const UPDATE_PROFILE = '$_BASE_URL/auth/profile_update';

  //Admins
  static const ADMINS_LIST = '$_BASE_URL/admins/list';
  static const ADMINS_ADD = '$_BASE_URL/admins/add';
  static const ADMINS_UPDATE = '$_BASE_URL/admins/update';
  static const ADMINS_DELETE = '$_BASE_URL/admins/delete';
  static const ADMINS_UPLOAD = '$_BASE_URL/admins/upload';
  static const ADMINS_DOC = '$_BASE_URL/admins/doc';
  static const ADMINS_SEARCH = '$_BASE_URL/admins/search';

  //Tech-Support
  static const TECH_LIST = '$_BASE_URL/tech-supports/list';
  static const TECH_ONLINE = '$_BASE_URL/tech-supports/online';
  static const TECH_ADD = '$_BASE_URL/tech-supports/add';
  static const TECH_UPDATE = '$_BASE_URL/tech-supports/update';
  static const TECH_DELETE = '$_BASE_URL/tech-supports/delete';
  static const TECH_UPLOAD = '$_BASE_URL/tech-supports/upload';
  static const TECH_SEARCH = '$_BASE_URL/tech-supports/search';

  //Category
  static const CATEGORY_LIST = '$_BASE_URL/categories/list';
  static const CATEGORY_ADD = '$_BASE_URL/categories/add';
  static const CATEGORY_UPDATE = '$_BASE_URL/categories/update';
  static const CATEGORY_DELETE = '$_BASE_URL/categories/delete';
  static const CATEGORY_UPLOAD = '$_BASE_URL/categories/upload';
  static const CATEGORY_SEARCH = '$_BASE_URL/categories/search';

  //Sections
  static const SECTIONS_LIST = '$_BASE_URL/sections/list';
  static const SECTIONS_ADD = '$_BASE_URL/sections/add';
  static const SECTIONS_UPDATE = '$_BASE_URL/sections/update';
  static const SECTIONS_DELETE = '$_BASE_URL/sections/delete';
  static const SECTIONS_UPLOAD = '$_BASE_URL/sections/upload';
  static const SECTIONS_SEARCH = '$_BASE_URL/sections/search';

  //Sub-Sections
  static const SUB_SECTIONS_LIST = '$_BASE_URL/sub-sections/list';
  static const SUB_SECTIONS_ADD = '$_BASE_URL/sub-sections/add';
  static const SUB_SECTIONS_UPDATE = '$_BASE_URL/sub-sections/update';
  static const SUB_SECTIONS_DELETE = '$_BASE_URL/sub-sections/delete';
  static const SUB_SECTIONS_SEARCH = '$_BASE_URL/sub-sections/search';

  //Brands
  static const BRANDS_LIST = '$_BASE_URL/brands/list';
  static const BRANDS_ADD = '$_BASE_URL/brands/add';
  static const BRANDS_UPDATE = '$_BASE_URL/brands/update';
  static const BRANDS_DELETE = '$_BASE_URL/brands/delete';
  static const BRANDS_UPLOAD = '$_BASE_URL/brands/upload';
  static const BRANDS_SEARCH = '$_BASE_URL/brands/search';

  //Shippings
  static const SHIPPINGS_LIST = '$_BASE_URL/shippings/list';
  static const SHIPPINGS_ADD = '$_BASE_URL/shippings/add';
  static const SHIPPINGS_UPDATE = '$_BASE_URL/shippings/update';
  static const SHIPPINGS_DELETE = '$_BASE_URL/shippings/delete';
  static const SHIPPINGS_UPLOAD = '$_BASE_URL/shippings/upload';
  static const SHIPPINGS_SEARCH = '$_BASE_URL/shippings/search';

  //Subscriptions
  static const SUBSCRIPTIONS_LIST = '$_BASE_URL/subscriptions/list';
  static const SUBSCRIPTIONS_ADD = '$_BASE_URL/subscriptions/add';
  static const SUBSCRIPTIONS_UPDATE = '$_BASE_URL/subscriptions/update';
  static const SUBSCRIPTIONS_DELETE = '$_BASE_URL/subscriptions/delete';
  static const SUBSCRIPTIONS_SEARCH = '$_BASE_URL/subscriptions/search';

  //Vendors
  static const VENDORS_LIST = '$_BASE_URL/vendors/list';
  static const VENDORS_ADD = '$_BASE_URL/vendors/add';
  static const VENDORS_UPDATE = '$_BASE_URL/vendors/update';
  static const VENDORS_DELETE = '$_BASE_URL/vendors/delete';
  static const VENDORS_DOC = '$_BASE_URL/vendors/doc';
  static const VENDORS_SEARCH = '$_BASE_URL/vendors/search';
  static const VENDORS_SUBSCRIPTION = '$_BASE_URL/vendors/subscriptions';
  static const VENDORS_PRODUCTS = '$_BASE_URL/vendors/products';
  static const VENDORS_ORDERS = '$_BASE_URL/vendors/orders';
  static const VENDORS_REFERRALS = '$_BASE_URL/vendors/referrals';
  static const VENDORS_UPLOAD = '$_BASE_URL/vendors/upload';

  //Customers
  static const CUSTOMERS_LIST = '$_BASE_URL/customers/list';
  static const CUSTOMERS_ADD = '$_BASE_URL/customers/add';
  static const CUSTOMERS_UPDATE = '$_BASE_URL/customers/update';
  static const CUSTOMERS_DELETE = '$_BASE_URL/customers/delete';
  static const CUSTOMERS_UPLOAD = '$_BASE_URL/customers/upload';
  static const CUSTOMERS_SEARCH = '$_BASE_URL/customers/search';
  static const CUSTOMERS_ORDERS = '$_BASE_URL/customers/orders';
  static const CUSTOMERS_CART = '$_BASE_URL/customers/cart';
  static const CUSTOMERS_PRODUCTS = '$_BASE_URL/customers/products';
  static const CUSTOMERS_FAVOURITES = '$_BASE_URL/customers/favourites';

  //Products
  static const PRODUCTS_LIST = '$_BASE_URL/products/list';
  static const PRODUCTS_DECO = '$_BASE_URL/products/decors';
  static const PRODUCTS_DECO_ADD = '$_BASE_URL/products/decors/add';
  static const PRODUCTS_DECO_UPDATE = '$_BASE_URL/products/decors/update';
  static const PRODUCTS_DECO_DELETE = '$_BASE_URL/products/decors/delete';
  static const PRODUCTS_ADD = '$_BASE_URL/products/add';
  static const PRODUCTS_UPDATE = '$_BASE_URL/products/update';
  static const PRODUCTS_DELETE = '$_BASE_URL/products/delete';
  static const PRODUCTS_SEARCH = '$_BASE_URL/products/search';
  static const PRODUCTS_SIZES = '$_BASE_URL/products/sizes';
  static const PRODUCTS_SIZE_ADD = '$_BASE_URL/products/sizes/add';
  static const PRODUCTS_SIZE_UPDATE = '$_BASE_URL/products/sizes/update';
  static const PRODUCTS_SIZE_DELETE = '$_BASE_URL/products/sizes/delete';

  //Ads
  static const ADS_LIST = '$_BASE_URL/ads/list';
  static const ADS_ADD = '$_BASE_URL/ads/add';
  static const ADS_UPDATE = '$_BASE_URL/ads/update';
  static const ADS_DELETE = '$_BASE_URL/ads/delete';
  static const ADS_UPLOAD = '$_BASE_URL/ads/upload';

  //Coupons
  static const COUPONS_LIST = '$_BASE_URL/coupons/list';
  static const COUPONS_ADD = '$_BASE_URL/coupons/add';
  static const COUPONS_UPDATE = '$_BASE_URL/coupons/update';
  static const COUPONS_DELETE = '$_BASE_URL/coupons/delete';

  //Orders
  static const ORDERS_ACTIVE = '$_BASE_URL/orders/active';
  static const ORDERS_HISTORY = '$_BASE_URL/orders/history';
  static const ORDERS_UPDATE = '$_BASE_URL/orders/update';

  //Logs
  static const LOGS_LIST = '$_BASE_URL/logs/list';
  static const LOGS_DELETE = '$_BASE_URL/logs/delete';

  //Settings
  static const SETTINGS_LATEST = '$_BASE_URL/settings/latest';
  static const SETTINGS_UPDATE = '$_BASE_URL/settings/update';
}
