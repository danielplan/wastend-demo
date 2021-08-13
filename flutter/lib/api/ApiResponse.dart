class ApiResponse {
  dynamic data;
  List<String>? errors = [];
  bool success = false;
  bool? failed = false;

  ApiResponse({required this.success, this.data, this.errors, this.failed});
}
