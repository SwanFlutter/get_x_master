import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

/// مثال جامع برای تست قابلیت‌های Responsive در GetX
/// Comprehensive example to test GetX Responsive features
void main() {
  runApp(const ResponsiveTestApp());
}

class ResponsiveTestApp extends StatelessWidget {
  const ResponsiveTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Responsive Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ResponsiveTestHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ResponsiveTestHome extends StatelessWidget {
  const ResponsiveTestHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تست Responsive GetX'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          // بخش ۱: اطلاعات صفحه نمایش
          _buildScreenInfoSection(),
          SizedBox(height: 20.h),

          // بخش ۲: تست Extension های عددی
          _buildNumberExtensionsSection(),
          SizedBox(height: 20.h),

          // بخش ۳: تست ResponsiveSize Extension
          _buildResponsiveSizeSection(),
          SizedBox(height: 20.h),

          // بخش ۴: تست GetResponsiveBuilder
          _buildResponsiveBuilderSection(),
          SizedBox(height: 20.h),

          // بخش ۵: تست Device Type Detection
          _buildDeviceTypeSection(),
          SizedBox(height: 20.h),

          // بخش ۶: تست Responsive Visibility
          _buildResponsiveVisibilitySection(),
          SizedBox(height: 20.h),

          // بخش ۷: تست GetResponsiveHelper
          _buildResponsiveHelperSection(),
        ],
      ),
    );
  }

  /// بخش ۱: نمایش اطلاعات صفحه نمایش
  Widget _buildScreenInfoSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📱 اطلاعات صفحه نمایش',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            _infoRow('Width', '${Get.width.toStringAsFixed(1)} px'),
            _infoRow('Height', '${Get.height.toStringAsFixed(1)} px'),
            _infoRow('Pixel Ratio', Get.pixelRatio.toStringAsFixed(2)),
            _infoRow(
              'Aspect Ratio',
              (Get.width / Get.height).toStringAsFixed(2),
            ),
            _infoRow('Is Landscape', Get.width > Get.height ? 'Yes' : 'No'),
          ],
        ),
      ),
    );
  }

  /// بخش ۲: تست Extension های عددی (wp, hp, w, h)
  Widget _buildNumberExtensionsSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📐 تست Number Extensions',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            _infoRow('50% Width (50.wp)', '${50.0.wp.toStringAsFixed(1)} px'),
            _infoRow('30% Height (30.hp)', '${30.0.hp.toStringAsFixed(1)} px'),
            _infoRow('100 pixels width (100.w)', '${100.0.w.toStringAsFixed(1)} px'),
            _infoRow('80 pixels height (80.h)', '${80.0.h.toStringAsFixed(1)} px'),
            SizedBox(height: 12.h),
            // نمایش بصری
            Container(
              width: 50.0.wp,
              height: 30.0.hp,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.3),
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(8.w),
              ),
              child: Center(
                child: Text(
                  '50% × 30%',
                  style: TextStyle(
                    fontSize: 14.sp,
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

  /// بخش ۳: تست ResponsiveSize Extension (sp, ws, imgSize)
  Widget _buildResponsiveSizeSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '✨ تست ResponsiveSize Extension',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            _infoRow('Font 16.sp', '${16.sp.toStringAsFixed(1)} px'),
            _infoRow('Font 20.sp', '${20.sp.toStringAsFixed(1)} px'),
            _infoRow('Widget Size 24.ws', '${24.ws.toStringAsFixed(1)} px'),
            _infoRow('Image Size 100.imgSize', '${100.imgSize.toStringAsFixed(1)} px'),
            SizedBox(height: 12.h),
            // نمایش متن با اندازه‌های مختلف
            Text('Text with 14.sp', style: TextStyle(fontSize: 14.sp)),
            Text('Text with 16.sp', style: TextStyle(fontSize: 16.sp)),
            Text('Text with 20.sp', style: TextStyle(fontSize: 20.sp)),
            Text('Text with 24.sp', style: TextStyle(fontSize: 24.sp)),
            SizedBox(height: 12.h),
            // نمایش آیکون با اندازه واکنش‌گرا
            Row(
              children: [
                Icon(Icons.star, size: 16.ws, color: Colors.amber),
                SizedBox(width: 8.w),
                Icon(Icons.star, size: 24.ws, color: Colors.amber),
                SizedBox(width: 8.w),
                Icon(Icons.star, size: 32.ws, color: Colors.amber),
                SizedBox(width: 8.w),
                Icon(Icons.star, size: 48.ws, color: Colors.amber),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// بخش ۴: تست GetResponsiveBuilder
  Widget _buildResponsiveBuilderSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🔄 تست GetResponsiveBuilder',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            GetResponsiveBuilder(
              builder: (context, data) {
                return Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    border: Border.all(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Real-time Responsive Data:',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _infoRow('Width', '${data.width.toStringAsFixed(1)}'),
                      _infoRow('Height', '${data.height.toStringAsFixed(1)}'),
                      _infoRow('Device Type', data.deviceType),
                      _infoRow('Is Landscape', data.isLandscape.toString()),
                      _infoRow('Base Width', data.baseWidth.toStringAsFixed(0)),
                      _infoRow('Base Height', data.baseHeight.toStringAsFixed(0)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// بخش ۵: تست Device Type Detection
  Widget _buildDeviceTypeSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📱 تشخیص نوع دستگاه',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            _infoRow('Device Type', GetResponsiveHelper.deviceType),
            _infoRow('Is Phone', GetResponsiveHelper.isPhone.toString()),
            _infoRow('Is Tablet', GetResponsiveHelper.isTablet.toString()),
            _infoRow('Is Laptop', GetResponsiveHelper.isLaptop.toString()),
            _infoRow('Is Desktop', GetResponsiveHelper.isDesktop.toString()),
            SizedBox(height: 12.h),
            // نمایش آیکون بر اساس نوع دستگاه
            Center(
              child: Column(
                children: [
                  Icon(
                    _getDeviceIcon(),
                    size: 48.ws,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'شما از ${_getDeviceName()} استفاده می‌کنید',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// بخش ۶: تست Responsive Visibility
  Widget _buildResponsiveVisibilitySection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '👁️ تست Responsive Visibility',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.w),
              ),
              child: Text(
                'این متن همیشه نمایش داده می‌شود',
                style: TextStyle(fontSize: 14.sp),
              ),
            ).responsiveVisibility(
              phone: true,
              tablet: true,
              laptop: true,
              desktop: true,
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.w),
              ),
              child: Text(
                'این فقط روی موبایل نمایش داده می‌شود',
                style: TextStyle(fontSize: 14.sp),
              ),
            ).responsiveVisibility(
              phone: true,
              tablet: false,
              laptop: false,
              desktop: false,
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.w),
              ),
              child: Text(
                'این روی موبایل پنهان است',
                style: TextStyle(fontSize: 14.sp),
              ),
            ).responsiveVisibility(
              phone: false,
              tablet: true,
              laptop: true,
              desktop: true,
            ),
          ],
        ),
      ),
    );
  }

  /// بخش ۷: تست GetResponsiveHelper
  Widget _buildResponsiveHelperSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🛠️ تست GetResponsiveHelper',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            _infoRow('Helper.w(100)', GetResponsiveHelper.w(100).toStringAsFixed(1)),
            _infoRow('Helper.h(80)', GetResponsiveHelper.h(80).toStringAsFixed(1)),
            _infoRow('Helper.wp(25)', GetResponsiveHelper.wp(25).toStringAsFixed(1)),
            _infoRow('Helper.hp(15)', GetResponsiveHelper.hp(15).toStringAsFixed(1)),
            _infoRow('Helper.ws(24)', GetResponsiveHelper.ws(24).toStringAsFixed(1)),
            _infoRow('Helper.imgSize(100)', GetResponsiveHelper.imgSize(100).toStringAsFixed(1)),
            SizedBox(height: 12.h),
            // تست responsiveValue
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.1),
                border: Border.all(
                  color: GetResponsiveHelper.responsiveValue<Color>(
                    phone: Colors.blue,
                    tablet: Colors.green,
                    laptop: Colors.orange,
                    desktop: Colors.purple,
                    defaultValue: Colors.grey,
                  ),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8.w),
              ),
              child: Column(
                children: [
                  Text(
                    GetResponsiveHelper.responsiveValue<String>(
                      phone: '📱 موبایل',
                      tablet: '📱 تبلت',
                      laptop: '💻 لپتاپ',
                      desktop: '🖥️ دسکتاپ',
                      defaultValue: 'دستگاه نامشخص',
                    ),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'رنگ بوردر بر اساس نوع دستگاه تغییر می‌کند',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ویجت کمکی برای نمایش ردیف اطلاعات
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// دریافت آیکون بر اساس نوع دستگاه
  IconData _getDeviceIcon() {
    if (GetResponsiveHelper.isPhone) return Icons.phone_android;
    if (GetResponsiveHelper.isTablet) return Icons.tablet;
    if (GetResponsiveHelper.isLaptop) return Icons.laptop;
    if (GetResponsiveHelper.isDesktop) return Icons.desktop_windows;
    return Icons.devices;
  }

  /// دریافت نام فارسی دستگاه
  String _getDeviceName() {
    if (GetResponsiveHelper.isPhone) return 'موبایل';
    if (GetResponsiveHelper.isTablet) return 'تبلت';
    if (GetResponsiveHelper.isLaptop) return 'لپتاپ';
    if (GetResponsiveHelper.isDesktop) return 'دسکتاپ';
    return 'دستگاه نامشخص';
  }
}
