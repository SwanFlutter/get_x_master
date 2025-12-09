import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

class TestExpandableBottomSheet extends StatelessWidget {
  const TestExpandableBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expandable BottomSheet Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Basic bottom sheet
            ElevatedButton(
              onPressed: () => _showBasicBottomSheet(context),
              child: const Text('Basic BottomSheet'),
            ),
            const SizedBox(height: 16),

            // Bottom sheet from top
            ElevatedButton(
              onPressed: () => _showTopBottomSheet(context),
              child: const Text('BottomSheet from Top'),
            ),
            const SizedBox(height: 16),

            // Custom styled bottom sheet
            ElevatedButton(
              onPressed: () => _showCustomStyledBottomSheet(context),
              child: const Text('Custom Styled BottomSheet'),
            ),
            const SizedBox(height: 16),

            // Full screen bottom sheet
            ElevatedButton(
              onPressed: () => _showFullScreenBottomSheet(context),
              child: const Text('Full Screen BottomSheet'),
            ),
            const SizedBox(height: 16),

            // Non-dismissible bottom sheet
            ElevatedButton(
              onPressed: () => _showNonDismissibleBottomSheet(context),
              child: const Text('Non-Dismissible BottomSheet'),
            ),
            const SizedBox(height: 16),

            // Snapping bottom sheet
            ElevatedButton(
              onPressed: () => _showSnappingBottomSheet(context),
              child: const Text('Snapping BottomSheet'),
            ),
          ],
        ),
      ),
    );
  }

  // Basic bottom sheet
  void _showBasicBottomSheet(BuildContext context) {
    Navigator.of(context).push(
      BottomSheetExpandableRoute(
        builder: (context) => _buildContent('Basic BottomSheet'),
        initialChildSize: 0.5,
        minChildSize: 0.25,
        maxChildSize: 0.9,
      ),
    );
  }

  // Bottom sheet from top
  void _showTopBottomSheet(BuildContext context) {
    Navigator.of(context).push(
      BottomSheetExpandableRoute(
        builder: (context) => _buildContent('BottomSheet from Top'),
        startFromTop: true,
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.8,
        backgroundColor: Colors.blue.shade50,
      ),
    );
  }

  // Custom styled bottom sheet
  void _showCustomStyledBottomSheet(BuildContext context) {
    Navigator.of(context).push(
      BottomSheetExpandableRoute(
        builder: (context) => _buildContent('Custom Styled'),
        backgroundColor: Colors.purple.shade100,
        borderRadius: 25.0,
        indicatorColor: Colors.purple,
        closeIcon: Icons.cancel,
        elevation: 10,
        initialChildSize: 0.6,
      ),
    );
  }

  // Full screen bottom sheet
  void _showFullScreenBottomSheet(BuildContext context) {
    Navigator.of(context).push(
      BottomSheetExpandableRoute(
        builder: (context) => _buildContent('Full Screen'),
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 1.0,
        borderRadius: 20.0,
      ),
    );
  }

  // Non-dismissible bottom sheet
  void _showNonDismissibleBottomSheet(BuildContext context) {
    Navigator.of(context).push(
      BottomSheetExpandableRoute(
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Non-Dismissible BottomSheet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('You can only close this by pressing the button below'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            const SizedBox(height: 100),
          ],
        ),
        isDismissible: false,
        enableDrag: false,
        isShowCloseBottom: false,
        initialChildSize: 0.4,
      ),
    );
  }

  // Snapping bottom sheet
  void _showSnappingBottomSheet(BuildContext context) {
    Navigator.of(context).push(
      BottomSheetExpandableRoute(
        builder: (context) => _buildContent('Snapping BottomSheet\n\nDrag me!'),
        snap: true,
        initialChildSize: 0.5,
        minChildSize: 0.25,
        maxChildSize: 0.9,
      ),
    );
  }

  Widget _buildContent(String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const Text('This is the content of the bottom sheet'),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text('Item ${index + 1}'),
              subtitle: Text('Description for item ${index + 1}'),
              onTap: () {
                Get.snackbar(
                  'Tapped',
                  'You tapped on item ${index + 1}',
                  snackPosition: SnackPosition.bottom,
                );
              },
            );
          },
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
