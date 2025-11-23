// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

class EnhancedResponsiveDemo extends StatelessWidget {
  const EnhancedResponsiveDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enhanced Responsive Demo',
          style: TextStyle(fontSize: 18.sp),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.ws),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Device Info Section
            _buildDeviceInfoCard(),
            SizedBox(height: 20.h),

            // Font Size Examples
            _buildFontSizeExamples(),
            SizedBox(height: 20.h),

            // Widget Size Examples
            _buildWidgetSizeExamples(),
            SizedBox(height: 20.h),

            // Image Size Examples
            _buildImageSizeExamples(),
            SizedBox(height: 20.h),

            // Responsive Values Examples
            _buildResponsiveValuesExamples(),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceInfoCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.ws),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Information',
              style: TextStyle(
                fontSize: 20.hsp,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 12.h),
            /* _buildInfoRow('Device Type', ResponsiveHelper.deviceType),
            _buildInfoRow('Screen Width', '${Get.width.toStringAsFixed(1)}px'),
            _buildInfoRow(
                'Screen Height', '${Get.height.toStringAsFixed(1)}px'),
            _buildInfoRow('Is Laptop', ResponsiveHelper.isLaptop.toString()),
            _buildInfoRow(
                'Is TV', ResponsiveHelper.responsiveValue(tv: true).toString()),*/
          ],
        ),
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
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildFontSizeExamples() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.ws),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Font Size Examples',
              style: TextStyle(
                fontSize: 20.hsp,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Normal Text (16.sp): This is normal responsive text',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              'Large Text (24.hsp): This is large responsive text',
              style: TextStyle(fontSize: 24.hsp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              'Small Text (12.ssp): This is small responsive text',
              style: TextStyle(fontSize: 12.ssp, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetSizeExamples() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.ws),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Widget Size Examples',
              style: TextStyle(
                fontSize: 20.hsp,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconExample(Icons.home, 24.ws, 'Home (24.ws)'),
                _buildIconExample(Icons.star, 32.ws, 'Star (32.ws)'),
                _buildIconExample(Icons.favorite, 40.ws, 'Heart (40.ws)'),
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              width: 200.ws,
              height: 50.ws,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.ws),
              ),
              child: Center(
                child: Text(
                  'Button (200x50.ws)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconExample(IconData icon, double size, String label) {
    return Column(
      children: [
        Icon(icon, size: size, color: Colors.blue),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(fontSize: 12.ssp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildImageSizeExamples() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.ws),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Image Size Examples',
              style: TextStyle(
                fontSize: 20.hsp,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildImagePlaceholder(60.imgSize, 'Avatar\n(60.imgSize)'),
                _buildImagePlaceholder(80.imgSize, 'Profile\n(80.imgSize)'),
                _buildImagePlaceholder(100.imgSize, 'Large\n(100.imgSize)'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(double size, String label) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.ws),
            border: Border.all(color: Colors.grey),
          ),
          child: Icon(Icons.image, size: size * 0.6, color: Colors.grey[600]),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(fontSize: 12.ssp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildResponsiveValuesExamples() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.ws),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Responsive Values Examples',
              style: TextStyle(
                fontSize: 20.hsp,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 12.h),
            /*  _buildResponsiveExample(
              'Font Size',
             ResponsiveHelper.responsiveValue(
                phone: 14.0,
                tablet: 16.0,
                laptop: 18.0,
                tv: 22.0,
              ).toString(),
            ),*/
            /*  _buildResponsiveExample(
              'Widget Size',
              ResponsiveHelper.ws(40).toStringAsFixed(1),
            ),*/
            /* _buildResponsiveExample(
              'Image Size',
              ResponsiveHelper.imgSize(80).toStringAsFixed(1),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveExample(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
