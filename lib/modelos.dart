import 'package:flutter/material.dart';
import 'dart:math';

class ModeloNodo {
  double _x, _y, _radio;
  String _nombre;
  Color _color;
  ModeloNodo(this._x, this._y, this._nombre, this._radio, this._color);
  double get radio => _radio;
  double get x => _x;
  double get y => _y;
  String get nombre => _nombre;
  Color get color => _color;

  void set color(Color color) {
    _color = color;
  }

  set radio(double radio) => _radio = radio;
  set x(double x) => _x = x;
  set y(double y) => _y = y;
  set nombre(String nombre) => _nombre = nombre;
}

class ModeloLinea {
  double _x1, _y1, _x2, _y2;
  String _distancia;
  double _peso = 0;
  ModeloLinea(this._x1, this._y1, this._x2, this._y2, this._distancia);
  double get peso => _peso;
  double get x1 => _x1;
  double get y1 => _y1;
  double get x2 => _x2;
  double get y2 => _y2;
  String get distancia => _distancia;

  set color(MaterialColor color) {}
  set peso(double peso) => _peso = peso;
  set x1(double x1) => _x1 = x1;
  set y1(double y1) => _y1 = y1;
  set x2(double x2) => _x2 = x2;
  set y2(double y2) => _y2 = y2;
  set distancia(String distancia) => _distancia = distancia;
}
