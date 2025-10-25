import 'package:flutter/material.dart';
import 'package:sekolah_matahari_local/data_siswa_controller.dart';
import 'package:sekolah_matahari_local/data_siswa_model.dart';
import 'package:sekolah_matahari_local/database_helper.dart';

class DataSiswaView extends StatefulWidget {
  const DataSiswaView({super.key});

  Widget build(context, DataSiswaController controller) {
    controller.view = this;

    var dataSiswa = controller.dataSiswa;
    final idSiswaController = TextEditingController();
    final namaSiswaController = TextEditingController();
    final kelasController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Sekolah Matahari')),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(dataSiswa[index].namaSiswa),
                subtitle: Text(dataSiswa[index].idSiswa),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Detail siswa'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('id siswa : ${dataSiswa[index].idSiswa}'),
                            Text('nama siswa : ${dataSiswa[index].namaSiswa}'),
                            Text('kelas : ${dataSiswa[index].kelas}'),
                          ],
                        ),

                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Batal'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  idSiswaController.text =
                                      dataSiswa[index].idSiswa;
                                  namaSiswaController.text =
                                      dataSiswa[index].namaSiswa;
                                  kelasController.text = dataSiswa[index].kelas;
                                  return AlertDialog(
                                    title: Text('Data update'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: idSiswaController,
                                          enabled: false,
                                          decoration: InputDecoration(
                                            label: Text('id siswa'),
                                          ),
                                        ),
                                        TextField(
                                          controller: namaSiswaController,

                                          decoration: InputDecoration(
                                            label: Text('nama siswa'),
                                          ),
                                        ),
                                        TextField(
                                          controller: kelasController,
                                          decoration: InputDecoration(
                                            label: Text('kelas'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Batal'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          final dataSiswa = DataSiswaModel(
                                            idSiswaController.text,
                                            namaSiswaController.text,
                                            kelasController.text,
                                          );
                                          DatabaseHelper().updateSiswaMt(
                                            dataSiswa,
                                          );
                                          controller.getSiswa();
                                          Navigator.pop(context);
                                        },
                                        child: Text('Update'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Edit'),
                          ),
                        ],
                      );
                    },
                  );
                },
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        String id = dataSiswa[index].idSiswa;
                        return AlertDialog(
                          title: Text('Delete Siswa'),
                          content: Text(
                            'Yakin delete ${dataSiswa[index].namaSiswa.toUpperCase()} ?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Batal'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                DatabaseHelper().deleteSiswaMt(id);
                                controller.getSiswa();
                                Navigator.pop(context);
                              },
                              child: Text('Hapus'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete_sharp),
                  color: Colors.red,
                ),
              ),
            );
          },
          itemCount: dataSiswa.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Tambah Siswa'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: idSiswaController,
                      decoration: InputDecoration(label: Text('id siswa')),
                    ),
                    TextField(
                      controller: namaSiswaController,
                      decoration: InputDecoration(label: Text('nama siswa')),
                    ),
                    TextField(
                      controller: kelasController,
                      decoration: InputDecoration(label: Text('kelas')),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      final dataSiswa = DataSiswaModel(
                        idSiswaController.text,
                        namaSiswaController.text,
                        kelasController.text,
                      );
                      DatabaseHelper().insertSiswa(dataSiswa);
                      controller.getSiswa();
                      Navigator.pop(context);
                      idSiswaController.clear();
                      namaSiswaController.clear();
                      kelasController.clear();
                    },
                    child: Text('Simpan'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => DataSiswaController();
}
