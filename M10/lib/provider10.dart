import 'package:flutter/material.dart';

class Provider10 extends ChangeNotifier {
  String _selectedRingtone = 'Ringtone 1';
  String get selectedRingtone => _selectedRingtone;

  set selectedRingtone(val) {
    _selectedRingtone = val;
    notifyListeners();
  }

  final List ringtones = [
    'None',
    'Callisto',
    'Ganymede',
    'Luna',
    'Oberon',
    'Phobos',
    'Dione',
  ];
}
