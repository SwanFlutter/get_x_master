import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

// =============================================================================
// Simulated auth service
// =============================================================================

class _FakeAuth {
  static bool isLoggedIn = false;
  static bool hasPremium = false;
}

// =============================================================================
// Home — entry point for all tests
// =============================================================================

class ConditionalNavTestHome extends StatefulWidget {
  const ConditionalNavTestHome({super.key});

  @override
  State<ConditionalNavTestHome> createState() => _ConditionalNavTestHomeState();
}

class _ConditionalNavTestHomeState extends State<ConditionalNavTestHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ConditionalNavigation Tests'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Auth toggle ─────────────────────────────────────────────────
          _SectionHeader('Auth State'),
          _AuthToggleTile(),
          const SizedBox(height: 8),
          _PremiumToggleTile(),
          const SizedBox(height: 20),

          // ── Get.to() tests ───────────────────────────────────────────────
          _SectionHeader('Get.to() with ConditionalNavigation'),
          _TestTile(
            label: 'rightToLeft transition',
            subtitle: 'Login (logged out) → Dashboard (logged in)',
            color: Colors.blue,
            onTap: () => Get.to(
              () => const _DashboardScreen(),
              transition: Transition.rightToLeft,
              condition: ConditionalNavigation(
                condition: () => _FakeAuth.isLoggedIn,
                truePage: () => const _DashboardScreen(),
                falsePage: () => const _LoginScreen(),
              ),
            ),
          ),
          _TestTile(
            label: 'fade transition',
            subtitle: 'Same logic, different animation',
            color: Colors.teal,
            onTap: () => Get.to(
              () => const _DashboardScreen(),
              transition: Transition.fade,
              condition: ConditionalNavigation(
                condition: () => _FakeAuth.isLoggedIn,
                truePage: () => const _DashboardScreen(),
                falsePage: () => const _LoginScreen(),
              ),
            ),
          ),
          _TestTile(
            label: 'zoom transition (premium gate)',
            subtitle: 'Premium page (premium) → Upgrade page',
            color: Colors.purple,
            onTap: () => Get.to(
              () => const _PremiumScreen(),
              transition: Transition.zoom,
              condition: ConditionalNavigation(
                condition: () => _FakeAuth.hasPremium,
                truePage: () => const _PremiumScreen(),
                falsePage: () => const _UpgradeScreen(),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ── Get.off() tests ──────────────────────────────────────────────
          _SectionHeader('Get.off() with ConditionalNavigationOff'),
          _TestTile(
            label: 'off + rightToLeft',
            subtitle: 'Replaces current route',
            color: Colors.orange,
            onTap: () => Get.off(
              () => const _DashboardScreen(),
              transition: Transition.rightToLeft,
              conditionOff: ConditionalNavigationOff(
                condition: () => _FakeAuth.isLoggedIn,
                truePage: () => const _DashboardScreen(),
                falsePage: () => const _LoginScreen(),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ── Get.offAll() tests ───────────────────────────────────────────
          _SectionHeader('Get.offAll() with ConditionalNavigationOffAll'),
          _TestTile(
            label: 'offAll + downToUp',
            subtitle: 'Clears stack and navigates',
            color: Colors.red,
            onTap: () => Get.offAll(
              () => const _DashboardScreen(),
              transition: Transition.downToUp,
              conditionOffAll: ConditionalNavigationOffAll(
                condition: () => _FakeAuth.isLoggedIn,
                truePage: () => const _DashboardScreen(),
                falsePage: () => const _LoginScreen(),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ── preventDuplicates sanity test ────────────────────────────────
          _SectionHeader('preventDuplicates sanity check'),
          _TestTile(
            label: 'Tap twice — should navigate both times',
            subtitle: 'Second tap should NOT be silently blocked',
            color: Colors.brown,
            onTap: () => Get.to(
              () => const _DashboardScreen(),
              transition: Transition.rightToLeft,
              preventDuplicates: false,
              condition: ConditionalNavigation(
                condition: () => _FakeAuth.isLoggedIn,
                truePage: () => const _DashboardScreen(),
                falsePage: () => const _LoginScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Toggle tiles
// =============================================================================

class _AuthToggleTile extends StatefulWidget {
  @override
  State<_AuthToggleTile> createState() => _AuthToggleTileState();
}

class _AuthToggleTileState extends State<_AuthToggleTile> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text('isLoggedIn'),
      subtitle: Text(_FakeAuth.isLoggedIn ? '✅ Logged in' : '❌ Logged out'),
      value: _FakeAuth.isLoggedIn,
      activeThumbColor: Colors.green,
      onChanged: (v) => setState(() => _FakeAuth.isLoggedIn = v),
    );
  }
}

class _PremiumToggleTile extends StatefulWidget {
  @override
  State<_PremiumToggleTile> createState() => _PremiumToggleTileState();
}

class _PremiumToggleTileState extends State<_PremiumToggleTile> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text('hasPremium'),
      subtitle: Text(_FakeAuth.hasPremium ? '⭐ Premium' : '🔒 Free tier'),
      value: _FakeAuth.hasPremium,
      activeThumbColor: Colors.amber,
      onChanged: (v) => setState(() => _FakeAuth.hasPremium = v),
    );
  }
}

// =============================================================================
// Shared UI helpers
// =============================================================================

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Colors.grey,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _TestTile extends StatelessWidget {
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _TestTile({
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(Icons.play_arrow_rounded, color: color),
        ),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

// =============================================================================
// Destination screens
// =============================================================================

class _LoginScreen extends StatelessWidget {
  const _LoginScreen();

  @override
  Widget build(BuildContext context) {
    return _ResultScreen(
      title: 'Login Page',
      icon: Icons.lock_outline,
      color: Colors.red,
      message: 'You are NOT logged in.\nConditional redirected here.',
    );
  }
}

class _DashboardScreen extends StatelessWidget {
  const _DashboardScreen();

  @override
  Widget build(BuildContext context) {
    return _ResultScreen(
      title: 'Dashboard',
      icon: Icons.dashboard_outlined,
      color: Colors.green,
      message: 'You ARE logged in.\nConditional navigated here.',
    );
  }
}

class _PremiumScreen extends StatelessWidget {
  const _PremiumScreen();

  @override
  Widget build(BuildContext context) {
    return _ResultScreen(
      title: 'Premium Content',
      icon: Icons.star_outline,
      color: Colors.amber,
      message: 'You have Premium.\nConditional navigated here.',
    );
  }
}

class _UpgradeScreen extends StatelessWidget {
  const _UpgradeScreen();

  @override
  Widget build(BuildContext context) {
    return _ResultScreen(
      title: 'Upgrade Required',
      icon: Icons.lock_outline,
      color: Colors.purple,
      message: 'You do NOT have Premium.\nConditional redirected here.',
    );
  }
}

class _ResultScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String message;

  const _ResultScreen({
    required this.title,
    required this.icon,
    required this.color,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 72, color: color),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}
