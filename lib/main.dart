import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stream Spin Box',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StreamController<double> _streamController = StreamController<double>();
  double _score = 0.0;

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Stream Spin Box'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              StreamBuilder<double>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  final value = snapshot.data ?? 0.0;
                  return Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(color: Colors.red[200]),
                    child: value == 10.0
                        ? Image.asset(
                            'assets/your_image.png', // Ganti dengan path gambar Anda
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.fitHeight,
                          )
                        : Center(
                            child: Text(
                              '$_score',
                              style: TextStyle(fontSize: 24.0),
                            ),
                          ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SpinBox(
                  max: 10.0,
                  min: 0.0,
                  value: _score,
                  decimals: 1,
                  step: 0.1,
                  decoration: InputDecoration(labelText: 'Decimal'),
                  onChanged: (value) {
                    _streamController.sink.add(value);
                    setState(() {
                      _score = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
