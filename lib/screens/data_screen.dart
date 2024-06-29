import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DataScreen extends StatelessWidget {
  DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final numero = arguments['numero'];
    final date = arguments['date'];
    final montantHT = arguments['montantHT'];
    final montantTTC = arguments['montantTTC'];
    final montantTVA = arguments['montantTVA'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Gestion facture',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        elevation: 1,
                        child: Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.phone,
                                  color: Colors.blue,
                                ),
                                const Text(
                                  "Numero",
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                                Text(numero),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        elevation: 1,
                        child: Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: Colors.blue,
                                ),
                                const Text(
                                  "Date",
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                                Text(date),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        elevation: 1,
                        child: Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.monetization_on,
                                  color: Colors.blue,
                                ),
                                const Text(
                                  "MontantHT",
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                                Text(montantHT),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        elevation: 1,
                        child: Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.monetization_on_outlined,
                                  color: Colors.blue,
                                ),
                                const Text(
                                  "montantTVA",
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                                Text(montantTVA.toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  color: Colors.white,
                  elevation: 1,
                  child: Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.blue,
                          ),
                          const Text(
                            "montantTTC",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                          Text(montantTTC.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
