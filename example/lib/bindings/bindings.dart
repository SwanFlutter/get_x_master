import 'package:example/controller/login_controller.dart';
import 'package:example/controller/signup_controller.dart';
import 'package:example/controller/todos_controller.dart';
import 'package:example/reactive_get_view_demo.dart';
import 'package:get_x_master/get_x_master.dart';

import '../controller/theme_controller.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(() => TodosController());

    Get.smartPut(
      builder: () => TodosController(),
      // Optional condition for when you want the controller to be built only under certain conditions
      condition: () => true, // You can add a specific condition

      // Check the controller validity (optional)
      validityCheck: (controller) => true, // You can add validation logic

      fenix: false,

      // If you want this controller to be available always
      permanent: true,
    );

    /*  Get.smartPut(
      builder: () => LoginController(),
      permanent: true,
      fenix: true,
      condition: () => true,
      validityCheck: (controller) => true,
    );*/

    Get.smartLazyPut<LoginController>(() => LoginController());

    Get.smartLazyPut<SignupController>(() => SignupController());

    /*
    Get.smartPut(
      builder: () => SignupController(),
      permanent: true,
      fenix: false,
      condition: () => true,
      validityCheck: (controller) => true,
    );*/

    Get.smartLazyPut(
      () => CounterController(),
    );

    Get.smartLazyPut(
      () => ThemeController(),
    );
  }
}
