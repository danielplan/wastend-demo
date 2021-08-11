class ApiResponse {
  dynamic data;
  List<String>? errors = [];
  bool success = false;

  ApiResponse({required this.success, this.data, this.errors});
}
