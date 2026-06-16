class ErrorResponse {
  final List<Error> errors;

  ErrorResponse({required this.errors});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    List<Error> errorsList = [];

    if (json['error'] != null) {
      errorsList = [Error.fromJson(json['error'])];
    } else if (json['errors'] != null && json['errors'] is List) {
      errorsList = List<Error>.from(json['errors'].map((x) => Error.fromJson(x)));
    }

    return ErrorResponse(errors: errorsList);
  }
}

class Error {
  final String message;
  Error({required this.message});

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(message: json['message']);
  }
}
