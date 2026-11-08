import 'package:get_x_master/get_x_master.dart';

/// Global state of the hub: which app shell is active, and which examples the
/// tester has marked as working or broken. Lives outside the widget tree so it
/// survives switching between GetMaterialApp and GetCupertinoApp.
class HubSettings extends GetXController {
  /// false -> GetMaterialApp, true -> GetCupertinoApp
  final RxBool cupertinoShell = false.obs;

  final RxSet<String> passed = <String>{}.obs;
  final RxSet<String> failed = <String>{}.obs;

  void setShell({required bool cupertino}) => cupertinoShell.value = cupertino;

  void mark(String title, {required bool ok}) {
    if (ok) {
      failed.remove(title);
      passed.add(title);
    } else {
      passed.remove(title);
      failed.add(title);
    }
  }
}
