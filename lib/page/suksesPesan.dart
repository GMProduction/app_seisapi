import 'package:app_kasir_sei_sapi/genosLib/component/JustHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../genosLib/component/button/genButton.dart';
import '../genosLib/component/card/genCard.dart';
import '../genosLib/component/page/genPage.dart';
import '../genosLib/genText.dart';

class SuksesPesanPage extends StatefulWidget {

  int? nominal;
  int? total;
  String? nama;
  String? nomeja;

  SuksesPesanPage({this.nominal, this.total, this.nama, this.nomeja});

  @override
  State<SuksesPesanPage> createState() => _SuksesPesanPageState();
}

class _SuksesPesanPageState extends State<SuksesPesanPage> {

  int? nominal = 0;
  int? total = 0;
  String? nama = "";
  String? nomeja = "";


  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as SuksesPesanPage;
    nominal = args.nominal;
    total = args.total;
    nama = args.nama;
    nomeja = args.nomeja;

    return GenPage(
      appbar: Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        height: 50,
                        width: 50,

                    ),
                  ),
                  Container(
                      // height: 80,
                      child: InkWell(
                          onTap: () {
                            // Navigator.of(context).pop();
                          },
                          child: GenText(
                            "Pembayaran Berhasil",
                            style: TextStyle(fontSize: 20),
                          ))),
                  // GenText(
                  //   "QR Code",
                  //   style: TextStyle(color: Colors.black87, fontSize: 35),
                  // )
                ]),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    Image.asset("assets/images/sukses.png", height: 300,),
                    GenText("Nama :"+nama!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(height: 5,),
                    GenText("Nomor Meja :"+nomeja!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(height: 10,),
                    GenText("Nominal Bayar :"+formatRupiahUseprefik(nominal),),
                    SizedBox(height: 5,),
                    GenText("Total :"+formatRupiahUseprefik(total)),
                    SizedBox(height: 20,),
                    GenText("Kembalian :"+formatRupiahUseprefik(nominal! - total!), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // GenText("Total Pembayaran"),
                  // GenText(
                  //   "Rp 50.000",
                  //   style: TextStyle(
                  //       color: Colors.orange,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 25),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),

                  GenButton(
                    text: "Kembali ke Menu Utama",
                    ontap: () {
                      Navigator.pushNamed(context, "home");
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
