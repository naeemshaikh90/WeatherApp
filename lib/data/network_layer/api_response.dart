class ApiResponse<T> {
  bool success;
  String message;
  T data;

  ApiResponse({
    this.success,
    this.message,
    this.data,
  });
}
