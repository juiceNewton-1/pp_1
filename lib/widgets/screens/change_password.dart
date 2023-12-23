import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stocks_tracker/helpers/images/image_helper.dart';
import 'package:stocks_tracker/service/storage/storage_service.dart';
import 'package:stocks_tracker/widgets/components/custom_back_button.dart';
import 'package:stocks_tracker/widgets/components/custom_button.dart';

final _formKey = GlobalKey<FormState>();

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _storageService = GetIt.instance<StorageService>();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final savedPassword = _storageService.getString(StorageKeys.password);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ImageHelper.getImage(ImageNames.bgAll).image,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  const CustomBackButton(),
                  const Spacer(flex: 2),
                  Text(
                    'Change password',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const Spacer(flex: 3),
                ],
              ),
              const SizedBox(height: 30),
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
                    return checkPassword(value, savedPassword);
                  },
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: 'Change',
                width: double.infinity,
                height: 45,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _storageService.setString(
                        StorageKeys.password, passController.text);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? checkPassword(String? value, String? savedPassword) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (passController.text.length < 4) {
      passController.clear();
      return 'Password length should be more than 4 characters';
    } else if (savedPassword == passController.text) {
      passController.clear();
      return 'The new password matches the old one';
    }
    return null;
  }
}
