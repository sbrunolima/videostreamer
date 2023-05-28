import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

//Widgets
import '../profile_screen/profile_option_buttons.dart';
import '../widgets/close_buttom.dart';

class ReportButtom extends StatefulWidget {
  @override
  State<ReportButtom> createState() => _ReportButtomState();
}

class _ReportButtomState extends State<ReportButtom> {
  List<String> attachments = [];
  bool isHTML = false;
  //Set the recipient email
  final String _recipientController = '';
  //Set the subject title
  String _subjectController = 'New Report';
  String _bodyController = '';

  //Opens the email app to send the new report
  Future<void> send() async {
    final Email email = Email(
      body: _bodyController,
      subject: _subjectController,
      recipients: [_recipientController],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'Success';
    } catch (error) {
      print('Email send ERROR $error');
      platformResponse = error.toString();
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        send();
      },
      child: OptionButton(title: 'Send a Report'),
    );
  }
}
