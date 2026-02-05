# Flutter Walkthrough Overlay (Custom App Tour)

A lightweight, dependency-free **Flutter App Tour / Walkthrough Overlay**
to highlight UI elements and guide users through app features.

Built using Flutter’s `Overlay`, `CustomPainter`, and `GlobalKey` —
fully customizable and **package-ready**.

---

## ✨ Features

- 🔍 Highlight any widget using `GlobalKey`
- 🌑 Dark overlay with spotlight cut-out
- 💬 Custom tooltip with title & description
- ▶️ Next / Skip / Done actions
- 🔁 Multi-step walkthrough support
- ⚡ No third-party dependencies
- 🧩 Clean & reusable architecture
- 🛡 Safe layout handling (no null crashes)


---

## ✨ Preview





https://github.com/user-attachments/assets/a15bc834-48ef-46da-8003-a8f42ce40d61



---

## ✨ Installation
Add this to your package's pubspec.yaml file:
```
```yaml
dependencies:
  flutter_walkthrough_overlay:
    path: ../flutter_walkthrough_overlay
```
▶️ From GitHub
```
dependencies:
  flutter_walkthrough_overlay:
    git:
      url: https://github.com/yourusername/flutter_walkthrough_overlay.git

```
Then Run:
```
flutter pub get
```
## 📁 Folder Structure
```
lib/
├── walkthrough_overlay/
│ ├── app_tour_controller.dart
│ ├── app_tour_overlay.dart
│ ├── app_tour_painter.dart
│ └── app_tour_step.dart
└── demo_screen.dart
  ```
## 🚀 👤 User Side Usage (Developer Experience)


## 1️⃣ Create keys for widgets (USER CODE)
```
final GlobalKey searchKey = GlobalKey();
final GlobalKey cartKey = GlobalKey();
```
2️⃣ Create walkthrough steps (USER CODE)
```
late AppTourController tourController;
bool showTour = false;

@override
void initState() {
  super.initState();

  tourController = AppTourController([
    AppTourStep(
      targetKey: searchKey,
      title: "Search",
      description: "Search products from here",
    ),
    AppTourStep(
      targetKey: cartKey,
      title: "Cart",
      description: "View your cart items here",
    ),
  ]);

  // Start tour AFTER screen is rendered
  WidgetsBinding.instance.addPostFrameCallback((_) {
    setState(() => showTour = true);
  });
}

```

## 3️⃣ Attach keys to widgets (USER CODE)
```
AppBar(
  title: const Text("Home"),
  actions: [
    IconButton(
      key: searchKey,
      icon: const Icon(Icons.search),
      onPressed: () {
        debugPrint("Search clicked");
      },
    ),
    IconButton(
      key: cartKey,
      icon: const Icon(Icons.shopping_cart),
      onPressed: () {
        debugPrint("Cart clicked");
      },
    ),
  ],
)

```
## 4️⃣ Wrap screen with Stack & overlay (USER CODE)
```
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Walkthrough Demo"),
      actions: [
        IconButton(
          key: searchKey,
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          key: cartKey,
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {},
        ),
      ],
    ),
    body: Stack(
      children: [
        // 👇 Main Screen UI
        const Center(
          child: Text(
            "Home Screen",
            style: TextStyle(fontSize: 18),
          ),
        ),

        // 👇 Walkthrough Overlay
        if (showTour)
          AppTourOverlay(
            controller: tourController,
            onFinish: () {
              setState(() => showTour = false);
            },
          ),
      ],
    ),
  );
}


```
## 📜 License
MIT License
```
Copyright (c) 2025 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy  
of this software and associated documentation files (the "Software"), to deal  
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
copies of the Software, and to permit persons to whom the Software is  
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.

