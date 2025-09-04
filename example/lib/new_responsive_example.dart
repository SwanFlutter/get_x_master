import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

class NewResponsiveExample extends StatelessWidget {
  const NewResponsiveExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Responsive Example'),
      ),
      body: ResponsiveBuilder(
        builder: (context, responsive) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(responsive.wp(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Responsive Demo Page',
                  style: TextStyle(
                    fontSize: responsive.sp(24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: responsive.hp(2)),
                Text(
                  'This example showcases the power of GetX responsive UI.',
                  style: TextStyle(fontSize: responsive.sp(16)),
                ),
                SizedBox(height: responsive.hp(4)),
                _buildInfoCard(responsive),
                SizedBox(height: responsive.hp(4)),
                _buildResponsiveGrid(responsive),
                SizedBox(height: responsive.hp(4)),
                _buildDeviceSpecificWidget(responsive),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(ResponsiveData responsive) {
    return Container(
      padding: EdgeInsets.all(responsive.wp(4)),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(responsive.w(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(responsive, 'Screen Width:',
              '${responsive.width.toStringAsFixed(0)} px'),
          _buildInfoRow(responsive, 'Screen Height:',
              '${responsive.height.toStringAsFixed(0)} px'),
          _buildInfoRow(responsive, 'Device Type:', responsive.deviceType),
          _buildInfoRow(responsive, 'Orientation:',
              responsive.isPortrait ? 'Portrait' : 'Landscape'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(ResponsiveData responsive, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsive.hp(0.5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: responsive.sp(14))),
          Text(value,
              style: TextStyle(
                  fontSize: responsive.sp(14), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildResponsiveGrid(ResponsiveData responsive) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            responsive.responsiveValue(phone: 2, tablet: 3, desktop: 6)!,
        crossAxisSpacing: responsive.wp(4),
        mainAxisSpacing: responsive.wp(4),
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(responsive.w(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.widgets,
                size: responsive.ws(40),
                color: Colors.green.shade800,
              ),
              SizedBox(height: responsive.hp(1)),
              Text(
                'Item ${index + 1}',
                style: TextStyle(
                  fontSize: responsive.sp(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDeviceSpecificWidget(ResponsiveData responsive) {
    return responsive.responsiveValue(
      phone: _buildMobileLayout(responsive),
      tablet: _buildTabletLayout(responsive),
      desktop: _buildDesktopLayout(responsive),
    )!;
  }

  Widget _buildMobileLayout(ResponsiveData responsive) {
    return Container(
      padding: EdgeInsets.all(responsive.wp(4)),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.circular(responsive.w(12)),
      ),
      child: Column(
        children: [
          Icon(Icons.phone_android,
              size: responsive.ws(50), color: Colors.amber.shade800),
          SizedBox(height: responsive.hp(2)),
          Text(
            'This is the Mobile Layout',
            style: TextStyle(
                fontSize: responsive.sp(18), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(ResponsiveData responsive) {
    return Container(
      padding: EdgeInsets.all(responsive.wp(4)),
      decoration: BoxDecoration(
        color: Colors.purple.shade100,
        borderRadius: BorderRadius.circular(responsive.w(12)),
      ),
      child: Row(
        children: [
          Icon(Icons.tablet_mac,
              size: responsive.ws(60), color: Colors.purple.shade800),
          SizedBox(width: responsive.wp(4)),
          Expanded(
            child: Text(
              'This is the Tablet Layout',
              style: TextStyle(
                  fontSize: responsive.sp(20), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(ResponsiveData responsive) {
    return Container(
      padding: EdgeInsets.all(responsive.wp(3)),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(responsive.w(12)),
      ),
      child: Row(
        children: [
          Icon(Icons.desktop_windows,
              size: responsive.ws(70), color: Colors.red.shade800),
          SizedBox(width: responsive.wp(3)),
          Expanded(
            child: Text(
              'This is the Desktop Layout. Try resizing the window!',
              style: TextStyle(
                  fontSize: responsive.sp(22), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
