import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../models/location_models.dart';
import '../../services/location_service.dart';

class DataPribadiPage extends StatefulWidget {
  final Map<String, dynamic>? savedData;
  final Function(Map<String, dynamic>) onDataChanged;

  const DataPribadiPage({
    super.key,
    this.savedData,
    required this.onDataChanged,
  });

  @override
  State<DataPribadiPage> createState() => _DataPribadiPageState();
}

class _DataPribadiPageState extends State<DataPribadiPage> {
  DateTime? _tanggalLahir;
  String? _jenisKelamin;

  // Location data
  Province? _selectedProvince;
  Regency? _selectedRegency;
  District? _selectedDistrict;
  // ignore: unused_field
  Village? _selectedVillage;

  // TextEditingController untuk setiap field
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _kodePosController = TextEditingController();

  // Location controllers
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _regencyController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();

  void _notifyDataChanged() {
    Map<String, dynamic> data = {};

    // Text fields
    if (_namaLengkapController.text.isNotEmpty)
      data['namaLengkap'] = _namaLengkapController.text;
    if (_nikController.text.isNotEmpty) data['nik'] = _nikController.text;
    if (_tempatLahirController.text.isNotEmpty)
      data['tempatLahir'] = _tempatLahirController.text;
    if (_alamatController.text.isNotEmpty)
      data['alamat'] = _alamatController.text;
    if (_noHpController.text.isNotEmpty) data['noHp'] = _noHpController.text;
    if (_emailController.text.isNotEmpty) data['email'] = _emailController.text;
    if (_kodePosController.text.isNotEmpty)
      data['kodePos'] = _kodePosController.text;

    // Selected values
    if (_tanggalLahir != null)
      data['tanggalLahir'] = _tanggalLahir!.toIso8601String();
    if (_jenisKelamin != null) data['jenisKelamin'] = _jenisKelamin;

    // Location data
    if (_selectedProvince != null)
      data['province'] = _selectedProvince!.toJson();
    if (_selectedRegency != null) data['regency'] = _selectedRegency!.toJson();
    if (_selectedDistrict != null)
      data['district'] = _selectedDistrict!.toJson();
    if (_selectedVillage != null) data['village'] = _selectedVillage!.toJson();

    widget.onDataChanged(data);
  }

  void _setupTextFieldListeners() {
    _namaLengkapController.addListener(_notifyDataChanged);
    _nikController.addListener(_notifyDataChanged);
    _tempatLahirController.addListener(_notifyDataChanged);
    _alamatController.addListener(_notifyDataChanged);
    _noHpController.addListener(_notifyDataChanged);
    _emailController.addListener(_notifyDataChanged);
    _kodePosController.addListener(_notifyDataChanged);
  }

  @override
  void initState() {
    super.initState();
    _initializeLocationData();
    _setupTextFieldListeners();

    // Restore saved data if available
    if (widget.savedData != null) {
      // Restore text fields
      if (widget.savedData?['namaLengkap'] != null) {
        _namaLengkapController.text = widget.savedData!['namaLengkap'];
      }
      if (widget.savedData?['nik'] != null) {
        _nikController.text = widget.savedData!['nik'];
      }
      if (widget.savedData?['tempatLahir'] != null) {
        _tempatLahirController.text = widget.savedData!['tempatLahir'];
      }
      if (widget.savedData?['alamat'] != null) {
        _alamatController.text = widget.savedData!['alamat'];
      }
      if (widget.savedData?['kodePos'] != null) {
        _kodePosController.text = widget.savedData!['kodePos'];
      }
      if (widget.savedData?['noHp'] != null) {
        _noHpController.text = widget.savedData!['noHp'];
      }
      if (widget.savedData?['email'] != null) {
        _emailController.text = widget.savedData!['email'];
      }

      // Restore selected values
      if (widget.savedData?['tanggalLahir'] != null) {
        _tanggalLahir = DateTime.parse(widget.savedData!['tanggalLahir']);
      }
      if (widget.savedData?['jenisKelamin'] != null) {
        _jenisKelamin = widget.savedData!['jenisKelamin'];
      }

      // Restore location data
      if (widget.savedData?['province'] != null) {
        _selectedProvince = Province.fromJson(widget.savedData!['province']);
        _provinceController.text = _selectedProvince?.name ?? '';
      }
      if (widget.savedData?['regency'] != null) {
        _selectedRegency = Regency.fromJson(widget.savedData?['regency']);
        _regencyController.text = _selectedRegency?.name ?? '';
      }
      if (widget.savedData?['district'] != null) {
        _selectedDistrict = District.fromJson(widget.savedData?['district']);
        _districtController.text = _selectedDistrict?.name ?? '';
      }
      if (widget.savedData?['village'] != null) {
        _selectedVillage = Village.fromJson(widget.savedData?['village']);
        _villageController.text = _selectedVillage?.name ?? '';
      }
    }
  }

