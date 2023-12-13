class ApiResponse {
  // _data will hold any response converted into 
  // its own object. For example user.
  Object? _data; // Use ? to denote nullable if you want them to be nullable
  // _apiError will hold the error object
  Object? _apiError;

  ApiResponse([Object? data, Object? error])
      : _data = data,
        _apiError = error;

  Object? get data => _data;
  set data(Object? data) => _data = data;

  Object? get apiError => _apiError;
  set apiError(Object? error) => _apiError = error;
}
