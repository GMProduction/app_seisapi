import 'package:card_swiper/card_swiper.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../genosLib/component/JustHelper.dart';
import '../genosLib/component/card/genCard.dart';
import '../genosLib/component/etc/genDimen.dart';
import '../genosLib/component/etc/genRow.dart';
import '../genosLib/component/etc/genShadow.dart';
import '../genosLib/component/page/genPage.dart';
import '../genosLib/component/request.dart';
import '../genosLib/genColor.dart';
import '../genosLib/genText.dart';
import 'menuNavbar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  final req = new GenRequest();
  List? dataTransaksi;

  List dataHistory = [
    {"nomor" : "#0001",
      "tanggal" : "2022-07-22",
      "total" : 70000,
      "isi" : [
        {"image": "https://sweetrip.id/wp-content/uploads/2021/11/resep-nasi-goreng-setan.jpg",
          "nama_makanan" : "Nasi Goreng",
          "qty" : "4",
          "total_harga" : 40000,
        }
      ]
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    getDataTransaksi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GenPage(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              RowSpaceBetween(
                chilidLeft: GenText(
                  "History Transaksi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                children: dataTransaksi == null ? [Center(child: CircularProgressIndicator(),)] :  dataTransaksi!.map<Widget>((e){

                  return GenCardOrder(
                    isi: e["keranjang"]["cart"],
                    nama: e["nama"],
                    nomor: e["no_transaksi"],
                    tanggal: e["created_at"],
                    total: e["total"],
                    ontap: (){}                    ,

                  );
                }).toList()

              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getDataTransaksi() async {
    var data = await req.getApi("transaction");
    print("DATA tra $dataTransaksi");
    dataTransaksi = [];

    if (data.length > 0) {
      for (var i = 0; i < data.length; i++) {
        Map mapdata = data[i];
        var dataKeranjang =
        await req.getApi("transaction/" + mapdata["id"].toString());
        mapdata["keranjang"] = dataKeranjang;

        dataTransaksi!.add(mapdata);
      }
    }
    var logger = Logger();
    logger.i("DATA LOG " + dataTransaksi![0]["keranjang"].toString());
    setState(() {});
  }
}
