import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ProcessStatusView extends StatelessWidget {
  final String? categoryName;
  const ProcessStatusView({super.key, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sedang Diproses'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar header dihapus sesuai permintaan
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Status Proses',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Pesanan Anda sedang dalam proses penyiapan dan pengepakan.',
                    ),
                    SizedBox(height: 4),
                    Text('Perkiraan selesai: 1-2 hari kerja.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
