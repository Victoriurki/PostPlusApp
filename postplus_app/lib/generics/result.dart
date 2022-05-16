class Result<T, E> {
  T? data;
  E? error;

  bool get hasError => error != null;

  Result({this.data, this.error});


}

enum Status { loading, success, failed }
