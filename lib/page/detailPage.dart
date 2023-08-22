import 'package:app_kasir_sei_sapi/genosLib/component/JustHelper.dart';
import 'package:app_kasir_sei_sapi/genosLib/component/request.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import '../genosLib/component/button/genButton.dart';
import '../genosLib/component/card/genCard.dart';
import '../genosLib/component/etc/genDimen.dart';
import '../genosLib/component/etc/genRow.dart';
import '../genosLib/component/etc/genShadow.dart';
import '../genosLib/component/genToast.dart';
import '../genosLib/component/page/genPage.dart';
import '../genosLib/component/textfiled/TextField.dart';
import '../genosLib/genColor.dart';
import '../genosLib/genText.dart';

class DetailPage extends StatefulWidget {

  final int? id;
  final String? nama;
  final String? foto;
  final int? harga;

  DetailPage({this.id, this.nama, this.foto, this.harga});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var dataBarang, id, nama, foto, harga;
  bool readytoHit = true;
  int qty = 1;
  var req = new GenRequest();



  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as DetailPage;
    id = args.id;
    nama = args.nama;
    foto = args.foto;
    harga = args.harga;

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
                        child: Center(
                            child: Icon(
                          Icons.chevron_left,
                          size: 30,
                        ))),
                  ),
                  Container(
                      // height: 80,
                      child: InkWell(
                          onTap: () {
                            // Navigator.of(context).pop();
                          },
                          child: GenText(
                            "Detail Makanan",
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                        foto,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover),
                    Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GenText(
                              nama,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 24),
                            ),
                            GenText(
                              formatRupiahUseprefik(harga),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),


                            // TextLoginField(label: "Catatan")
                          ],
                        ))
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 150,
                    child: SpinBox(
                      min: 1,
                      max: 100,
                      value: 1,
                      onChanged: (value) => qty = value.toInt(),
                    ),
                  ),
                  SizedBox(height: 10,),
                  readytoHit ? GenButton(
                    text: "Tambah di keranjang",
                    ontap: () {
                      postDataBarang(id, qty, harga);
                    },
                  ) : Center(child: CircularProgressIndicator(),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void postDataBarang(barangid, qty, harga) async {
    setState(() {
      readytoHit = false;
    });


      dataBarang = await req.postApi("cart", {"barang_id": barangid, "qty": qty, "harga": harga});
      if(dataBarang == "berhasil"){
        toastShow("barang berhasil masuk keranjang ", context, Colors.black);
        Navigator.pushNamed(context, "keranjang");
      }else{
        toastShow("Barang  gagal dimasukan keranjang", context, Colors.black);
        setState(() {
          readytoHit = true;
        });
      }

      print("DATA $dataBarang");
    }
}
