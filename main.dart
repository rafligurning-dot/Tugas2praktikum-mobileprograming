import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ganjil Genap & FizzBuzz',
      home: CekBilangan(),
    );
  }
}

class CekBilangan extends StatefulWidget {
  @override
  _CekBilanganState createState() => _CekBilanganState();
}

class _CekBilanganState extends State<CekBilangan> {
  final TextEditingController _controller = TextEditingController();
  String _hasil = '';
  Color _warnaHasil = Colors.black;

  String _mode = 'Ganjil Genap';

  List<String> deret = []; // list hasil fizzbuzz

  String cekGanjilGenap(int angka) {
    if (angka % 2 == 0) {
      return 'Genap';
    } else {
      return 'Ganjil';
    }
  }

  String fizzBuzz(int n) {
    if (n % 3 == 0 && n % 5 == 0) {
      return 'FizzBuzz';
    } else if (n % 3 == 0) {
      return 'Fizz';
    } else if (n % 5 == 0) {
      return 'Buzz';
    } else {
      return n.toString();
    }
  }

  void _proses() {
    setState(() {
      if (_controller.text.isEmpty) {
        _hasil = 'Input tidak boleh kosong';
        _warnaHasil = Colors.red;
        return;
      }

      int? angka = int.tryParse(_controller.text);

      if (angka == null) {
        _hasil = 'Masukkan angka yang valid!';
        _warnaHasil = Colors.red;
      } else {
        if (_mode == 'Ganjil Genap') {
          _hasil = cekGanjilGenap(angka);
        } else {
          _hasil = fizzBuzz(angka);
        }
        _warnaHasil = Colors.green;
      }
    });
  }

  // FUNGSI MEMBUAT DERET FIZZBUZZ 1–20
  void _generateDeret() {
    setState(() {
      deret = [];
      for (int i = 1; i <= 20; i++) {
        deret.add(fizzBuzz(i));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ganjil Genap & FizzBuzz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _mode,
              items: ['Ganjil Genap', 'FizzBuzz']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _mode = value!;
                });
              },
            ),

            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan bilangan',
              ),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: _proses,
              child: Text('Cek'),
            ),

            ElevatedButton(
              onPressed: _generateDeret,
              child: Text('Tampilkan Deret FizzBuzz 1-20'),
            ),

            SizedBox(height: 10),

            Text(
              'Hasil: $_hasil',
              style: TextStyle(
                fontSize: 20,
                color: _warnaHasil,
              ),
            ),

            SizedBox(height: 10),

            // LISTVIEW
            Expanded(
              child: ListView.separated(
                itemCount: deret.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Index ${index + 1}: ${deret[index]}'),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
