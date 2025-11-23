import 'package:get_x_master/get_x_master.dart';

/// Extension methods for resetting GetX state and configurations
extension GetResetExt on GetInterface {
  void reset({bool clearRouteBindings = true}) {
    GetInstance().resetInstance(clearRouteBindings: clearRouteBindings);
    Get.clearRouteTree();
    Get.clearTranslations();
    Get.resetRootNavigator();
  }
}
