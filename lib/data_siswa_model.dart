// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DataSiswaModel {
  final String idSiswa;
  final String namaSiswa;
  final String kelas;

  DataSiswaModel(this.idSiswa, this.namaSiswa, this.kelas);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idSiswa': idSiswa,
      'namaSiswa': namaSiswa,
      'kelas': kelas,
    };
  }

  factory DataSiswaModel.fromMap(Map<String, dynamic> map) {
    return DataSiswaModel(
      map['idSiswa'] as String,
      map['namaSiswa'] as String,
      map['kelas'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataSiswaModel.fromJson(String source) =>
      DataSiswaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
