class StatusCode {
  static const int errorUnknownCode = -99;

  static const int errorJsonDecode = -100;

  static const int ok = 200;

  static const int networkError = -1;

  static const errorCode401 = 401;

  static const errorCode402 = 402;

  static const int errorCode500 = 500;

  static const int errorCode503 = 503;

  static const int errorCode502 = 502;

  static const int permissionError = -2;

  static const int openFileError = -3;

  static Set<int> get networkErrors => {
        networkError,
      };

  static Set<int> get serverError => {
        errorCode500,
        errorCode503,
        errorCode502,
      };
}
