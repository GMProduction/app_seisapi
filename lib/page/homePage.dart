import 'package:app_kasir_sei_sapi/genosLib/component/JustHelper.dart';
import 'package:app_kasir_sei_sapi/genosLib/database/genPreferrence.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../genosLib/component/card/genCard.dart';
import '../genosLib/component/etc/genDimen.dart';
import '../genosLib/component/etc/genRow.dart';
import '../genosLib/component/etc/genShadow.dart';
import '../genosLib/component/genToast.dart';
import '../genosLib/component/page/genPage.dart';
import '../genosLib/component/request.dart';
import '../genosLib/genColor.dart';
import '../genosLib/genText.dart';
import 'detailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  final req = new GenRequest();
  var dataBarang;
  String kategori = "makanan";

  @override
  void initState() {
    // TODO: implement initState
    getDataBarang(kategori);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GenPage(
      body: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Container(
                    height: 50,
                    child: CustomRadioButton(
                      elevation: 0,
                      absoluteZeroSpacing: true,
                      unSelectedColor: Theme.of(context).canvasColor,
                      buttonLables: [
                        'Makanan',
                        'Minuman',
                        'Snack',
                      ],
                      buttonValues: [
                        "Makanan",
                        "Minuman",
                        "Snack",
                      ],
                      defaultSelected: "Makanan",
                      buttonTextStyle: ButtonTextStyle(
                          selectedColor: Colors.white,
                          unSelectedColor: Colors.black,
                          textStyle: TextStyle(fontSize: 16)),
                      radioButtonValue: (value) {
                        kategori = value.toString();
                        getDataBarang(kategori);
                      },
                      selectedColor: Theme.of(context).accentColor,
                      enableShape: true,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    // GenRadioGroupMiniInString(listData: data,
                    //   id: "id",
                    //   title: "title",
                    //   ontap: (){},
                    //
                    // )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RowSpaceBetween(
                    chilidLeft: GenText(
                      kategori + " yang Tersedia",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    childRight: InkWell(
                        onTap: () {
                          //PINDAH KE HALAMAN LIHAT SEMUA ARTIKEL
                        },
                        child: GenText(
                          "",
                          style: TextStyle(color: GenColor.primaryColor),
                        )),
                  ),
                  SizedBox(
                    height: GenDimen.afterTitle,
                  ),
                  Column(
                      children: dataBarang == null
                          ? [
                              Center(
                                child: CircularProgressIndicator(),
                              )
                            ]
                          : dataBarang.map<Widget>((e) {
                              return GenCardMenu(
                                ontap: () {
                                  Navigator.pushNamed(context, "detail",
                                      arguments: DetailPage(
                                        id: e["id"],
                                        foto: ip + e["image"],
                                        nama: e["nama"],
                                        harga: e["harga"],
                                      ));
                                },
                                judul: e["nama"],
                                // isi: e["isi"],
                                harga: formatRupiahUseprefik(e["harga"]),
                                gambar: ip + e["image"],
                              );
                            }).toList()),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.pushNamed(context, "keranjang");
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  void getDataBarang(q) async {
    dataBarang = null;
    setState(() {});
    dataBarang = await req.getApi("barangs?q=" + q);

    print("DATA $dataBarang");
    setState(() {});
  }
}


