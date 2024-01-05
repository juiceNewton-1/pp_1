import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  final _auth = LocalAuthentication();

  Future<bool> _canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) return false;
      bool authenticated = await _auth.authenticate(
        localizedReason: 'Authenticate using Face ID',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (authenticated) {
        print('Authentication successful');
        return true;
      } else {
        print('Authentication failed or canceled by the user');
        return false;
      }
    } on PlatformException catch (e) {
      debugPrint('Error during authentication: $e');
      return false;
    }
  }
}
