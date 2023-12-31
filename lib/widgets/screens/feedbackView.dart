import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stocks_tracker/helpers/email_helper.dart';
import 'package:stocks_tracker/helpers/images/image_helper.dart';
import 'package:stocks_tracker/themes/custom_colors.dart';
import 'package:stocks_tracker/widgets/components/custom_back_button.dart';
import 'package:stocks_tracker/widgets/components/custom_button.dart';

final _formKeyMessage = GlobalKey<FormState>();
final _formKeyEmail = GlobalKey<FormState>();
final _formKeySubject = GlobalKey<FormState>();

class FeedbackView extends StatelessWidget {
  FeedbackView({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<void> _send() async => await EmailHelper.launchEmailSubmission(
          toEmail: 'phamninhhoang697@gmail.com',
          subject: subjectController.text,
          body: textController.text,
          errorCallback: () => showDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              content: Text(
                'Some error has occured. Please\ntry again.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              actions: [
                CupertinoActionSheetAction(
                  onPressed: Navigator.of(context).pop,
                  child: Text('OK'),
                ),
              ],
            ),
          ),
          doneCallback: Navigator.of(context).pop,
        );

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ImageHelper.getImage(ImageNames.bgAll).image,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CustomBackButton(),
                    const Spacer(flex: 2),
                    Text(
                      'Help&Feedback',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
                const SizedBox(height: 130),
                Form(
                  key: _formKeyMessage,
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Message text',
                      hintStyle:
                          Theme.of(context).textTheme.labelSmall!.copyWith(
                                color: Colors.white.withOpacity(0.5),
                              ),
                    ),
                    validator: (value) {
                      return checkMessage(value);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKeyEmail,
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Your email',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.white.withOpacity(0.5)),
                    ),
                    validator: (value) {
                      return checkEmail(value);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'the answer will be sent to this email',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Colors.white.withOpacity(0.5),
                      ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKeySubject,
                  child: TextFormField(
                    controller: subjectController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Subject of the message',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.white.withOpacity(0.5)),
                    ),
                    validator: (value) {
                      return checkSubject(value);
                    },
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  height: 50,
                  text: 'Send',
                  onTap: () {
                    if (_formKeyMessage.currentState!.validate() &&
                        _formKeyEmail.currentState!.validate() &&
                        _formKeySubject.currentState!.validate()) {
                      _send();
                      textController.clear();
                      emailController.clear();
                      subjectController.clear();
                      showDialog(
                        context: context,
                        builder: (context) => Column(
                          children: [
                            const Spacer(),
                            Container(
                              width: 200,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: const Alignment(0.00, -1.00),
                                  end: const Alignment(0, 1),
                                  colors: [
                                    Theme.of(context)
                                        .extension<CustomColors>()!
                                        .beginPrimaryGradient!,
                                    Theme.of(context)
                                        .extension<CustomColors>()!
                                        .endPrimaryGradient!,
                                  ],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Successfully',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(flex: 2),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? checkEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    return null;
  }

  String? checkMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter message';
    }
    return null;
  }

  String? checkSubject(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the subject of the message';
    }
    return null;
  }
}
