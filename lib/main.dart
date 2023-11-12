import 'package:flutter/material.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaCalculadora(),
    );
  }
}

class TelaCalculadora extends StatefulWidget {
  const TelaCalculadora({super.key});

  @override
  State<TelaCalculadora> createState() {
    return _StateTelaCalculadora();
  }
}

class _StateTelaCalculadora extends State<TelaCalculadora> {
  int valorx = 0;
  int valory = 0;
  int resultado = 0;

  void _calcula() {
    setState(() {
      resultado = valorx + valory;
    });
  }

  Future<void> _navigateTelaPreenche(BuildContext context, String valor) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => TelaPreenche(varName: valor)),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        if (valor == "X") {
          valorx = result;
        } else {
          valory = result;
        }
      });
    }

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$result'),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(valorx.toString()),
            TextButton(
              /*
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaPreenche(varName: "X"),
                  ),
                );
              },*/
              onPressed: () => _navigateTelaPreenche(context, "X"),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade400,
                  minimumSize: const Size(150, 50)),
              child: const Text(
                "Informar X",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(valory.toString()),
            TextButton(
              onPressed: () => _navigateTelaPreenche(context, "Y"),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade400,
                  minimumSize: const Size(150, 50)),
              child: const Text(
                "Informar Y",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () => _calcula(),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blueGrey.shade400,
            minimumSize: const Size(150, 50),
          ),
          child: const Text(
            "Calcular",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 20),
        Text("Resultado: $resultado")
      ]),
    );
  }
}

class TelaPreenche extends StatelessWidget {
  TelaPreenche({super.key, required this.varName});

  final String varName;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final varName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Preenche Valores"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Set $varName:"),
            SizedBox(
              width: 300,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Digite um valor",
                  hintStyle: TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () =>
              Navigator.pop(context, int.parse(controller.value.text)),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blueGrey.shade400,
            minimumSize: const Size(150, 50),
          ),
          child: const Text(
            "Ok",
            style: TextStyle(color: Colors.white),
          ),
        )
      ]),
    );
  }
}
