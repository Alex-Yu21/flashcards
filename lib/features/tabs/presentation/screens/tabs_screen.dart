import 'package:flashcards/features/categories/presentation/screens/categories_screen.dart';
import 'package:flashcards/features/home/presentation/screens/home_screen.dart';
import 'package:flashcards/features/tabs/presentation/widgets/app_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _barHeight = kBottomNavigationBarHeight;

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  static TabsScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<TabsScreenState>();

  @override
  State<TabsScreen> createState() => TabsScreenState();
}

class TabsScreenState extends State<TabsScreen> {
  int _current = 0;
  void switchTo(int index) => setState(() => _current = index);
  late final List<GlobalKey<NavigatorState>> _navKeys;
  late final List<bool> _tabHasInnerRoute;
  late final List<Widget> _rootPages;

  @override
  void initState() {
    super.initState();
    _navKeys = List.generate(4, (_) => GlobalKey<NavigatorState>());
    _tabHasInnerRoute = List.filled(4, false);
    _rootPages = const [
      HomeScreen(),
      CategoriesScreen(),
      CollectionsScreen(),
      SettingsScreen(),
    ];
  }

  void _updateCanPop(int i) {
    final canPop = _navKeys[i].currentState!.canPop();
    if (canPop != _tabHasInnerRoute[i]) {
      setState(() => _tabHasInnerRoute[i] = canPop);
    }
  }

  bool get _showBottomBar => !_tabHasInnerRoute[_current];

  void _handlePop(bool didPop, Object? result) {
    if (didPop) return;
    final nav = _navKeys[_current].currentState!;
    if (nav.canPop()) {
      nav.pop();
    } else if (_current != 0) {
      setState(() => _current = 0);
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _handlePop,
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          child:
              _showBottomBar
                  ? AppBottomNavBar(
                    key: const ValueKey('visibleBar'),
                    currentIndex: _current,
                    onItemSelected: (i) => setState(() => _current = i),
                  )
                  : SizedBox(
                    key: const ValueKey('stub'),
                    height: _barHeight + bottomPad,
                  ),
        ),
        body: IndexedStack(
          index: _current,
          children: List.generate(
            _rootPages.length,
            (i) => _TabNavigator(
              navigatorKey: _navKeys[i],
              rootPage: _rootPages[i],
              observer: _StackObserver(() => _updateCanPop(i)),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabNavigator extends StatelessWidget {
  const _TabNavigator({
    required this.navigatorKey,
    required this.rootPage,
    required this.observer,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget rootPage;
  final NavigatorObserver observer;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      observers: [observer],
      onGenerateRoute: (settings) {
        if (settings.name == '/' || settings.name == null) {
          return MaterialPageRoute(builder: (_) => rootPage);
        }
        final builder = settings.arguments as WidgetBuilder;
        return MaterialPageRoute(builder: builder);
      },
    );
  }
}

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Collections')),
    body: const Center(child: Text('Collections screen')),
  );
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Settings')),
    body: const Center(child: Text('Settings screen')),
  );
}

class _StackObserver extends NavigatorObserver {
  _StackObserver(this.onChanged);
  final VoidCallback onChanged;
  void _notify() => onChanged();

  @override
  void didPush(Route route, Route? previous) => _notify();

  @override
  void didPop(Route route, Route? previous) {
    if (route is TransitionRoute && route.animation != null) {
      route.animation!.addStatusListener((status) {
        if (status == AnimationStatus.dismissed) _notify();
      });
    } else {
      _notify();
    }
  }

  @override
  void didRemove(Route route, Route? previous) => _notify();
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      _notify();
}
