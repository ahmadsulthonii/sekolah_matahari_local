import 'package:flutter/material.dart';
import 'package:sekolah_matahari_local/data_siswa_model.dart';
import 'package:sekolah_matahari_local/data_siswa_view.dart';
import 'package:sekolah_matahari_local/database_helper.dart';

class DataSiswaController extends State<DataSiswaView> {
  static late DataSiswaController instance;
  late DataSiswaView view;

  @override
  void initState() {
    super.initState();
    getSiswa();
    instance = this;
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  void onReady() {}

  @override
  void dispose() {
    super.dispose();
  }

  List<DataSiswaModel> dataSiswa = [];

  void getSiswa() async {
    setState(() {
      isLoading = true;
    });
    dataSiswa = await DatabaseHelper().getSiswaMt();
    setState(() {
      dataSiswa.sort((a, b) => a.namaSiswa.compareTo(b.namaSiswa));
      isLoading = false;
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
