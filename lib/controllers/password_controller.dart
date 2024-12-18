import 'package:get/get.dart';

class PasswordController extends GetxController {
  // Reactive state
  var _password = true.obs;

  // Getter
  bool get password => _password.value;

  // Setter
  set setPassword(bool newValue) {
    _password.value = newValue;
  }
}
