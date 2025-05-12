class ApiResponse {
  dynamic content;
  String errorMessage;

  ApiResponse({required this.content, this.errorMessage = ""});
}
