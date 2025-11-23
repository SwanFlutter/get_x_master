import 'package:flutter/cupertino.dart';
import 'package:get_x_master/get_x_master.dart';

/// Example demonstrating new Flutter Cupertino features with GetX
class CupertinoFeaturesExample extends StatelessWidget {
  const CupertinoFeaturesExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoHomePage();
  }
}

class CupertinoHomePage extends StatelessWidget {
  const CupertinoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cupertino Features'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 20),
            const Text(
              'New Flutter Cupertino Features',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Squircle Example
            _buildFeatureCard(
              title: 'Rounded Superellipse (Squircle)',
              description: 'Apple-style rounded corners with smooth curves',
              onTap: () => Get.toNamed('/squircle'),
              icon: CupertinoIcons.square_on_square,
            ),

            const SizedBox(height: 16),

            // Sheet Example
            _buildFeatureCard(
              title: 'Enhanced Cupertino Sheet',
              description: 'Improved bottom sheets with better animations',
              onTap: () => Get.toNamed('/sheet'),
              icon: CupertinoIcons.rectangle_dock,
            ),

            const SizedBox(height: 16),

            // Navigation Example
            _buildFeatureCard(
              title: 'Improved Navigation',
              description: 'Enhanced navigation bar transitions',
              onTap: () => Get.toNamed('/navigation'),
              icon: CupertinoIcons.arrow_right_arrow_left,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String description,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: CupertinoColors.systemBlue,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.label,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.secondaryLabel,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_right,
              color: CupertinoColors.systemGrey,
            ),
          ],
        ),
      ),
    );
  }
}

/// Example page demonstrating Rounded Superellipse (Squircle)
class SquircleExamplePage extends StatelessWidget {
  const SquircleExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Squircle Examples'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rounded Superellipse (Apple Squircle)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'The rounded superellipse provides smoother, more continuous curves compared to traditional rounded rectangles.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),

              // Example with different shapes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShapeExample(
                    'Traditional\nRounded Rectangle',
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemBlue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  _buildShapeExample(
                    'Apple\nSquircle',
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const ShapeDecoration(
                        color: CupertinoColors.systemBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Alert Dialog Example
              CupertinoButton.filled(
                child: const Text('Show Alert with Squircle'),
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text('Squircle Alert'),
                      content: const Text(
                        'This alert dialog now uses the new rounded superellipse shape!',
                      ),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('OK'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              // Action Sheet Example
              CupertinoButton.filled(
                child: const Text('Show Action Sheet with Squircle'),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      title: const Text('Squircle Action Sheet'),
                      message: const Text(
                        'This action sheet also uses the new rounded superellipse shape!',
                      ),
                      actions: [
                        CupertinoActionSheetAction(
                          child: const Text('Option 1'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('Option 2'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShapeExample(String label, Widget shape) {
    return Column(
      children: [
        shape,
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

/// Example page demonstrating enhanced Cupertino Sheet
class SheetExamplePage extends StatelessWidget {
  const SheetExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Sheet Examples'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enhanced Cupertino Sheet',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'The Cupertino sheet has been improved with better animations, proper navigation bar height, and enhanced drag behavior.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              CupertinoButton.filled(
                child: const Text('Show Standard Sheet'),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => Container(
                      height: 300,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: CupertinoColors.systemBackground,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey3,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Enhanced Sheet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'This sheet has improved animations and proper content handling.',
                          ),
                          const Spacer(),
                          CupertinoButton.filled(
                            child: const Text('Close'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Example page demonstrating improved navigation
class NavigationExamplePage extends StatelessWidget {
  const NavigationExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Navigation Example'),
        trailing: Icon(CupertinoIcons.search),
      ),
      child: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Improved Navigation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Navigation bars now have improved transitions that match the latest iOS design guidelines.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              Text(
                'Features:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16),
              Text('• Smoother transition animations'),
              Text('• Better search field alignment'),
              Text('• Improved icon positioning'),
              Text('• Enhanced large title behavior'),
            ],
          ),
        ),
      ),
    );
  }
}
