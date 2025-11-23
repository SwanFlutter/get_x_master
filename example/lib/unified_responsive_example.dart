import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

/// مثال دسترسی یکپارچه به تمام متدهای Responsive در GetResponsiveBuilder
/// Unified access to all responsive methods within GetResponsiveBuilder

class UnifiedResponsiveApp extends StatelessWidget {
  const UnifiedResponsiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Unified Responsive Access',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const UnifiedResponsiveHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class UnifiedResponsiveHome extends StatelessWidget {
  const UnifiedResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('دسترسی یکپارچه Responsive'),
        centerTitle: true,
      ),
      body: GetResponsiveBuilder(
        builder: (context, data) {
          // 🎉 حالا به تمام متدها دسترسی مستقیم دارید!
          // Now you have direct access to all methods!

          return ListView(
            padding: data.responsiveInsetsAll(16), // ✨ EdgeInsets واکنش‌گرا
            children: [
              // مثال ۱: استفاده از متدهای پایه
              _buildBasicMethodsCard(data),
              SizedBox(height: data.h(20)), // ✨ Height واکنش‌گرا
              // مثال ۲: Font Sizes مختلف
              _buildFontSizesCard(data),
              SizedBox(height: data.h(20)),

              // مثال ۳: Widget & Image Sizes
              _buildSizesCard(data),
              SizedBox(height: data.h(20)),

              // مثال ۴: Percentages & Dimensions
              _buildDimensionsCard(data),
              SizedBox(height: data.h(20)),

              // مثال ۵: Responsive UI Elements
              _buildResponsiveUICard(data),
              SizedBox(height: data.h(20)),

              // مثال ۶: Device-specific Values
              _buildDeviceSpecificCard(data),
            ],
          );
        },
      ),
    );
  }

  /// مثال ۱: متدهای پایه (w, h, wp, hp)
  Widget _buildBasicMethodsCard(ResponsiveData data) {
    return Card(
      child: Padding(
        padding: data.responsiveInsetsAll(16), // ✨ Padding واکنش‌گرا
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📐 متدهای پایه',
              style: TextStyle(
                fontSize: data.sp(18), // ✨ Font size واکنش‌گرا
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: data.h(12)),
            _infoRow(data, 'data.w(100)', data.w(100)),
            _infoRow(data, 'data.h(80)', data.h(80)),
            _infoRow(data, 'data.wp(50)', data.wp(50)),
            _infoRow(data, 'data.hp(30)', data.hp(30)),
            SizedBox(height: data.h(12)),
            // نمایش بصری
            Container(
              width: data.wp(60),
              height: data.hp(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade300, Colors.purple.shade300],
                ),
                borderRadius: data.responsiveBorderRadiusCircular(12),
              ),
              child: Center(
                child: Text(
                  '60% × 15%',
                  style: TextStyle(
                    fontSize: data.sp(16),
                    color: Colors.white,
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

  /// مثال ۲: اندازه فونت‌های مختلف
  Widget _buildFontSizesCard(ResponsiveData data) {
    return Card(
      child: Padding(
        padding: data.responsiveInsetsSymmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '✨ اندازه فونت‌های واکنش‌گرا',
              style: TextStyle(
                fontSize: data.sp(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: data.h(12)),
            Text(
              'data.sp(14) - Standard',
              style: TextStyle(
                fontSize: data.responsiveValue(
                  phone: data.sp(14),
                  tablet: data.sp(16),
                  desktop: data.sp(18),
                ),
              ),
            ),
            SizedBox(height: data.h(8)),
            Text(
              'data.sp(16) - Regular',
              style: TextStyle(
                fontSize: data.responsiveValue(
                  phone: data.sp(16),
                  tablet: data.sp(18),
                  desktop: data.sp(20),
                ),
              ),
            ),
            SizedBox(height: data.h(8)),
            Text(
              'data.hsp(18) - Header Small',
              style: TextStyle(
                fontSize: data.responsiveValue(
                  phone: data.hsp(18),
                  tablet: data.hsp(20),
                  desktop: data.hsp(22),
                ),
              ),
            ),
            SizedBox(height: data.h(8)),
            Text(
              'data.ssp(12) - Small Text',
              style: TextStyle(
                fontSize: data.responsiveValue(
                  phone: data.ssp(12),
                  tablet: data.ssp(14),
                  desktop: data.ssp(16),
                ),
              ),
            ),
            SizedBox(height: data.h(12)),
            _infoRow(data, 'data.sp(16)', data.sp(16)),
            _infoRow(data, 'data.hsp(18)', data.hsp(18)),
            _infoRow(data, 'data.ssp(12)', data.ssp(12)),
          ],
        ),
      ),
    );
  }

  /// مثال ۳: Widget & Image Sizes
  Widget _buildSizesCard(ResponsiveData data) {
    return Card(
      child: Padding(
        padding: data.responsiveInsets(
          left: 16,
          top: 16,
          right: 16,
          bottom: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🎨 اندازه ویجت و تصویر',
              style: TextStyle(
                fontSize: data.sp(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: data.h(12)),
            Row(
              children: [
                Icon(Icons.star, size: data.ws(20), color: Colors.amber),
                SizedBox(width: data.w(8)),
                Icon(Icons.star, size: data.ws(28), color: Colors.amber),
                SizedBox(width: data.w(8)),
                Icon(Icons.star, size: data.ws(36), color: Colors.amber),
                SizedBox(width: data.w(8)),
                Icon(Icons.star, size: data.ws(44), color: Colors.amber),
              ],
            ),
            SizedBox(height: data.h(12)),
            _infoRow(data, 'data.ws(24)', data.ws(24)),
            _infoRow(data, 'data.imgSize(100)', data.imgSize(100)),
            SizedBox(height: data.h(12)),
            // تصویر واکنش‌گرا
            Container(
              width: data.imgSize(120),
              height: data.imgSize(120),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: data.responsiveBorderRadius(
                  topLeft: 20,
                  topRight: 10,
                  bottomLeft: 10,
                  bottomRight: 20,
                ),
                border: Border.all(color: Colors.blue, width: data.w(3)),
              ),
              child: Center(
                child: Icon(
                  Icons.image,
                  size: data.imgSize(60),
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// مثال ۴: Percentages & Dimensions
  Widget _buildDimensionsCard(ResponsiveData data) {
    return Card(
      child: Padding(
        padding: data.responsiveInsetsAll(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📊 درصدها و ابعاد',
              style: TextStyle(
                fontSize: data.sp(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: data.h(12)),
            _infoRow(data, 'data.widthPercent(100)', data.widthPercent(100)),
            _infoRow(data, 'data.heightPercent(200)', data.heightPercent(200)),
            _infoRow(data, 'data.minDimension(100)', data.minDimension(100)),
            _infoRow(data, 'data.maxDimension(100)', data.maxDimension(100)),
            SizedBox(height: data.h(12)),
            Row(
              children: [
                // Min Dimension
                Container(
                  width: data.minDimension(80),
                  height: data.minDimension(80),
                  decoration: BoxDecoration(
                    color: Colors.green.shade200,
                    borderRadius: data.responsiveBorderRadiusCircular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Min',
                      style: TextStyle(
                        fontSize: data.sp(14),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: data.w(16)),
                // Max Dimension
                Container(
                  width: data.minDimension(80),
                  height: data.minDimension(80),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade200,
                    borderRadius: data.responsiveBorderRadiusCircular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Max',
                      style: TextStyle(
                        fontSize: data.sp(14),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// مثال ۵: Responsive UI Elements
  Widget _buildResponsiveUICard(ResponsiveData data) {
    return Card(
      child: Padding(
        padding: data.responsiveInsetsAll(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🎯 المان‌های UI واکنش‌گرا',
              style: TextStyle(
                fontSize: data.sp(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: data.h(16)),
            // دکمه واکنش‌گرا
            Container(
              width: data.wp(80),
              height: data.h(50),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.purple, Colors.blue]),
                borderRadius: data.responsiveBorderRadiusCircular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withValues(alpha: 0.3),
                    blurRadius: data.w(10),
                    offset: Offset(0, data.h(4)),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'دکمه واکنش‌گرا',
                  style: TextStyle(
                    fontSize: data.sp(16),
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: data.h(16)),
            // کارت با padding و border واکنش‌گرا
            Container(
              padding: data.responsiveInsetsSymmetric(
                horizontal: 20,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                border: Border.all(color: Colors.teal, width: data.w(2)),
                borderRadius: data.responsiveBorderRadius(
                  topLeft: 16,
                  topRight: 4,
                  bottomLeft: 4,
                  bottomRight: 16,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: data.ws(24),
                    color: Colors.teal,
                  ),
                  SizedBox(width: data.w(12)),
                  Expanded(
                    child: Text(
                      'همه چیز با data واکنش‌گرا است!',
                      style: TextStyle(
                        fontSize: data.sp(14),
                        color: Colors.teal.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// مثال ۶: Device-specific Values
  Widget _buildDeviceSpecificCard(ResponsiveData data) {
    return Card(
      child: Padding(
        padding: data.responsiveInsetsAll(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🖥️ مقادیر بر اساس دستگاه',
              style: TextStyle(
                fontSize: data.sp(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: data.h(12)),
            _infoRow(data, 'Device Type', data.deviceType),
            _infoRow(data, 'Is Phone', data.isPhone.toString()),
            _infoRow(data, 'Is Tablet', data.isTablet.toString()),
            _infoRow(data, 'Is Laptop', data.isLaptop.toString()),
            _infoRow(data, 'Is Desktop', data.isDesktop.toString()),
            SizedBox(height: data.h(12)),
            // استفاده از responsiveValue
            Container(
              padding: data.responsiveInsetsAll(16),
              decoration: BoxDecoration(
                color: data.responsiveValue<Color>(
                  phone: Colors.blue.shade100,
                  tablet: Colors.green.shade100,
                  laptop: Colors.orange.shade100,
                  desktop: Colors.purple.shade100,
                  defaultValue: Colors.grey.shade100,
                ),
                borderRadius: data.responsiveBorderRadiusCircular(12),
              ),
              child: Column(
                children: [
                  Icon(
                    data.responsiveValue<IconData>(
                      phone: Icons.phone_android,
                      tablet: Icons.tablet,
                      laptop: Icons.laptop,
                      desktop: Icons.desktop_windows,
                      defaultValue: Icons.devices,
                    ),
                    size: data.ws(48),
                    color: data.responsiveValue<Color>(
                      phone: Colors.blue,
                      tablet: Colors.green,
                      laptop: Colors.orange,
                      desktop: Colors.purple,
                      defaultValue: Colors.grey,
                    ),
                  ),
                  SizedBox(height: data.h(8)),
                  Text(
                    data.responsiveValue<String>(
                      phone: 'شما از موبایل استفاده می‌کنید',
                      tablet: 'شما از تبلت استفاده می‌کنید',
                      laptop: 'شما از لپتاپ استفاده می‌کنید',
                      desktop: 'شما از دسکتاپ استفاده می‌کنید',
                      defaultValue: 'دستگاه نامشخص',
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: data.sp(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ویجت کمکی برای نمایش اطلاعات
  Widget _infoRow(ResponsiveData data, String label, dynamic value) {
    return Padding(
      padding: data.responsiveInsetsSymmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: data.sp(13),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value is double ? value.toStringAsFixed(1) : value.toString(),
            style: TextStyle(
              fontSize: data.sp(13),
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
