

String baseUrl = 'https://elwekala.onrender.com';

class ApiConstants {
  static String registerApi = '$baseUrl/user/register';
  static String loginApi = '$baseUrl/user/login';
  static String homeApi = '$baseUrl/product/Laptops';
  static String addCartApi = '$baseUrl/cart/add';
  static String getCartApi = '$baseUrl/cart/allProducts';
  static String deleteCartApi = '$baseUrl/cart/delete';
  static String updateCartApi = '$baseUrl/cart';
  static String getFavoritesApi = '$baseUrl/favorite';

  static String addFavoriteApi = '$baseUrl/favorite';
  static String deleteFavoriteApi = '$baseUrl/favorite';
  static String getProfileApi = '$baseUrl/user/profile';
  static String updateProfileApi = '$baseUrl/user/update';
  
}
