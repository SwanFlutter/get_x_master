import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

class BottomSheetTest extends StatelessWidget {
  const BottomSheetTest({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            minWidth: Get.width / 2,
            height: 56,
            color: context.theme.colorScheme.inversePrimary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              Get.bottomSheet(
                  isDismissible: true,
                  Container(
                    height: 850,
                    width: Get.width,
                    color: Colors.blue,
                  ));
            },
            child: Text('bottomSheet'),
          ),
          SizedBox(height: 20),
          MaterialButton(
            minWidth: Get.width / 2,
            height: 56,
            color: context.theme.colorScheme.inversePrimary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: _showExpandableBottomSheet,
            child: Text('ExpandableBottomSheet'),
          ),
        ],
      ).paddingAll(20.0),
    );
  }

  void _showExpandableBottomSheet() {
    Get.customExpandableBottomSheet(
      builder: (context) => InkWell(
        onDoubleTap: () {
          Get.back();
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Expandable Bottom Sheet',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Drag me up and down!\nThis bottom sheet is expandable and draggable.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Add more content here for scrolling
              ...List.generate(
                20,
                (index) => ListTile(
                  title: Text('Item ${index + 1}'),
                  subtitle: Text('Description for item ${index + 1}'),
                  leading: CircleAvatar(child: Text('${index + 1}')),
                ),
              ),
            ],
          ).paddingOnly(bottom: 16.0),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 8,
      initialChildSize: 0.5,
      minChildSize: 0.25,
      maxChildSize: 0.95,
      borderRadius: 15,
      enableDrag: true,
      isDismissible: true, // Set isDismissible here
      startFromTop: false,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      isShowCloseBottom: true,
      indicatorColor: Colors.blue,
    );
  }
}
