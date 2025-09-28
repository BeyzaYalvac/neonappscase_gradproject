import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    required this.children,
    required this.distance,
  });

  final List<Widget> children;
  final double distance;

  @override
  ExpandableFabState createState() => ExpandableFabState();
}

class ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
    );
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          IgnorePointer(
            ignoring: !_open,
            child: AnimatedOpacity(
              opacity: _open ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Stack(children: _buildExpandableFabButton()),
            ),
          ),
          _mainFab(),
        ],
      ),
    );
  }

  Widget _mainFab() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 32),
      child: SizedBox(
        height: 56,
        width: 56,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.bgSmoothDark),
            borderRadius: BorderRadius.circular(16),
          ),
          tooltip: _open ? 'Kapat' : 'Oluştur',
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? AppColors.bgPrimary
              : AppColors.bgTriartry,
          foregroundColor: Theme.of(context).brightness == Brightness.light
              ? AppColors.bgTriartry
              : AppColors.bgPrimary,
          onPressed: _toggle,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeOutBack,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, anim) {
              return FadeTransition(
                opacity: anim,
                child: RotationTransition(
                  turns: Tween<double>(begin: 0.75, end: 1.0).animate(anim),
                  child: child,
                ),
              );
            },
            // İKİ tarafa da key ver + IconTheme KALDIR (renk = FAB.foregroundColor)
            child: _open
                ? const Icon(Icons.close, key: ValueKey('close'))
                : const Icon(Icons.add, key: ValueKey('create')),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandableFabButton() {
    final List<Widget> children = <Widget>[];
    final count = widget.children.length;
    if (count == 0) return children;

    // 90°'lik yay
    final step = count == 1 ? 0.0 : 90.0 / (count - 1);

    for (
      var i = 0, angleInDegrees = 0.0;
      i < count;
      i++, angleInDegrees += step
    ) {
      children.add(
        _ExpandableFabItem(
          directionDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }
}

// Tek tek yayılan item
class _ExpandableFabItem extends StatelessWidget {
  const _ExpandableFabItem({
    required this.directionDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionDegrees * (math.pi / 180),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 16.0 + offset.dx,
          bottom: 16.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child,
          ),
        );
      },
      child: FadeTransition(opacity: progress, child: child),
    );
  }
}
