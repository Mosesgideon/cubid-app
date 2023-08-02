import 'package:flutter/material.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';
import 'package:social_media/features/authentication/presentation/widgets/textfield_widget.dart';
class ReportIssue extends StatefulWidget {
  const ReportIssue({Key? key}) : super(key: key);

  @override
  State<ReportIssue> createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title:  Text(
          "Report Issue",
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [

            const Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 8,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: OutlinedFormField(

                      maxLine: 7,
                      hint: 'Drop your report',
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),


                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  CustomButton(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                      child: const Text("Send Report"), onPressed: () {}),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      " ",
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
