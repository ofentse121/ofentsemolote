import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ReportIncidents extends StatefulWidget {
  const ReportIncidents({Key? key}) : super(key: key);

  @override
  _ReportIncidentsState createState() => _ReportIncidentsState();
}

class _ReportIncidentsState extends State<ReportIncidents> {
  final List<String> crime = [
    "Theft",
    "Vandalism",
    "Murder",
    "Bulling",
    "GBV & F",
    "Injury"
  ];
  String selectedCrime = "Theft";
  //Report button
  repot() async {
    String username = 'molepollefentse121@gmail.com';
    String password = 'fefe@121';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Reported Incidents')
      ..recipients.add('ofentsemolepolle121@gmail.com')
      // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Reporting incident ::  ${DateTime.now()}'
      // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          "<h1>$selectedCrime</h1>\n<p>Hey! Here's some HTML content</p>"; // body of email

    try {
      final sendReport = await send(message, smtpServer);

      print('Message sent: ' +
          sendReport.toString()); //print if the email is sent

    } on MailerException catch (e) {
      print('Message not sent. \n' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reporting Incidents"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "INCIDENT TYPE:",
              style: TextStyle(
                letterSpacing: 2,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 20),
            DropdownButton<String>(
              value: selectedCrime,
              onChanged: (value) {
                setState(() {
                  selectedCrime = value!;
                });
              },
              items: crime.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            MaterialButton(
                color: Colors.red,
                child: Text(
                  'Click To Report',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  repot();
                }),
          ],
        ),
      ),
    );
  }
}
