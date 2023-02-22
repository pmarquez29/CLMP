import 'package:flutter/material.dart';
import 'modelos.dart';

class Nodos extends CustomPainter {
  List<ModeloNodo> nodos;
  Nodos(this.nodos);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final borde = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    nodos.forEach((nodo) {
      paint.color = nodo.color;
      canvas.drawCircle(Offset(nodo.x, nodo.y), nodo.radio, paint);
      final textPainter = TextPainter(
        text: TextSpan(
          text: nodo.nombre,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(nodo.x - textPainter.width / 2, nodo.y - 20));
      canvas.drawCircle(Offset(nodo.x, nodo.y), nodo.radio, borde);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Lineas extends CustomPainter {
  List<ModeloLinea> lineas;
  Lineas(this.lineas);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Color.fromARGB(255, 105, 89, 89);
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.fill;
    Paint borde = Paint();
    borde.color = Color.fromARGB(255, 0, 0, 0);
    borde.strokeWidth = 2;
    borde.style = PaintingStyle.stroke;
    lineas.forEach((linea) {
      canvas.drawLine(
          Offset(linea.x1, linea.y1), Offset(linea.x2, linea.y2), paint);
      canvas.drawLine(
          Offset(linea.x1, linea.y1), Offset(linea.x2, linea.y2), borde);
      final textPainter = TextPainter(
        text: TextSpan(
          text: linea.peso.toString(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset((linea.x1 + linea.x2) / 2, (linea.y1 + linea.y2) / 2));
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
