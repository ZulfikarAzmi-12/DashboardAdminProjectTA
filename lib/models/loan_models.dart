class LoanModel {
  final String status;
  final String kode;
  final String nama;
  final String tanggal;

  LoanModel({
    required this.status,
    required this.kode,
    required this.nama,
    required this.tanggal,
  });

  /// 🔥 FROM JSON (untuk ambil data dari API)
  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      status: json['status'] ?? '',
      kode: json['kode'] ?? json['loan_code'] ?? '',
      nama: json['nama'] ?? json['item_name'] ?? '',
      tanggal: json['tanggal'] ?? json['created_at'] ?? '',
    );
  }

  /// 🔥 TO JSON (untuk kirim data ke API / debug)
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'kode': kode,
      'nama': nama,
      'tanggal': tanggal,
    };
  }

  /// 🔥 COPY WITH (optional tapi penting untuk update data)
  LoanModel copyWith({
    String? status,
    String? kode,
    String? nama,
    String? tanggal,
  }) {
    return LoanModel(
      status: status ?? this.status,
      kode: kode ?? this.kode,
      nama: nama ?? this.nama,
      tanggal: tanggal ?? this.tanggal,
    );
  }
}