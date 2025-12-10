import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../viewmodel/pre_order_model.dart';

class DetailPOView extends StatefulWidget {
  final String? poId;

  const DetailPOView({super.key, this.poId});

  @override
  State<DetailPOView> createState() => _DetailPOViewState();
}

class _DetailPOViewState extends State<DetailPOView> {
  PreOrderModel? _poDetail;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPODetail();
  }

  Future<void> _fetchPODetail() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _poDetail = PreOrderModel(
        id: widget.poId ?? 'PO-UNDEFINED',
        supplierName: 'Supplier A',
        orderDate: DateTime(2024, 1, 15),
        deliveryDate: DateTime(2024, 1, 25),
        totalAmount: 5000000,
        status: 'approved',
        items: [
          POItem(
            productName: 'Product A',
            quantity: 100,
            price: 20000,
            unit: 'pcs',
          ),
          POItem(
            productName: 'Product B',
            quantity: 50,
            price: 60000,
            unit: 'pcs',
          ),
          POItem(
            productName: 'Product C',
            quantity: 75,
            price: 35000,
            unit: 'pcs',
          ),
        ],
      );
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pre-Order'),
        backgroundColor: AppColors.primary,
        actions: const [],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _poDetail == null
          ? const Center(child: Text('Data tidak ditemukan'))
          : _buildDetailContent(),
    );
  }

  Widget _buildDetailContent() {
    final po = _poDetail!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header gambar dihapus sesuai permintaan
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('ID PO', po.id),
                  _buildDetailRow('Supplier', po.supplierName),
                  _buildDetailRow('Tanggal Pesan', _formatDate(po.orderDate)),
                  _buildDetailRow(
                    'Tanggal Kirim',
                    _formatDate(po.deliveryDate),
                  ),
                  _buildDetailRow(
                    'Total',
                    'Rp ${po.totalAmount.toStringAsFixed(0)}',
                  ),
                  const SizedBox(height: 8),
                  // Informasi jadwal panen & kondisi panen saat ini
                  Text(
                    'Informasi Panen',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDetailRow('Jadwal Panen', _getHarvestSchedule()),
                  _buildDetailRow('Kondisi Panen', _getHarvestCondition()),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  // Badge status dihapus sesuai permintaan

  // Item produk dihilangkan sesuai permintaan

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return AppColors.success;
      case 'pending':
        return AppColors.warning;
      case 'rejected':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  // Jadwal panen dan kondisi panen dummy yang relevan untuk demo UI
  String _getHarvestSchedule() {
    // Contoh: gunakan tanggal kirim sebagai estimasi panen - 2 hari
    final po = _poDetail!;
    final estimate = po.deliveryDate.subtract(const Duration(days: 2));
    return '${estimate.day}/${estimate.month}/${estimate.year} (Estimasi)';
  }

  String _getHarvestCondition() {
    // Contoh kondisi berdasarkan status PO
    final status = _poDetail!.status;
    if (status == 'approved') return 'Siap panen dalam beberapa hari';
    if (status == 'pending') return 'Dalam persiapan, monitoring cuaca';
    if (status == 'rejected') return 'Tertunda, menunggu konfirmasi ulang';
    return 'Normal';
  }

  // Gambar kategori dihapus
}
