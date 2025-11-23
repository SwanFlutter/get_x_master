import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

/// Example demonstrating the enhanced responsive extensions
class ResponsiveDemo extends StatelessWidget {
  const ResponsiveDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enhanced Responsive Demo'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w), // 16px responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Screen Info Card
            _buildScreenInfoCard(),
            SizedBox(height: 20.h), // 20px responsive height
            // Extension Methods Examples
            _buildExtensionExamples(),
            SizedBox(height: 20.h),

            // Helper Class Examples
            _buildHelperExamples(),
            SizedBox(height: 20.h),

            // Practical Examples
            _buildPracticalExamples(),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenInfoCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12.w),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Screen Information',
            style: TextStyle(
              fontSize: ResponsiveSize(18).ssp, // Responsive font size
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow('Width', '${Get.width.toStringAsFixed(1)}px'),
          _buildInfoRow('Height', '${Get.height.toStringAsFixed(1)}px'),
          _buildInfoRow(
            'Aspect Ratio',
            (Get.width / Get.height).toStringAsFixed(2),
          ),
          /* _buildInfoRow(
              'Device Type', ResponsiveHelper.isTablet ? 'Tablet' : 'Phone'),
          _buildInfoRow('Orientation',
              ResponsiveHelper.isLandscape ? 'Landscape' : 'Portrait'),*/
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtensionExamples() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12.w),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Extension Methods Examples',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
          SizedBox(height: 12.h),

          // Pixel to Responsive Examples
          _buildExampleCard('Pixel to Responsive', [
            'Container(width: 134.w) // 134px responsive width',
            'Container(height: 30.h) // 30px responsive height',
            'Text("Hello", style: TextStyle(fontSize: 16.sp))',
          ], Colors.green),

          SizedBox(height: 12.h),

          // Percentage Examples
          _buildExampleCard('Percentage Based', [
            'Container(width: 50.wp) // 50% screen width',
            'Container(height: 25.hp) // 25% screen height',
            'Padding: EdgeInsets.all(5.wp)',
          ], Colors.green),

          SizedBox(height: 12.h),

          // Dynamic Calculation Examples
          _buildExampleCard('Dynamic Calculations', [
            '134.widthPercent = ${134.0.widthPercent.toStringAsFixed(1)}%',
            '30.heightPercent = ${30.0.heightPercent.toStringAsFixed(1)}%',
            'Current calculations based on screen size',
          ], Colors.green),
        ],
      ),
    );
  }

  Widget _buildHelperExamples() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12.w),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ResponsiveHelper Class Examples',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade800,
            ),
          ),
          SizedBox(height: 12.h),
          _buildExampleCard('Static Methods', [
            /*   'ResponsiveHelper.w(134) = ${ResponsiveHelper.w(134).toStringAsFixed(1)}px',
              'ResponsiveHelper.h(30) = ${ResponsiveHelper.h(30).toStringAsFixed(1)}px',
              'ResponsiveHelper.wp(50) = ${ResponsiveHelper.wp(50).toStringAsFixed(1)}px',*/
          ], Colors.orange),
          SizedBox(height: 12.h),
          _buildExampleCard('Responsive Values', [
            /*   'ResponsiveHelper.responsiveValue(',
              '  phone: 14.0,',
              '  tablet: 16.0,',
              '  desktop: 18.0,',
              ') = ${ResponsiveHelper.responsiveValue(phone: 14.0, tablet: 16.0, laptop: 18.0)}',*/
          ], Colors.orange),
        ],
      ),
    );
  }

  Widget _buildPracticalExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Practical Examples',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade800,
          ),
        ),
        SizedBox(height: 16.h),

        // Card Example
        CardInfoView(icon: Icons.star, text: 'Responsive Card'),

        SizedBox(height: 16.h),

        // Button Examples
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                ),
                child: Text('Button 1', style: TextStyle(fontSize: 14.sp)),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                ),
                child: Text('Button 2', style: TextStyle(fontSize: 14.sp)),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Grid Example
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.5,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(8.w),
                border: Border.all(color: Colors.purple.shade300),
              ),
              child: Center(
                child: Text(
                  'Item ${index + 1}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.purple.shade800,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildExampleCard(
    String title,
    List<String> examples,
    MaterialColor color,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.shade100,
        borderRadius: BorderRadius.circular(8.w),
        border: Border.all(color: color.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: color.shade800,
            ),
          ),
          SizedBox(height: 8.h),
          ...examples.map(
            (example) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Text(
                example,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'monospace',
                  color: color.shade700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Enhanced CardInfoView using the new responsive extensions
class CardInfoView extends StatelessWidget {
  final IconData icon;
  final String text;

  const CardInfoView({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 134.w, // 134px responsive width - automatically calculated!
      height: 30.h, // 30px responsive height - automatically calculated!
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.w),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(251, 241, 239, 1),
            Color.fromRGBO(252, 248, 248, 1),
            Color.fromRGBO(249, 240, 240, 1),
            Color.fromRGBO(252, 244, 243, 1),
          ],
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14.w, // 14px responsive icon size
            color: Colors.orange.shade700,
          ).paddingOnly(left: 5.w), // 5px responsive padding
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp, // 12px responsive font size
              fontWeight: FontWeight.w600,
              color: Colors.orange.shade800,
            ),
          ).paddingOnly(left: 5.w), // 5px responsive padding
        ],
      ),
    );
  }
}
