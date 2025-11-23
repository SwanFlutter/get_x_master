import 'package:flutter/cupertino.dart';
import 'package:get_x_master/get_x_master.dart';

/// Simple Cupertino example without nested apps
class SimpleCupertinoExample extends StatelessWidget {
  const SimpleCupertinoExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Simple Cupertino Example'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to GetX Cupertino!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Simple Counter Example
              GetBuilder<SimpleController>(
                init: SimpleController(),
                builder: (controller) {
                  return Column(
                    children: [
                      Text(
                        'Count: ${controller.count}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CupertinoButton.filled(
                            onPressed: controller.decrement,
                            child: const Text('-'),
                          ),
                          CupertinoButton.filled(
                            onPressed: controller.increment,
                            child: const Text('+'),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 30),

              // Navigation Example
              CupertinoButton.filled(
                onPressed: () {
                  Get.to(() => const SecondPage());
                },
                child: const Text('Go to Second Page'),
              ),

              const SizedBox(height: 20),

              // Alert Example
              CupertinoButton.filled(
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text('Alert'),
                      content: const Text('This is a Cupertino alert!'),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('OK'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Show Alert'),
              ),

              const SizedBox(height: 20),

              // Action Sheet Example
              CupertinoButton.filled(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      title: const Text('Choose an option'),
                      actions: [
                        CupertinoActionSheetAction(
                          child: const Text('Option 1'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Get.snackbar('Selected', 'Option 1');
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('Option 2'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Get.snackbar('Selected', 'Option 2');
                          },
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  );
                },
                child: const Text('Show Action Sheet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleController extends GetXController {
  int count = 0;

  void increment() {
    count++;
    update();
  }

  void decrement() {
    count--;
    update();
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Second Page'),
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Get.back(),
        ),
      ),
      child: const SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'This is the second page!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Navigation with GetX works perfectly with Cupertino widgets.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
