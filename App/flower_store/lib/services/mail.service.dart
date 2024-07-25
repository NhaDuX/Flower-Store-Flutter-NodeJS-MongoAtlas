import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendEmail(String receiverEmail, String html, String subject) async {
  final smtpServer = gmail("l.q.h.bao@gmail.com", "oyea rszt tlma dfpw");

  final message = Message()
    ..from = const Address('noreply@gmail.com', '4ManFlower noreply')
    ..recipients.add(receiverEmail)
    ..subject = subject
    ..html = html;

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}