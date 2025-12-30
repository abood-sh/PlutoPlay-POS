class ApiConstanta {
  static const String apiBaseUrl = 'https://loarien.com/api/v1/pos';
  static const String login = '/login';
  static const String cart = '/cart';
  static const String addRFid = '/cart/add-rfid';
  static const String systemsSettings = '/system/settings';
  static const String applyDiscount = '/cart/discount';
  static String clearOneCartItem(String cartItemId) => '/cart/item/$cartItemId';
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
