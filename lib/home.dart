import 'package:flutter/material.dart';
import 'dart:math';
import 'figuras.dart';
import 'modelos.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int modo = -1;
  List<ModeloNodo> nodos = [];
  List<ModeloLinea> lineas = [];
  ModeloNodo? nodoSeleccionado1;
  ModeloNodo? nodoSeleccionado2;
  int contadorClicks = 0;

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: Nodos(nodos),
            child: Container(),
          ),
          CustomPaint(
            painter: Lineas(lineas),
            child: Container(),
          ),
          GestureDetector(
            onPanDown: (ubi) {
              setState(() {
                if (modo == 1) {
                  // generar un color random
                  nodos.add(ModeloNodo(
                      ubi.globalPosition.dx,
                      ubi.globalPosition.dy,
                      "${nodos.length + 1}",
                      40,
                      Color.fromARGB(255, 7, 74, 137)));
                  //Si hay más de un nodo, se crea una linea entre este y los demás
                }
                if (modo == 2) {
                  nodos.forEach((nodo) {
                    if (sqrt(pow(nodo.x - ubi.globalPosition.dx, 2) +
                            pow(nodo.y - ubi.globalPosition.dy, 2)) <
                        nodo.radio) {
                      if (nodo.nombre != "${nodos.length}") {
                        lineas.add(ModeloLinea(
                          nodos[nodos.length - 1].x,
                          nodos[nodos.length - 1].y,
                          nodo.x,
                          nodo.y,
                          //Se le asigna la distancia entre los nodos con 2 decimales
                          "${(sqrt(pow(nodos[nodos.length - 1].x - nodo.x, 2) + pow(nodos[nodos.length - 1].y - nodo.y, 2))).toStringAsFixed(2)}",
                        ));
                      }
                    }
                  });
                }
                if (modo == 5) {
                  try {
                    nodos.forEach((nodo) {
                      if (sqrt(pow(nodo.x - ubi.globalPosition.dx, 2) +
                              pow(nodo.y - ubi.globalPosition.dy, 2)) <
                          nodo.radio) {
                        nodos.remove(nodo);

                        lineas.removeWhere((linea) =>
                            linea.x1 == nodo.x && linea.y1 == nodo.y ||
                            linea.x2 == nodo.x && linea.y2 == nodo.y);
                        //Se actualizan los nombres de los nodos
                        for (int i = 0; i < nodos.length; i++) {
                          nodos[i].nombre = "${i + 1}";
                        }
                      }
                    });
                  } catch (e) {}
                }
                if (modo == 4) {
                  //Se le pone un peso a la linea que se toque
                  try {
                    lineas.forEach((linea) {
                      if (sqrt(pow(linea.x1 - ubi.globalPosition.dx, 2) +
                                  pow(linea.y1 - ubi.globalPosition.dy, 2)) <
                              20 ||
                          sqrt(pow(linea.x2 - ubi.globalPosition.dx, 2) +
                                  pow(linea.y2 - ubi.globalPosition.dy, 2)) <
                              20) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title:
                                    Text("Valor de la Arista: ${linea.peso}"),
                                content: TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (valor) {
                                    linea.peso = double.parse(valor);
                                  },
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Aceptar"))
                                ],
                              );
                            });
                      }
                    });
                  } catch (e) {}
                }
                if (modo == 9) {
                  //Se selecciona el nodo inicial y final y se le asigna un color verde
                  try {
                    nodos.forEach((nodo) {
                      if (sqrt(pow(nodo.x - ubi.globalPosition.dx, 2) +
                              pow(nodo.y - ubi.globalPosition.dy, 2)) <
                          nodo.radio) {
                        contadorClicks++;
                        if (contadorClicks == 1) {
                          nodoSeleccionado1 = nodo;
                          nodo.color = Colors.green;
                        } else if (contadorClicks == 2) {
                          nodoSeleccionado2 = nodo;
                          nodo.color = Colors.green;
                          print(
                              "Nodo 1: ${nodoSeleccionado1!.nombre} Nodo 2: ${nodoSeleccionado2!.nombre}");
                          //se suman los pesos de las lineas que conectan los nodos
                          double peso = 0;
                          lineas.forEach((linea) {
                            if (linea.x1 == nodoSeleccionado1!.x &&
                                    linea.y1 == nodoSeleccionado1!.y &&
                                    linea.x2 == nodoSeleccionado2!.x &&
                                    linea.y2 == nodoSeleccionado2!.y ||
                                linea.x1 == nodoSeleccionado2!.x &&
                                    linea.y1 == nodoSeleccionado2!.y &&
                                    linea.x2 == nodoSeleccionado1!.x &&
                                    linea.y2 == nodoSeleccionado1!.y) {
                              peso += linea.peso;
                              //mostar el peso en un alert dialog
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Peso total entre los nodos ${nodoSeleccionado1!.nombre} y ${nodoSeleccionado2!.nombre}"),
                                      content: Text("$peso"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Aceptar"))
                                      ],
                                    );
                                  });
                            }
                          });

                          contadorClicks = 0;
                        }
                      }
                    });
                  } catch (e) {}
                }
              });
            },
          ),
          GestureDetector(
            onPanUpdate: (ubi) {
              setState(() {
                if (modo == 3) {
                  //moviendo nodo
                  nodos.forEach((nodo) {
                    if (sqrt(pow(nodo.x - ubi.globalPosition.dx, 2) +
                            pow(nodo.y - ubi.globalPosition.dy, 2)) <
                        nodo.radio) {
                      // mover las lineas y el nodo
                      for (var i = 0; i < lineas.length; i++) {
                        if (lineas[i].x1 == nodo.x && lineas[i].y1 == nodo.y) {
                          lineas[i].x1 = ubi.globalPosition.dx;
                          lineas[i].y1 = ubi.globalPosition.dy;
                          //se actualiza la distancia
                          lineas[i].distancia =
                              "${(sqrt(pow(lineas[i].x1 - lineas[i].x2, 2) + pow(lineas[i].y1 - lineas[i].y2, 2))).toStringAsFixed(2)}";
                        }
                        if (lineas[i].x2 == nodo.x && lineas[i].y2 == nodo.y) {
                          lineas[i].x2 = ubi.globalPosition.dx;
                          lineas[i].y2 = ubi.globalPosition.dy;
                          //se actualiza la distancia
                          lineas[i].distancia =
                              "${(sqrt(pow(lineas[i].x1 - lineas[i].x2, 2) + pow(lineas[i].y1 - lineas[i].y2, 2))).toStringAsFixed(2)}";
                        }
                      }
                      nodo.x = ubi.globalPosition.dx;
                      nodo.y = ubi.globalPosition.dy;
                    }
                  });
                  //moviendo linea
                }
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Color.fromARGB(255, 32, 142, 185),
        backgroundColor: Color.fromARGB(255, 26, 31, 34),
        buttonBackgroundColor: Color.fromARGB(255, 12, 132, 201),
        height: 50,
        items: <Widget>[
          Icon(Icons.add, size: 30, color: Color.fromARGB(255, 255, 255, 255)),
          Icon(Icons.arrow_right_alt_outlined,
              size: 30, color: Color.fromARGB(255, 255, 255, 255)),
          Icon(Icons.front_hand_rounded,
              size: 30, color: Color.fromARGB(255, 255, 255, 255)),
          Icon(Icons.edit, size: 30, color: Color.fromARGB(255, 255, 255, 255)),
          Icon(Icons.delete,
              size: 30, color: Color.fromARGB(255, 255, 255, 255)),
        ],
        onTap: (index) {
          setState(() {
            modo = index + 1;
          });
        },
      ),
    ));
  }
}
