import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MainPageWidget(),
    );
  }
}

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({super.key});

  @override
  State<MainPageWidget> createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  late TextEditingController heightController;
  late TextEditingController weightController;

  // Variables de estado
  bool isCm = true;
  bool isKg = true;
  
  double? bmiScore;
  String bmiCategory = '-';
  Color bmiColor = Colors.grey;
  String bmiMessage = 'Introduce tus datos para calcular tu BMI.';

  @override
  void initState() {
    super.initState();
    heightController = TextEditingController();
    weightController = TextEditingController();
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  // Lógica matemática para calcular el BMI
  void _calculateBMI() {
    final double? height = double.tryParse(heightController.text);
    final double? weight = double.tryParse(weightController.text);

    // Verificamos que los datos sean válidos
    if (height == null || weight == null || height <= 0 || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa valores numéricos válidos.')),
      );
      return;
    }

    // Convertimos a estándar métrico (metros y kilogramos) si es necesario
    double heightInMeters = isCm ? height / 100 : height * 0.3048; // Pies a Metros
    double weightInKg = isKg ? weight : weight * 0.453592; // Libras a Kilogramos

    // Fórmula del BMI: peso / (altura * altura)
    double bmi = weightInKg / (heightInMeters * heightInMeters);

    // Actualizamos la interfaz con los resultados
setState(() {
      bmiScore = bmi;
      if (bmi < 18.5) {
        bmiCategory = 'Underweight';
        bmiColor = const Color(0xFF64B5F6); // Light blue
        bmiMessage = 'Your BMI is below the healthy range. Consider consulting a doctor or nutritionist.';
      } else if (bmi < 25) {
        bmiCategory = 'Normal';
        bmiColor = Colors.green;
        bmiMessage = 'Your BMI is within the healthy range. Maintain a balanced diet and exercise regularly!';
      } else if (bmi < 30) {
        bmiCategory = 'Overweight';
        bmiColor = Colors.orange;
        bmiMessage = 'Your BMI is above the healthy range. Consider adopting a healthier diet and exercising more.';
      } else {
        bmiCategory = 'Obese';
        bmiColor = Colors.red;
        bmiMessage = 'Your BMI is in the obesity category. Consulting a doctor is highly recommended.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF0F4F8),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A73E8),
          automaticallyImplyLeading: false,
          title: Text(
            'BMI Calculator',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                _buildHeightContainer(),
                const SizedBox(height: 16),
                _buildWeightContainer(),
                const SizedBox(height: 16),
                _buildCategoriesContainer(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _calculateBMI, // <--- Aquí enlazamos la función
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A73E8),
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Calculate BMI',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildResultsContainer(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeightContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Color(0x1A000000),
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.height, color: Color(0xFF1A73E8), size: 20),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Height',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF37474F),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => isCm = true),
                    child: Container(
                      width: 56,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isCm ? const Color(0xFF1A73E8) : const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'cm',
                        style: GoogleFonts.inter(
                          color: isCm ? Colors.white : const Color(0xFF1A73E8),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => isCm = false),
                    child: Container(
                      width: 56,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: !isCm ? const Color(0xFF1A73E8) : const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'ft',
                        style: GoogleFonts.inter(
                          color: !isCm ? Colors.white : const Color(0xFF1A73E8),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: isCm ? 'Enter height in cm' : 'Enter height in ft (e.g. 5.8)',
              hintStyle: GoogleFonts.inter(color: const Color(0xFFB0BEC5), fontSize: 16),
              filled: true,
              fillColor: const Color(0xFFF8F9FA),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFF1A73E8), width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            style: GoogleFonts.readexPro(
              color: const Color(0xFF37474F),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isCm ? 'Normal range: 150 – 190 cm' : 'Normal range: 4.9 – 6.2 ft',
                style: GoogleFonts.inter(color: const Color(0xFF90A4AE), fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeightContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Color(0x1A000000),
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.monitor_weight_outlined, color: Color(0xFF1A73E8), size: 20),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Weight',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF37474F),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => isKg = true),
                    child: Container(
                      width: 56,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isKg ? const Color(0xFF1A73E8) : const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'kg',
                        style: GoogleFonts.inter(
                          color: isKg ? Colors.white : const Color(0xFF1A73E8),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => isKg = false),
                    child: Container(
                      width: 56,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: !isKg ? const Color(0xFF1A73E8) : const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'lbs',
                        style: GoogleFonts.inter(
                          color: !isKg ? Colors.white : const Color(0xFF1A73E8),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: isKg ? 'Enter weight in kg' : 'Enter weight in lbs',
              hintStyle: GoogleFonts.inter(color: const Color(0xFFB0BEC5), fontSize: 16),
              filled: true,
              fillColor: const Color(0xFFF8F9FA),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFF1A73E8), width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            style: GoogleFonts.readexPro(
              color: const Color(0xFF37474F),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isKg ? 'Normal range: 50 – 100 kg' : 'Normal range: 110 – 220 lbs',
                style: GoogleFonts.inter(color: const Color(0xFF90A4AE), fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Color(0x1A000000),
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BMI Categories',
            style: GoogleFonts.inter(
              color: const Color(0xFF37474F),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildCategoryRow(const Color(0xFF64B5F6), 'Underweight', '< 18.5'),
          const SizedBox(height: 8),
          _buildCategoryRow(Colors.green, 'Normal', '18.5 – 24.9'),
          const SizedBox(height: 8),
          _buildCategoryRow(Colors.orange, 'Overweight', '25.0 – 29.9'),
          const SizedBox(height: 8),
          _buildCategoryRow(Colors.red, 'Obese', '≥ 30.0'),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(Color color, String label, String range) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          range,
          style: GoogleFonts.inter(
            color: const Color(0xFF90A4AE),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildResultsContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12,
            color: Color(0x1A000000),
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            'Your Result',
            style: GoogleFonts.inter(
              color: const Color(0xFF37474F),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: bmiColor.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: bmiColor, width: 4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bmiScore == null ? '0.0' : bmiScore!.toStringAsFixed(1),
                  style: GoogleFonts.readexPro(
                    color: bmiColor,
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'BMI Score',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF90A4AE),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 160,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: bmiColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              bmiCategory,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildResultStat('Height', heightController.text.isEmpty ? '-' : '${heightController.text} ${isCm ? 'cm' : 'ft'}'),
              Container(width: 1, height: 40, color: const Color(0xFFE0E0E0)),
              _buildResultStat('Weight', weightController.text.isEmpty ? '-' : '${weightController.text} ${isKg ? 'kg' : 'lbs'}'),
              Container(width: 1, height: 40, color: const Color(0xFFE0E0E0)),
              _buildResultStat('Category', bmiCategory, color: bmiColor),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bmiColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: bmiColor, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    bmiMessage,
                    style: GoogleFonts.inter(
                      color: bmiColor,
                      fontSize: 12,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultStat(String label, String value, {Color? color}) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.inter(color: const Color(0xFF90A4AE), fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.inter(
            color: color ?? const Color(0xFF37474F),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}