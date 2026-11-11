import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  double? hasilBMI;
  String _keterangan = 'Masukkan data kamu';
  String _jenisKelamin = 'Laki-laki';
  bool _sudahDihitung = false;

  void _logikaBMI() {
    final double? bb = double.tryParse(_bbController.text.replaceAll(',', '.'));
    final double? tb = double.tryParse(_tbController.text.replaceAll(',', '.'));

    if (bb == null || tb == null || bb <= 0 || tb <= 0) {
      setState(() {
        hasilBMI = null;
        _keterangan = 'Masukkan berat dan tinggi yang valid';
        _sudahDihitung = false;
      });
      return;
    }

    final double tbMeter = tb / 100;
    final double bmi = bb / (tbMeter * tbMeter);

    String keterangan;

    if (bmi < 18.5) {
      keterangan = 'Berat badan kurang';
    } else if (bmi < 25) {
      keterangan = 'Berat badan normal';
    } else if (bmi < 30) {
      keterangan = 'Berat badan berlebih';
    } else {
      keterangan = 'Obesitas';
    }

    setState(() {
      hasilBMI = bmi;
      _keterangan = keterangan;
      _sudahDihitung = true;
    });
  }

  void _resetBMI() {
    _bbController.clear();
    _tbController.clear();

    setState(() {
      hasilBMI = null;
      _keterangan = 'Masukkan data kamu';
      _jenisKelamin = 'Laki-laki';
      _sudahDihitung = false;
    });
  }

  @override
  void dispose() {
    _bbController.dispose();
    _tbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      appBar: AppBar(
        title: const Text(
          ' BMI Calculator',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 87, 1, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.fitness_center,
                size: 65,
                color: Color.fromARGB(255, 87, 1, 1),
              ),
              const SizedBox(height: 10),
              const Text(
                'Mari Hitung BMI Kamu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 87, 1, 1),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Masukkan data anda untuk menghitung BMI',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color.fromARGB(255, 87, 1, 1)),
              ),
              const SizedBox(height: 25),

              // Kartu hasil BMI
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 87, 1, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'HASIL BMI KAMU',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      hasilBMI?.toStringAsFixed(1) ?? '--',
                      style: const TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _keterangan,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    if (_sudahDihitung) ...[
                      const SizedBox(height: 10),
                      Text(
                        'Jenis kelamin: $_jenisKelamin',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Jenis Kelamin',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(child: _pilihanGender('Laki-laki', Icons.male)),
                  const SizedBox(width: 12),
                  Expanded(child: _pilihanGender('Perempuan', Icons.female)),
                ],
              ),

              const SizedBox(height: 22),

              TextField(
                controller: _bbController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Berat Badan (kg)',
                  prefixIcon: const Icon(Icons.monitor_weight),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _tbController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Tinggi Badan (cm)',
                  prefixIcon: const Icon(Icons.height),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              ElevatedButton.icon(
                onPressed: _logikaBMI,
                icon: const Icon(Icons.calculate),
                label: const Text('Hitung BMI'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 87, 1, 1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                onPressed: _resetBMI,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF795548),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFF795548)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Kategori BMI dewasa:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text('• Kurang dari 18,5: Berat badan kurang'),
              const Text('• 18,5–24,9: Berat badan normal'),
              const Text('• 25–29,9: Berat badan berlebih'),
              const Text('• 30 ke atas: Obesitas'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pilihanGender(String gender, IconData ikon) {
    final bool terpilih = _jenisKelamin == gender;

    return InkWell(
      onTap: () {
        setState(() {
          _jenisKelamin = gender;
        });
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: terpilih ? const Color(0xFFD7CCC8) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: terpilih ? const Color(0xFF795548) : Colors.grey.shade300,
            width: terpilih ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(ikon, size: 30, color: const Color(0xFF795548)),
            const SizedBox(height: 5),
            Text(gender, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
