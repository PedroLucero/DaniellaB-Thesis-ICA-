import 'dart:ffi';

import 'package:daniella_tesis_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DosePage extends StatefulWidget {
  const DosePage({super.key});

  @override
  State<DosePage> createState() => _DosePageState();
}

class _DosePageState extends State<DosePage> {
  var selectedIndex = 0;
  TextEditingController carbsInput = TextEditingController();
  TextEditingController ratioInput = TextEditingController();
  TextEditingController resultingDose = TextEditingController();

  @override
  void initState() {
    carbsInput.text = "100";
    ratioInput.text = "10";
    resultingDose.text = "1.00";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appTitle = "Calcula tu dosis";
    var theme = Theme.of(context);
    var titleStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 30,
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          appTitle,
          style: titleStyle,
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text("Cantidad de gramos de carbohidratos"),
                Text("÷"),
                Text("razón de insulina a carbohidratos"),
                SizedBox(
                  height: 10,
                ),
                PrettyNBbox(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: carbsInput,
                          decoration: InputDecoration(
                            labelText: "Carbohidratos (gramos)",
                            suffixIcon: Icon(Icons.breakfast_dining),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*$')),
                          ],
                        ),
                        Text("÷"),
                        TextField(
                          controller: ratioInput,
                          decoration: InputDecoration(
                            labelText: "Razón insulina a carbohidratos",
                            suffixIcon: Icon(Icons.health_and_safety),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*$')),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // This next check might be unecessary
                            // Just gotta know if the info comes from DB side or user
                            if (double.parse(ratioInput.text) == 0) {
                              return;
                            }
                            var dose = double.parse(carbsInput.text) /
                                double.parse(ratioInput.text);
                            setState(() {
                              resultingDose.text = dose.toStringAsFixed(2);
                            });
                          },
                          child: Text("Calcular"),
                        ),
                      ],
                    ),
                  ),
                ),
                Text("="),
                Text("${resultingDose.text} Unidades de insulina bolus"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
