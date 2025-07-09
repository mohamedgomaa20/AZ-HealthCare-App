class EmailResponse {
  final int statusCode;
  final bool isSuccess;
  final List<String> errors;
  final EmailResult? result;

  EmailResponse({
    required this.statusCode,
    required this.isSuccess,
    required this.errors,
    this.result,
  });

  factory EmailResponse.fromJson(Map<String, dynamic> json) {
    return EmailResponse(
      statusCode: json['statusCode'] ?? 0,
      isSuccess: json['isSuccess'] ?? false,
      errors: List<String>.from(json['errors'] ?? []),
      result:
          json['result'] != null ? EmailResult.fromJson(json['result']) : null,
    );
  }
}

class EmailResult {
  final String toEmail;
  final String subject;
  final String body;
  final dynamic attachments;

  EmailResult({
    required this.toEmail,
    required this.subject,
    required this.body,
    this.attachments,
  });

  factory EmailResult.fromJson(Map<String, dynamic> json) {
    return EmailResult(
      toEmail: json['toEmail']?.toString().replaceAll('"', '') ?? '',
      subject: json['subject']?.toString().replaceAll('"', '') ?? '',
      body: json['body']?.toString().replaceAll('"', '') ?? '',
      attachments: json['attachments'],
    );
  }
}