  Future<void> _initializeLocationData() async {
    await LocationService.initialize();
  }

  @override
  void dispose() {
    // Remove listeners
    _namaLengkapController.removeListener(_notifyDataChanged);
    _nikController.removeListener(_notifyDataChanged);
    _tempatLahirController.removeListener(_notifyDataChanged);
    _alamatController.removeListener(_notifyDataChanged);
    _noHpController.removeListener(_notifyDataChanged);
    _emailController.removeListener(_notifyDataChanged);
    _kodePosController.removeListener(_notifyDataChanged);

    // Dispose controllers
    _namaLengkapController.dispose();
    _nikController.dispose();
    _tempatLahirController.dispose();
    _alamatController.dispose();
    _noHpController.dispose();
    _emailController.dispose();
    _kodePosController.dispose();
    _provinceController.dispose();
    _regencyController.dispose();
    _districtController.dispose();
    _villageController.dispose();
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
      setState(() {
        _tanggalLahir = picked;
        _notifyDataChanged();
      });
    }
  }

  String _formatTanggalLahir() {
    if (_tanggalLahir == null) return "Pilih tanggal lahir";
    return DateFormat('dd MMM yyyy', 'id_ID').format(_tanggalLahir!);
  }

  void _clearRegencyAndBelow() {
    setState(() {
      _selectedRegency = null;
      _selectedDistrict = null;
      _selectedVillage = null;
      _regencyController.clear();
      _districtController.clear();
      _villageController.clear();
      _notifyDataChanged();
    });
  }

  void _clearDistrictAndBelow() {
    setState(() {
      _selectedDistrict = null;
      _selectedVillage = null;
      _districtController.clear();
      _villageController.clear();
      _notifyDataChanged();
    });
  }

  void _clearVillage() {
    setState(() {
      _selectedVillage = null;
      _villageController.clear();
      _notifyDataChanged();
    });
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
                          _notifyDataChanged();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _jenisKelamin == 'Laki-laki'
                                ? const Color(0xFF4F6C7A)
                                : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: _jenisKelamin == 'Laki-laki'
                              ? const Color(0xFF4F6C7A).withOpacity(0.1)
                              : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.male,
                              color: _jenisKelamin == 'Laki-laki'
                                  ? const Color(0xFF4F6C7A)
                                  : Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Laki-laki',
                              style: TextStyle(
                                color: _jenisKelamin == 'Laki-laki'
                                    ? const Color(0xFF4F6C7A)
                                    : Colors.grey,
                                fontWeight: _jenisKelamin == 'Laki-laki'
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
                          _notifyDataChanged();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _jenisKelamin == 'Perempuan'
                                ? const Color(0xFF4F6C7A)
                                : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: _jenisKelamin == 'Perempuan'
                              ? const Color(0xFF4F6C7A).withOpacity(0.1)
                              : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.female,
                              color: _jenisKelamin == 'Perempuan'
                                  ? const Color(0xFF4F6C7A)
                                  : Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Perempuan',
                              style: TextStyle(
                                color: _jenisKelamin == 'Perempuan'
                                    ? const Color(0xFF4F6C7A)
                                    : Colors.grey,
                                fontWeight: _jenisKelamin == 'Perempuan'
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

              // Provinsi
              _locationField(
                "Provinsi",
                "Pilih Provinsi",
                controller: _provinceController,
                suggestionsCallback: (pattern) async {
                  // Ensure initialization is complete
                  await LocationService.initialize();
                  return LocationService.searchProvinces(pattern);
                },
                onSelected: (Province province) {
                  setState(() {
                    _selectedProvince = province;
                    _provinceController.text = province.name;
                  });
                  _clearRegencyAndBelow();
                },
                enabled: true,
              ),

              // Kabupaten/Kota
              _locationField(
                "Kabupaten/Kota",
                "Pilih Kabupaten/Kota",
                controller: _regencyController,
                suggestionsCallback: (pattern) async {
                  await LocationService.initialize();
                  return LocationService.searchRegencies(
                    pattern,
                    _selectedProvince?.id,
                  );
                },
                onSelected: (Regency regency) {
                  setState(() {
                    _selectedRegency = regency;
                    _regencyController.text = regency.name;
                  });
                  _clearDistrictAndBelow();
                },
                enabled: _selectedProvince != null,
              ),

              // Kecamatan
              _locationField(
                "Kecamatan",
                "Pilih Kecamatan",
                controller: _districtController,
                suggestionsCallback: (pattern) async {
                  await LocationService.initialize();
                  return LocationService.searchDistricts(
                    pattern,
                    _selectedRegency?.id,
                  );
                },
                onSelected: (District district) {
                  setState(() {
                    _selectedDistrict = district;
                    _districtController.text = district.name;
                  });
                  _clearVillage();
                },
                enabled: _selectedRegency != null,
              ),

              // Kelurahan/Desa
              _locationField(
                "Kelurahan/Desa",
                "Pilih Kelurahan/Desa",
                controller: _villageController,
                suggestionsCallback: (pattern) async {
                  await LocationService.initialize();
                  return LocationService.searchVillages(
                    pattern,
                    _selectedDistrict?.id,
                  );
                },
                onSelected: (Village village) {
                  setState(() {
                    _selectedVillage = village;
                    _villageController.text = village.name;
                  });
                },
                enabled: _selectedDistrict != null,
              ),

              // Kode Pos
              _inputField(
                "Kode Pos",
                "Masukkan kode pos",
                controller: _kodePosController,
                keyboardType: TextInputType.number,
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
          onChanged: (value) => _notifyDataChanged(),
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

  Widget _locationField<T>(
    String label,
    String hint, {
    required TextEditingController controller,
    required Future<List<T>> Function(String) suggestionsCallback,
    required void Function(T) onSelected,
    required bool enabled,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: enabled ? Colors.black : Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        TypeAheadField<T>(
          suggestionsCallback:
              enabled ? suggestionsCallback : (pattern) async => [],
          builder: (context, textEditingController, focusNode) {
            // Sinkronisasi controller internal & eksternal
            textEditingController.text = controller.text;
            textEditingController.selection = TextSelection.fromPosition(
              TextPosition(offset: textEditingController.text.length),
            );

            textEditingController.addListener(() {
              if (controller.text != textEditingController.text) {
                controller.text = textEditingController.text;
              }
            });

            return TextField(
              controller: textEditingController,
              focusNode: focusNode,
              enabled: enabled,
              decoration: InputDecoration(
                hintText: enabled ? hint : "",
                hintStyle: TextStyle(
                  color: enabled ? Colors.grey : Colors.grey.shade400,
                  fontSize: 14,
                ),
                filled: true,
                fillColor: enabled ? Colors.white : Colors.grey.shade100,
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
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Color(0xFF4F6C7A)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              onChanged: (val) => controller.text = val,
            );
          },
          itemBuilder: (context, T item) {
            return ListTile(
              title: Text(
                item.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            );
          },
          onSelected: (T item) {
            controller.text = item.toString();

            FocusScope.of(context).unfocus();
            // sinkronisasi manual
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length),
              );
            });
            onSelected(item);
          },
          emptyBuilder: (context) => const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Tidak ada data ditemukan',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          loadingBuilder: (context) => const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
          errorBuilder: (context, error) => Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Error: $error',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
