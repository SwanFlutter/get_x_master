import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:get_x_master/get_x_master.dart';
import 'package:material_ui/material_ui.dart';

import 'demo_entry.dart';
import 'demo_host.dart';
import 'demo_registry.dart';
import 'hub_settings.dart';

/// The single page from which every example can be opened and tested.
///
/// The page itself is drawn with Material widgets inside both shells; only
/// the chrome (app bar / navigation bar) follows the active shell.
class HubPage extends StatefulWidget {
  const HubPage({super.key});

  @override
  State<HubPage> createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
  final HubSettings _settings = Get.find<HubSettings>();
  final TextEditingController _search = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _open(DemoEntry entry) {
    try {
      entry.prepare?.call();
      Get.to(
        () => DemoHost(
          style: entry.style,
          child: Builder(builder: entry.builder),
        ),
      );
    } catch (e, s) {
      debugPrint('Demo "${entry.title}" failed to open: $e\n$s');
      _settings.mark(entry.title, ok: false);
    }
    // Otherwise the tester marks the result with the check / cross buttons.
  }

  List<DemoEntry> get _visible {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return demoRegistry;
    return demoRegistry
        .where((e) =>
            e.title.toLowerCase().contains(q) ||
            e.subtitle.toLowerCase().contains(q) ||
            e.category.label.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cupertino = _settings.cupertinoShell.value;
      final body = _buildBody(context, cupertino);
      if (cupertino) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: const Text('GetX Master Examples'),
            trailing: _shellSwitch(cupertino),
          ),
          child: SafeArea(
            child: Material(type: MaterialType.transparency, child: body),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('GetX Master Examples'),
          actions: [_shellSwitch(cupertino), const SizedBox(width: 8)],
        ),
        body: body,
      );
    });
  }

  Widget _shellSwitch(bool cupertino) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Cupertino'),
        const SizedBox(width: 4),
        // The Cupertino nav bar has no Material ancestor, so it must use
        // CupertinoSwitch; the Material app bar uses Switch.
        if (cupertino)
          CupertinoSwitch(
            value: cupertino,
            onChanged: (v) => _settings.setShell(cupertino: v),
          )
        else
          Switch(
            value: cupertino,
            onChanged: (v) => _settings.setShell(cupertino: v),
          ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, bool cupertino) {
    final entries = _visible;
    final total = demoRegistry.length;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _search,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search $total examples',
              border: const OutlineInputBorder(),
              isDense: true,
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'Active shell: ${cupertino ? 'GetCupertinoApp' : 'GetMaterialApp'}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const Spacer(),
              Text('✓ ${_settings.passed.length}   ✗ ${_settings.failed.length}   / $total'),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: entries.isEmpty
              ? const Center(child: Text('No example matches your search'))
              : ListView(
                  padding: const EdgeInsets.only(bottom: 24),
                  children: [
                    for (final category in DemoCategory.values)
                      ..._section(
                        category,
                        entries.where((e) => e.category == category).toList(),
                      ),
                  ],
                ),
        ),
      ],
    );
  }

  List<Widget> _section(DemoCategory category, List<DemoEntry> items) {
    if (items.isEmpty) return const <Widget>[];
    return <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Text(
          category.label,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      for (final entry in items) _tile(entry),
    ];
  }

  Widget _tile(DemoEntry entry) {
    final passed = _settings.passed.contains(entry.title);
    final failed = _settings.failed.contains(entry.title);

    return ListTile(
      leading: Icon(
        entry.style == DemoStyle.cupertino
            ? Icons.phone_iphone
            : Icons.android,
        color: passed
            ? Colors.green
            : failed
                ? Colors.red
                : null,
      ),
      title: Text(entry.title),
      subtitle: Text(entry.subtitle),
      onTap: () => _open(entry),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Mark as working',
            icon: Icon(
              Icons.check_circle,
              color: passed ? Colors.green : Colors.grey,
            ),
            onPressed: () => _settings.mark(entry.title, ok: true),
          ),
          IconButton(
            tooltip: 'Mark as broken',
            icon: Icon(
              Icons.cancel,
              color: failed ? Colors.red : Colors.grey,
            ),
            onPressed: () => _settings.mark(entry.title, ok: false),
          ),
        ],
      ),
    );
  }
}
