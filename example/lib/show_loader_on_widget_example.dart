import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';
import 'package:toastification/toastification.dart';

/// Controller to handle logic for the ShowLoaderOnWidget example.
class LoaderExampleController extends GetXController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  /// GlobalKey used to identify the widget where the loader will be shown.
  final GlobalKey targetKey = GlobalKey();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final validator = PasswordValidator();

  Future<void> login() async {
    // Simulate a network request or any async task
    await Future.delayed(const Duration(seconds: 2));
    CustomToast.success(
        title: "Success", description: "Logged in successfully!");
  }

  void checkLogin() async {
    if (phoneController.text.isEmpty) {
      CustomToast.warning(
        title: "هشدار",
        description: 'شماره تلفن یا ایمیل را وارد کنید',
      );
    } else if (!phoneController.text.isEmail) {
      CustomToast.warning(title: "هشدار", description: 'فرمت ایمیل معتبر نیست');
    } else if (passwordController.text.isEmpty) {
      CustomToast.warning(title: "هشدار", description: 'رمز عبور را وارد کنید');
    } else if (!validator.validate(passwordController.text)) {
      CustomToast.warning(
        title: "هشدار",
        description: 'رمز عبور باید حداقل ۸ کاراکتر باشد',
      );
    } else {
      _isLoading.value = true;

      // Use showLoaderOnWidget with 1.0 opacity to cover text
      await Get.showLoaderOnWidget(
        targetKey: targetKey,
        asyncFunction: () => login(),
        borderRadius: BorderRadius.circular(12),
        opacity: 1.0,
        opacityColor: Colors.blue,
        loadingWidget: const CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3,
        ),
      );

      _isLoading.value = false;
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

/// This example demonstrates the usage of [Get.showLoaderOnWidget] using GetX pattern.
class ShowLoaderOnWidgetExample extends GetView<LoaderExampleController> {
  const ShowLoaderOnWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('showLoaderOnWidget (GetX Pattern)'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone or Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32),

            // Reactive Button using Obx
            Obx(() => ElevatedButton(
                  key: controller.targetKey,
                  onPressed:
                      controller.isLoading ? null : controller.checkLogin,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: controller.isLoading
                      ? const SizedBox.shrink()
                      : const Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                )),
          ],
        ),
      ),
    );
  }
}

/// کلاس سفارشی برای مدیریت Toast ها
/// استفاده آسان در تمام پروژه
class CustomToast {
  // جلوگیری از ساخت instance
  CustomToast._();

  /// تنظیمات پیش‌فرض
  static const Duration _defaultDuration = Duration(seconds: 3);
  static const Alignment _defaultAlignment = Alignment.topRight;

  /// نمایش Toast موفقیت‌آمیز
  static ToastificationItem success({
    required String title,
    String? description,
    Duration? duration,
    Alignment? alignment,
    VoidCallback? onTap,
    ToastificationStyle style = ToastificationStyle.fillColored,
  }) {
    return Toastification.show(
      type: ToastificationType.success,
      style: style,
      title: Text(title),
      description: description != null ? Text(description) : null,
      alignment: alignment ?? _defaultAlignment,
      autoCloseDuration: duration ?? _defaultDuration,
      showProgressBar: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onTap: onTap != null ? (_) => onTap() : null,
      ),
    );
  }

  /// نمایش Toast خطا
  static ToastificationItem error({
    required String title,
    String? description,
    Duration? duration,
    Alignment? alignment,
    VoidCallback? onTap,
    ToastificationStyle style = ToastificationStyle.fillColored,
  }) {
    return Toastification.show(
      type: ToastificationType.error,
      style: style,
      title: Text(title),
      description: description != null ? Text(description) : null,
      alignment: alignment ?? _defaultAlignment,
      autoCloseDuration: duration ?? _defaultDuration,
      showProgressBar: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onTap: onTap != null ? (_) => onTap() : null,
      ),
    );
  }

  /// نمایش Toast هشدار
  static ToastificationItem warning({
    required String title,
    String? description,
    Duration? duration,
    Alignment? alignment,
    VoidCallback? onTap,
    ToastificationStyle style = ToastificationStyle.fillColored,
  }) {
    return Toastification.show(
      type: ToastificationType.warning,
      style: style,
      title: Text(title),
      description: description != null ? Text(description) : null,
      alignment: alignment ?? _defaultAlignment,
      autoCloseDuration: duration ?? _defaultDuration,
      showProgressBar: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onTap: onTap != null ? (_) => onTap() : null,
      ),
    );
  }

  /// نمایش Toast اطلاعات
  static ToastificationItem info({
    required String title,
    String? description,
    Duration? duration,
    Alignment? alignment,
    VoidCallback? onTap,
    ToastificationStyle style = ToastificationStyle.fillColored,
  }) {
    return Toastification.show(
      type: ToastificationType.info,
      style: style,
      title: Text(title),
      description: description != null ? Text(description) : null,
      alignment: alignment ?? _defaultAlignment,
      autoCloseDuration: duration ?? _defaultDuration,
      showProgressBar: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onTap: onTap != null ? (_) => onTap() : null,
      ),
    );
  }

  /// نمایش Toast لودینگ
  static ToastificationItem loading({
    required String title,
    String? description,
    Alignment? alignment,
  }) {
    return Toastification.showCustom(
      alignment: alignment ?? _defaultAlignment,
      autoCloseDuration: null, // بدون بسته شدن خودکار
      builder: (context, item) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(width: 12),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// نمایش Toast سفارشی با دکمه اکشن
  static ToastificationItem withAction({
    required String title,
    String? description,
    required String actionText,
    required VoidCallback onActionPressed,
    ToastificationType type = ToastificationType.info,
    Duration? duration,
    Alignment? alignment,
  }) {
    return Toastification.showCustom(
      alignment: alignment ?? _defaultAlignment,
      autoCloseDuration: duration ?? _defaultDuration,
      builder: (context, item) {
        Color bgColor;
        Color textColor = Colors.white;

        switch (type) {
          case ToastificationType.success:
            bgColor = Colors.green;
            break;
          case ToastificationType.error:
            bgColor = Colors.red;
            break;
          case ToastificationType.warning:
            bgColor = Colors.orange;
            break;
          case ToastificationType.info:
          default:
            bgColor = Colors.blue;
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    if (description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          color: textColor.withValues(alpha: 0.9),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () {
                  onActionPressed();
                  Toastification().dismiss(item);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  foregroundColor: textColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                child: Text(actionText),
              ),
            ],
          ),
        );
      },
    );
  }

  /// بستن همه Toast ها
  static void dismissAll() {
    Toastification().dismissAll();
  }

  /// بستن Toast با ID
  static void dismissById(String id) {
    Toastification().dismissById(id);
  }

  /// بستن یک Toast خاص
  static void dismiss(ToastificationItem item) {
    Toastification().dismiss(item);
  }
}
