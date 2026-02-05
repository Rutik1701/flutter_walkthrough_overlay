import 'package:flutter/material.dart';
import '../walkthrough_overlay/app_tour_controller.dart';
import '../walkthrough_overlay/app_tour_overlay.dart';
import '../walkthrough_overlay/app_tour_step.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final GlobalKey keySearch = GlobalKey();
  final GlobalKey keyCart = GlobalKey();

  late AppTourController controller;
  bool showTour = false;

  @override
  void initState() {
    super.initState();

    controller = AppTourController([
      AppTourStep(
        targetKey: keySearch,
        title: "Search",
        description: "Search products from here",
      ),
      AppTourStep(
        targetKey: keyCart,
        title: "Cart",
        description: "View your cart here",
      ),
    ]);

    // ✅ start tour AFTER layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => showTour = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Walkthrough Demo"),
        actions: [
          IconButton(
            key: keySearch,
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            key: keyCart,
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          const Center(
            child: Text(
              "Home Screen",
              style: TextStyle(fontSize: 18),
            ),
          ),

          if (showTour)
            AppTourOverlay(
              controller: controller,
              onFinish: () {
                setState(() => showTour = false);
              },
            ),
        ],
      ),
    );
  }
}
