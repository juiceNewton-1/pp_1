import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stocks_tracker/helpers/images/image_helper.dart';
import 'package:stocks_tracker/helpers/text_helper.dart';
import 'package:stocks_tracker/navigation/route_names.dart';
import 'package:stocks_tracker/service/local_auth.dart';
import 'package:stocks_tracker/service/storage/storage_service.dart';
import 'package:stocks_tracker/themes/custom_colors.dart';
import 'package:stocks_tracker/widgets/elements/custom_button.dart';


final _formKey = GlobalKey<FormState>();

class CreatePasswordView extends StatefulWidget {
  const CreatePasswordView({super.key});

  @override
  State<CreatePasswordView> createState() => _CreatePasswordViewState();
}

class _CreatePasswordViewState extends State<CreatePasswordView> {
  final _storageService = GetIt.instance<StorageService>();
  final _localAuth = GetIt.instance<LocalAuth>();
  final TextEditingController passController = TextEditingController();
  bool authenticated = false;

  @override
  Widget build(BuildContext context) {
    final isFirstLaunch =
        _storageService.getBool(StorageKeys.isFirstLaunch) ?? true;
    final savedPassword = _storageService.getString(StorageKeys.password);
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  ImageHelper.getImage(
                    ImageNames.createPassword,
                    width: 163,
                    height: 163,
                  ),
                  const SizedBox(height: 21),
                  Text(
                    TextHelper.textCreatePassword,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 54),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary),
                      controller: passController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        return checkPassword(
                            value, savedPassword, isFirstLaunch);
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final authenticate = await _localAuth.authenticate();
                      setState(() => authenticated = authenticate);
                      if (authenticated && mounted) {
                        Navigator.of(context)
                            .pushReplacementNamed(RouteNames.companyList);
                      }
                    },
                    child: getGradientText(context, 'use Face ID'),
                  ),
                  // const Spacer(),
                  // const SizedBox(height: 30),
                  CustomButton(
                    text: 'Continue',
                    width: double.infinity,
                    height: 45,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        checkFirstLaunch(isFirstLaunch, context);
                        if (savedPassword == passController.text) {
                          Navigator.of(context)
                              .pushReplacementNamed(RouteNames.companyList);
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? checkPassword(
      String? value, String? savedPassword, bool isFirstLaunch) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (passController.text.length < 4) {
      passController.clear();
      return 'Password length should be more than 4 characters';
    } else if (savedPassword != passController.text && isFirstLaunch == false) {
      passController.clear();
      return 'Incorrect password. Please try again.';
    }
    return null;
  }

  void checkFirstLaunch(bool isFirstLaunch, BuildContext context) {
    if (isFirstLaunch) {
      _storageService.setBool(StorageKeys.isFirstLaunch, false);
      _storageService.setString(StorageKeys.password, passController.text);
      Navigator.of(context).pushReplacementNamed(RouteNames.companyList);
    }
  }

  ShaderMask getGradientText(BuildContext context, String text) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: const Alignment(0.00, -1.00),
          end: const Alignment(0, 1),
          colors: [
            Theme.of(context).extension<CustomColors>()!.beginPrimaryGradient!,
            Theme.of(context).extension<CustomColors>()!.endPrimaryGradient!,
          ],
        ).createShader(bounds);
      },
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
