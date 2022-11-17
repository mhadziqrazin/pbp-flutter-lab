import 'package:counter_7/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

List<Widget> listBudget = [];
class Budget extends StatelessWidget {
  String judul;
  int nominal;
  String tanggal;
  String jenis;
  Budget({super.key, required this.judul, required this.nominal, required this.tanggal, required this.jenis});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(5.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: Colors.white,
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.15),
          spreadRadius: 1,
          blurRadius: .5,
          offset: const Offset(.5, 1)
        )]
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(bottom: 5),
            child: Text(
              judul,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nominal.toString(),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                tanggal,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                jenis,
                style: const TextStyle(
                  fontSize: 12,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _judul = "";
  int _nominal = 0;
  TextEditingController dateinput = TextEditingController();
  String? jenisBudget;
  List<String> listJenisBudget = ['Pemasukan', 'Pengeluaran'];

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Budget'),
      ),
      // Menambahkan drawer menu
      drawer: const DrawerTugas(),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // input judul
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Judul",
                    // Menambahkan circular border agar lebih rapi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      _judul = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      _judul = value!;
                    });
                  },
                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Judul tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              // input nominal
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  // reference for formatter: https://www.flutterclutter.dev/flutter/tutorials/how-to-create-a-number-input/2021/86522/
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    labelText: "Nominal",
                    // Menambahkan circular border agar lebih rapi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      _nominal = int.parse(value!);
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      _nominal = int.parse(value!);
                    });
                  },
                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Nominal tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              // input date
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: dateinput,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Select Date"
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101)
                    );
                    if (pickedDate != null) {
                      setState(() {
                        dateinput.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                      });
                    }
                  },
                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tanggal tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              // input jenis
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                  value: jenisBudget,
                  hint: const Text("Pilih Jenis"),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: listJenisBudget.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      jenisBudget = newValue!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih salah satu jenis!';
                    }
                    return null;
                  },
                ),
              ),
              // button simpan
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        listBudget.add(Budget(judul: _judul, nominal: _nominal, tanggal: dateinput.text, jenis: jenisBudget!));
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 15,
                              child: ListView(
                                padding: const EdgeInsets.only(top: 20, bottom: 20),
                                shrinkWrap: true,
                                children: [
                                  const Center(
                                    child: Text(
                                        'Data budget telah ditambahkan!'
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  // TODO: Munculkan informasi yang didapat dari form
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Kembali'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}