class Result<T> {
  Status status;
  T? data;
  String? message;
  String? tag;

  Result.idle() : status = Status.idle;

  Result.isLoading() : status = Status.loading;

  Result.isError(this.message) : status = Status.error;

  Result.isSuccess({this.data, this.tag}) : status = Status.success;

  Result.isEmpty({this.message}) : status = Status.empty;

  @override
  String toString() {
    return 'Resources{status: $status, data: $data, message: $message, tag: $tag}';
  }
}

enum Status { idle, loading, error, success, empty }