class Result<T> {
  Error? error;
  T? data;

  Result.error(this.error);

  Result.success(this.data);
}
