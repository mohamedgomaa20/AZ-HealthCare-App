
class EmailRequest {
  final String toEmail;
  final String subject;
  final String body;
  final List<String>? attachments;

  EmailRequest({
    required this.toEmail,
    required this.subject,
    required this.body,
    this.attachments,
  });

  Map<String, dynamic> toJson() {
    return {
      'toEmail': toEmail,
      'subject': subject,
      'body': body,
      'attachments': attachments,
    };
  }
}