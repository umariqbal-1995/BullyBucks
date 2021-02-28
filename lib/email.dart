
import 'package:enough_mail/enough_mail.dart';
import 'package:enough_mail/message_builder.dart';
import 'package:enough_mail/smtp/smtp_client.dart';
class Email {
  static void sendEmail(String sendTo, String subject, String body) async {
    final client = SmtpClient('gmail.com', isLogEnabled: true);
    try {
      await client.connectToServer("smtp.gmail.com", 465,
          isSecure: true);
      await client.ehlo();
      await client.login(
          'bullybucksemaildelivery@gmail.com', 'teygqlsivdkmezkx');
      final builder = MessageBuilder.prepareMultipartAlternativeMessage();
      builder.from = [
        MailAddress(
            'BullyBucks Email Delivery', 'bullybucksemaildelivery@gmail.com')
      ];
      builder.to = [MailAddress('', sendTo)];
      builder.subject = subject;
      builder.addTextPlain(body);
      final mimeMessage = builder.buildMimeMessage();
      final sendResponse = await client.sendMessage(mimeMessage);
      print('message sent: ${sendResponse.isOkStatus}');
    } on SmtpException catch (e) {
      print('SMTP failed with $e');
    }
  }
}