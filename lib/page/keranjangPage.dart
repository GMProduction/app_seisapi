import 'package:app_kasir_sei_sapi/genosLib/component/JustHelper.dart';
import 'package:app_kasir_sei_sapi/genosLib/component/button/genButton.dart';
import 'package:app_kasir_sei_sapi/page/suksesPesan.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import '../genosLib/component/card/genCard.dart';
import '../genosLib/component/etc/genDimen.dart';
import '../genosLib/component/etc/genRow.dart';
import '../genosLib/component/etc/genShadow.dart';
import '../genosLib/component/genToast.dart';
import '../genosLib/component/page/genPage.dart';
import '../genosLib/component/request.dart';
import '../genosLib/component/textfiled/TextField.dart';
import '../genosLib/genColor.dart';
import '../genosLib/genText.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  final req = new GenRequest();
  var dataBarang;
  bool isLoaded = false;
  bool readytoHit = true;
  var keterangan = "", nama= "", nomeja="";
  int totalBayar = 0;

  @override
  void initState() {
    // TODO: implement initState
    getDataKeranjang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    totalBayar = 0;

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
                            "Keranjang Pesanan",
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
                    children: dataBarang == null
                        ? [
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          ]
                        : dataBarang.map<Widget>((e) {
                            totalBayar =
                                totalBayar + int.parse(e["total"].toString());
                            return GenCardMenu(
                              ontap: () {
                                Navigator.pushNamed(context, "detail");
                              },
                              judul: e["barangs"]["nama"],
                              harga: formatRupiahUseprefik(e["total"]),
                              harga1: formatRupiahUseprefik(e["harga"]),
                              gambar: ip + e["barangs"]["image"],
                              badges: e["qty"].toString(),
                            );
                          }).toList()),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GenText("Total Pembayaran"),
                  GenText(
                    formatRupiahUseprefik(totalBayar),
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GenButtonOutline(
                    text: "Pesan Makanan Lagi",
                    ontap: () {
                      Navigator.pushNamed(context, "home");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GenButton(
                    text: "Proses Pesanan",
                    ontap: () {
                      showModalBottomSheet<void>(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0))),
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Container(
                              height: 500,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      GenText(
                                        "Total :"+formatRupiahUseprefik(totalBayar),
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextLoginField(
                                          keyboardType: TextInputType.text,
                                          label: "Masukan Nama ",
                                          onChanged: (val) {
                                            nama = val;
                                          }),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextLoginField(
                                          keyboardType: TextInputType.text,
                                          label: "Masukan Nomor Meja",
                                          onChanged: (val) {
                                            nomeja = val;
                                          }),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextLoginField(
                                          keyboardType: TextInputType.number,
                                          label: "Masukan Uang yang dibayarkan",
                                          onChanged: (val) {
                                            keterangan = val;
                                          }),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      readytoHit
                                          ? GenButton(
                                              text: "Proses Pesanan",
                                              ontap: () {
                                                prosesKeranjang(nama, nomeja, keterangan);
                                              },
                                            )
                                          : Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
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

  void getDataKeranjang() async {
    dataBarang = await req.getApi("cart");

    print("DATA $dataBarang");

    setState(() {});
  }

  void prosesKeranjang(nama, nomeja, nominal) async {
    setState(() {
      readytoHit = false;
    });

    var dataProses = await req.postApi("cart/checkout", {"nama": nama, "no_meja": nomeja});
    if (dataProses == "berhasil") {

      Navigator.pushNamed(context, "suksesPesan",
          arguments: SuksesPesanPage(
            nominal: int.parse(nominal),
            total: totalBayar,
            nama: nama,
            nomeja: nomeja,
          ));

    } else {
      // toastShow("Barang  gagal dimasukan keranjang", context, Colors.black);
      toastShow("Keranjang gagal di proses", context, Colors.black);

      setState(() {
        readytoHit = true;
      });

      print("DATA $dataProses");
    }
  }
}
