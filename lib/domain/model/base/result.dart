class Result<T> {

  Error? _error;
  T? data;

  setException(Error error) {
    _error = error;
  }

  setData(T data) {
    this.data = data;
  }

  get getException {
    return _error;
  }
}
