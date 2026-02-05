import 'package:flutter/material.dart';
import 'app_tour_controller.dart';
import 'app_tour_painter.dart';

class AppTourOverlay extends StatelessWidget {
  final AppTourController controller;
  final VoidCallback onFinish;

  const AppTourOverlay({
    super.key,
    required this.controller,
    required this.onFinish,
  });

  Rect? _getTargetRect(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return null;

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return null;

    final offset = renderObject.localToGlobal(Offset.zero);
    return offset & renderObject.size;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        if (controller.currentIndex >= controller.steps.length) {
          WidgetsBinding.instance.addPostFrameCallback((_) => onFinish());
          return const SizedBox();
        }

        final step = controller.currentStep;
        final rect = _getTargetRect(step.targetKey);
        if (rect == null) return const SizedBox();

        return Stack(
          children: [
            // 👇 FULL overlay ignores taps (lets Search & Cart work)
            IgnorePointer(
              ignoring: true,
              child: CustomPaint(
                size: MediaQuery.of(context).size,
                painter: AppTourPainter(rect),
              ),
            ),

            // 👇 Tooltip ENABLES taps
            Positioned(
              top: rect.bottom + 16,
              left: 20,
              right: 20,
              child: Material(
                color: Colors.transparent,
                child: _tooltip(step),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _tooltip(step) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(step.description),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: controller.skip,
                child: const Text("Skip"),
              ),
              ElevatedButton(
                onPressed:
                controller.isLast ? onFinish : controller.next,
                child: Text(controller.isLast ? "Done" : "Next"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
