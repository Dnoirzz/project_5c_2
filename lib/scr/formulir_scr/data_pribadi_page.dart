import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataPribadiPage extends StatefulWidget {
  const DataPribadiPage({super.key});

  @override
  State<DataPribadiPage> createState() => _DataPribadiPageState();
}

class _DataPribadiPageState extends State<DataPribadiPage> {
  DateTime? _tanggalLahir;
  String? _jenisKelamin;

  // TextEditingController untuk setiap field
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _namaLengkapController.dispose();
    _nikController.dispose();
    _tempatLahirController.dispose();
    _alamatController.dispose();
    _noHpController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggalLahir ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _tanggalLahir = picked);
    }
  }

  String _formatTanggalLahir() {
    if (_tanggalLahir == null) return "Pilih tanggal lahir";
    return DateFormat('dd MMM yyyy', 'id_ID').format(_tanggalLahir!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 8),
                  Text(
                    "Data Pribadi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                "Informasi personal dan kontak",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // Nama Lengkap
              _inputField(
                "Nama Lengkap",
                "Masukkan nama lengkap",
                controller: _namaLengkapController,
              ),

              // NIK
              _inputField(
                "NIK",
                "Masukkan NIK",
                controller: _nikController,
                keyboardType: TextInputType.number,
              ),

              // Tempat Lahir
              _inputField(
                "Tempat Lahir",
                "Masukkan tempat lahir",
                controller: _tempatLahirController,
              ),

              // Tanggal Lahir Picker
              InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Tanggal Lahir",
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4F6C7A)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatTanggalLahir(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(Icons.calendar_today, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Jenis Kelamin
              const Text(
                "Jenis Kelamin",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _jenisKelamin = 'Laki-laki';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                _jenisKelamin == 'Laki-laki'
                                    ? const Color(0xFF4F6C7A)
                                    : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color:
                              _jenisKelamin == 'Laki-laki'
                                  ? const Color(0xFF4F6C7A).withOpacity(0.1)
                                  : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.male,
                              color:
                                  _jenisKelamin == 'Laki-laki'
                                      ? const Color(0xFF4F6C7A)
                                      : Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Laki-laki',
                              style: TextStyle(
                                color:
                                    _jenisKelamin == 'Laki-laki'
                                        ? const Color(0xFF4F6C7A)
                                        : Colors.grey,
                                fontWeight:
                                    _jenisKelamin == 'Laki-laki'
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _jenisKelamin = 'Perempuan';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                _jenisKelamin == 'Perempuan'
                                    ? const Color(0xFF4F6C7A)
                                    : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color:
                              _jenisKelamin == 'Perempuan'
                                  ? const Color(0xFF4F6C7A).withOpacity(0.1)
                                  : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.female,
                              color:
                                  _jenisKelamin == 'Perempuan'
                                      ? const Color(0xFF4F6C7A)
                                      : Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Perempuan',
                              style: TextStyle(
                                color:
                                    _jenisKelamin == 'Perempuan'
                                        ? const Color(0xFF4F6C7A)
                                        : Colors.grey,
                                fontWeight:
                                    _jenisKelamin == 'Perempuan'
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Alamat
              _inputField(
                "Alamat",
                "Masukkan alamat lengkap",
                controller: _alamatController,
                maxLines: 3,
              ),

              // No. HP
              _inputField(
                "No. HP",
                "Masukkan nomor HP",
                controller: _noHpController,
                keyboardType: TextInputType.phone,
              ),

              // Email
              _inputField(
                "Email",
                "Masukkan email",
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(
    String label,
    String hint, {
    int maxLines = 1,
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF4F6C7A)),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
