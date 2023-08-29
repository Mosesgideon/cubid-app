import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';
import 'package:social_media/features/authentication/presentation/widgets/textfield_widget.dart';

class ReportIssue extends StatefulWidget {
  const ReportIssue({Key? key}) : super(key: key);

  @override
  State<ReportIssue> createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  final reportcontroller = TextEditingController();
  final store = FirebaseFirestore.instance;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Report Issue",
          style: TextStyle(color: Theme
              .of(context)
              .colorScheme
              .onBackground),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [

            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 8,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: OutlinedFormField(

                      maxLine: 7,
                      controller: reportcontroller,
                      hint: 'Drop your report',
                    ),
                  ),
                  const SizedBox(
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
                      child: isloading ? const SizedBox(height: 25, width: 25,
                        child: CircularProgressIndicator(),) : Text(
                          "Send Report"), onPressed: () {
                    sendReport();
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "report will be reviewed ",
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onBackground,
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

  Future<void> sendReport() async {
    CollectionReference report = FirebaseFirestore.instance.collection(
        'reports');

    CollectionReference abuse =
    FirebaseFirestore.instance.collection('report');

    // Call the user's CollectionReference to add a new report
    return await report
        .add({
      'abusetype': reportcontroller,

    })

        .then((value) => print("report added"))
        .catchError((error) =>
    {
      setState(() {
        isloading = false;
      }),
      print('failed')
    }
    );
  }
}
















