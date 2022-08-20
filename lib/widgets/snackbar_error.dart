import 'package:get/get.dart';

SnackbarController snackBar() {
  return Get.snackbar(
    'Faild to load the movies!',
    'Somthing went wrong in the server, will be solved soon.',
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 4),
  );
}
