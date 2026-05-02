# Flutter BMI Calculator

A clean, responsive Body Mass Index (BMI) Calculator built with Flutter. This app helps you quickly assess your weight category based on your height and weight, with support for both metric and imperial units.

## Features

- **Dual Unit Support**
  - Height: cm ↔ ft/in
  - Weight: kg ↔ lbs
  - Automatic conversion when toggling between units (no data loss)

- **BMI Calculation**
  - Calculate on button press or in real-time
  - Instant visual feedback

- **Results & Categories**
  - Underweight (Light Blue)
  - Normal (Blue)
  - Overweight (Orange)
  - Obese (Red)

## How It Works

1. The user selects their preferred unit system (cm/kg or ft/lbs).
2. Values are internally converted to metric (meters and kg) to compute BMI using the formula:
BMI = weight (kg) / (height (m))²
3. The result is compared against standard WHO BMI ranges:
- < 18.5 → Underweight
- 18.5 – 24.9 → Normal
- 25 – 29.9 → Overweight
- ≥ 30 → Obese
4. The result card changes color based on the category for instant visual understanding.

## What It's For

This app is ideal for:
- Quick health self-assessments
- Educational purposes (teaching BMI concepts)
- Integration into larger health/fitness apps

## Getting Started

```bash
# Clone the repository
git clone https://github.com/Leonel-VC/BMI-Flutter.git

# Navigate to project
cd BMI-Flutter

# Get dependencies
flutter pub get

# Run the app
flutter run
```


---

# Spanish Version

# Calculadora de IMC con Flutter

Una calculadora de Índice de Masa Corporal (IMC) limpia, responsiva, desarrollada con Flutter. Esta app te ayuda a evaluar rápidamente tu categoría de peso según tu altura y peso, con soporte para unidades métricas e imperiales.

## Características

- **Doble sistema de unidades**
  - Altura: cm ↔ ft/pulg
  - Peso: kg ↔ lbs
  - Conversión automática al cambiar de unidad (sin pérdida de datos)

- **Cálculo del IMC**
  - Al presionar un botón o en tiempo real
  - Retroalimentación visual instantánea

- **Resultados y categorías**
  - Bajo peso (Azul claro)
  - Normal (Azul)
  - Sobrepeso (Naranja)
  - Obesidad (Rojo)

## ¿Cómo funciona?

1. El usuario selecciona su sistema de unidades preferido (cm/kg o ft/lbs).
2. Los valores se convierten internamente a unidades métricas (metros y kg) para calcular el IMC usando la fórmula:
IMC = peso (kg) / (altura (m))²
3. El resultado se compara con los rangos estándar de la OMS:
- < 18.5 → Bajo peso
- 18.5 – 24.9 → Normal
- 25 – 29.9 → Sobrepeso
- ≥ 30 → Obesidad
4. La tarjeta de resultado cambia de color según la categoría para una comprensión visual inmediata.

## ¿Para qué sirve?

Esta app es ideal para:
- Evaluaciones rápidas de salud personal
- Fines educativos (enseñar el concepto de IMC)
- Integración en apps más grandes de salud o fitness

## Cómo empezar

```bash
# Clonar el repositorio
git clone https://github.com/Leonel-VC/BMI-Flutter.git

# Entrar al proyecto
cd BMI-Flutter

# Obtener dependencias
flutter pub get

# Ejecutar la app
flutter run
```

https://github.com/user-attachments/assets/da2d35bb-c724-409d-b5bb-42fad77147c7

