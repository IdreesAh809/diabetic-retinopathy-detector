# eye_defect_detection

A Flutter app for detecting diabetic retinopathy stages using a custom trained TensorFlow Lite model.

---

## Getting Started

This Flutter project includes user authentication, image classification into 5 diabetic retinopathy stages, history tracking, and result display.

- The entire app logic is in `lib/main.dart` — login, registration, homepage, results, about, contact, logout.
- The TFLite model is located at `assets/model.tflite`.
- Dependencies and assets are defined in `pubspec.yaml`.

---

## Screenshots

### Login Screen  
<p align="center">
  <img src="assets/images/loginScreen.png" alt="Login Screen" width="400"/>
</p>

### Home Page  
<p align="center">
  <img src="assets/images/homePage.png" alt="Home Page" width="400"/>
</p>

### Menu  
<p align="center">
  <img src="assets/images/Menu.png" alt="Menu" width="400"/>
</p>

### Result Page  
<p align="center">
  <img src="assets/images/resultPage.png" alt="Result Page" width="400"/>
</p>

---

## About

The app detects 5 stages of diabetic retinopathy:

- No DR  
- Mild DR  
- Moderate DR  
- Severe DR  
- Proliferative DR

The model was trained by us and converted to TensorFlow Lite for on-device inference.

---

For more info on Flutter and TensorFlow Lite:  
- [Flutter Docs](https://docs.flutter.dev/)  
- [TensorFlow Lite](https://www.tensorflow.org/lite)  
