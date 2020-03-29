import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";

  String nhietDo = "";
  String doAm = "";
  String ttCuaNha = "";
  String ttQuanAo = "";
  String khiGas = "";
  String ttDenKhach = "";
  String ttQuatKhach = "";
  String ttDenNgu = "";
  String ttQuatNgu = "";
  String ttDenBep = "";
  String ttQuatBep = "";
  String ttDenTam = "";

  // bool denTong = false;
  // bool quatTong = false;
  bool cuaNha = false;
  bool quanAo = false;
  bool denKhach = false;
  bool denNgu = false;
  bool denBep = false;
  bool denTam = false;
  bool quatKhach = false;
  bool quatNgu = false;
  bool quatBep = false;
  // bool quatTam = false;

  var setAppBar = Text("Home");
  Icon setIcon = Icon(Icons.keyboard_voice);

  // String batDenTong = 'assets/lightallon.png';
  // String tatDenTong = 'assets/lightalloff.png';
  // String batQuatTong = 'assets/fanallon.png';
  // String tatQuatTong = 'assets/fanalloff.png';
  String moCua = 'assets/opendoor.png';
  String dongCua = 'assets/closeddoor.png';
  String phoiDo = 'assets/phoi.png';
  String thuDo = 'assets/thu.png';

  String batDenKhach = 'assets/lighton.png';
  String tatDenKhach = 'assets/lightoff.png';
  String batDenNgu = 'assets/lighton.png';
  String tatDenNgu = 'assets/lightoff.png';
  String batDenBep = 'assets/lighton.png';
  String tatDenBep = 'assets/lightoff.png';
  String batDenTam = 'assets/lighton.png';
  String tatDenTam = 'assets/lightoff.png';

  String batQuatKhach = 'assets/fanon.png';
  String tatQuatKhach = 'assets/fanoff.png';
  String batQuatNgu = 'assets/fanon.png';
  String tatQuatNgu = 'assets/fanoff.png';
  String batQuatBep = 'assets/fanon.png';
  String tatQuatBep = 'assets/fanoff.png';
  // String batQuatTam = 'assets/fanon.png';
  // String tatQuatTam = 'assets/fanoff.png';

  // String denTongBat = 'Bật tất cả đèn';
  // String denTongTat = 'Tắt tất cả đèn';
  // String quatTongBat = 'Bật tất cả quạt';
  // String quatTongTat = 'Tắt tất cả quạt';
  String cuaMo = 'Mở cửa';
  String cuaDong = 'Đóng cửa';
  String doPhoi = 'Phơi quần áo';
  String doThu = 'Thu quần áo';

  String denKhachBat = 'Bật đèn';
  String denKhachTat = 'Tắt đèn';
  String denNguBat = 'Bật đèn';
  String denNguTat = 'Tắt đèn';
  String denBepBat = 'Bật đèn';
  String denBepTat = 'Tắt đèn';
  String denTamBat = 'Bật đèn';
  String denTamTat = 'Tắt đèn';

  String quatKhachBat = 'Bật quạt';
  String quatKhachTat = 'Tắt quạt';
  String quatNguBat = 'Bật quạt';
  String quatNguTat = 'Tắt quạt';
  String quatBepBat = 'Bật quạt';
  String quatBepTat = 'Tắt quạt';
  // String quatTamBat = 'Bật quạt';
  // String quatTamTat = 'Tắt quạt';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      wTrangThaiChung();
      wPhongKhach();
      wPhongNgu();
      wPhongBep();
      wPhongTam();
      wSanNhaGara();
    });
  }

  void vCuaNha() {
    setState(() {
      cuaNha = !cuaNha;
      updateFirebase();
    });
  }

  void vQuanAo() {
    setState(() {
      quanAo = !quanAo;
      updateFirebase();
    });
  }

  void vDenKhach() {
    setState(() {
      denKhach = !denKhach;
      updateFirebase();
    });
  }

  void vQuatKhach() {
    setState(() {
      quatKhach = !quatKhach;
      updateFirebase();
    });
  }

  void vDenNgu() {
    setState(() {
      denNgu = !denNgu;
      updateFirebase();
    });
  }

  void vQuatNgu() {
    setState(() {
      quatNgu = !quatNgu;
      updateFirebase();
    });
  }

  void vDenBep() {
    setState(() {
      denBep = !denBep;
      updateFirebase();
    });
  }

  void vQuatBep() {
    setState(() {
      quatBep = !quatBep;
      updateFirebase();
    });
  }

  void vDenTam() {
    setState(() {
      denTam = !denTam;
      updateFirebase();
    });
  }

  void updateCuaNha() {
    if (ttCuaNha == "1") {
      cuaNha = true;
    } else if (ttCuaNha == "0") {
      cuaNha = false;
    } else {}
  }

  void updateQuanAo() {
    if (ttQuanAo == "1") {
      quanAo = true;
    } else {
      quanAo = false;
    }
  }

  void updateDenKhach() {
    if (ttDenKhach == "1") {
      denKhach = true;
    } else {
      denKhach = false;
    }
  }

  void updateQuatKhach() {
    if (ttQuatKhach == "1") {
      quatKhach = true;
    } else {
      quatKhach = false;
    }
  }

  void updateDenBep() {
    if (ttDenBep == "1") {
      denBep = true;
    } else {
      denBep = false;
    }
  }

  void updateQuatBep() {
    if (ttQuatBep == "1") {
      quatBep = true;
    } else {
      quatBep = false;
    }
  }

  void updateDenNgu() {
    if (ttDenNgu == "1") {
      denNgu = true;
    } else {
      denNgu = false;
    }
  }

  void updateQuatNgu() {
    if (ttQuatNgu == "1") {
      quatNgu = true;
    } else {
      quatNgu = false;
    }
  }

  void updateDenTam() {
    if (ttDenTam == "1") {
      denTam = true;
    } else {
      denTam = false;
    }
  }

  void updateState() {
    // sân nhà - gara
    if (ttCuaNha == "1") {
      cuaNha = true;
    } else if (ttCuaNha == "0") {
      cuaNha = false;
    } else if (ttQuanAo == "1") {
      quanAo = true;
    } else if (ttQuanAo == "0") {
      quanAo = false;
    }
    // phòng khách
    else if (ttDenKhach == "1") {
      denKhach = true;
    } else if (ttDenKhach == "0") {
      denKhach = false;
    } else if (ttQuatKhach == "1") {
      quatKhach = true;
    } else if (ttQuatKhach == "0") {
      quatKhach = false;
    }
    // phòng ngủ
    else if (ttDenNgu == "1") {
      denNgu = true;
    } else if (ttDenNgu == "0") {
      denNgu = false;
    } else if (ttQuatNgu == "1") {
      quatNgu = true;
    } else if (ttQuatNgu == "0") {
      quatNgu = false;
    }
    // phòng bếp
    else if (ttDenBep == "1") {
      denBep = true;
    } else if (ttDenBep == "0") {
      denBep = false;
    } else if (ttQuatBep == "1") {
      quatBep = true;
    } else if (ttQuatBep == "0") {
      quatBep = false;
    }
    // phòng tắm
    else if (ttDenTam == "1") {
      denTam = true;
    } else if (ttDenTam == "0") {
      denTam = false;
    } else {
      print('update statesss');
    }
  }

  void updateFirebase() {
    // sân nhà - gara
    if (cuaNha == true) {
      FirebaseDatabase.instance.reference().update({'CUA_NHA': '1'});
    } else {
      FirebaseDatabase.instance.reference().update({'CUA_NHA': '0'});
    }
    if (quanAo == true) {
      FirebaseDatabase.instance.reference().update({'PHOI_QUAN_AO': '1'});
    } else {
      FirebaseDatabase.instance.reference().update({'PHOI_QUAN_AO': '0'});
    }
    // phòng khách
    if (denKhach == true) {
      FirebaseDatabase.instance.reference().update({'DEN_PHONG_KHACH': '1'});
    } else {
      FirebaseDatabase.instance.reference().update({'DEN_PHONG_KHACH': '0'});
    }
    // if (denKhach == true) {
    //   FirebaseDatabase.instance.reference().update({'DEN_PHONG_NGU_2': '1'});
    // } else {
    //   FirebaseDatabase.instance.reference().update({'DEN_PHONG_NGU_2': '0'});
    // }
    if (quatKhach == true) {
      FirebaseDatabase.instance.reference().update({'DEN_PHONG_NGU_2': '1'});
    } else {
      FirebaseDatabase.instance.reference().update({'DEN_PHONG_NGU_2': '0'});
    }
    // phòng ngủ
    if (denNgu == true) {
      FirebaseDatabase.instance.reference().update({'DEN_PHONG_NGU': '1'});
    } else {
      FirebaseDatabase.instance.reference().update({'DEN_PHONG_NGU': '0'});
    }
    if (quatNgu == true) {
      FirebaseDatabase.instance.reference().update({'QUAT_PHONG_NGU': '1'});
    } else {
      FirebaseDatabase.instance.reference().update({'QUAT_PHONG_NGU': '0'});
    }
    // phòng bếp
    if (denBep == true) {
      FirebaseDatabase.instance.reference().update({'DEN_PHONG_BEP': '1'});
    } else {
      FirebaseDatabase.instance.reference().update({'DEN_PHONG_BEP': '0'});
    }
    if (quatBep == true) {
      FirebaseDatabase.instance.reference().update({'QUAT_PHONG_BEP': '1'});
    } else {
      FirebaseDatabase.instance.reference().update({'QUAT_PHONG_BEP': '0'});
    }
    // phòng tắm
    if (denTam == true) {
      FirebaseDatabase.instance.reference().update({'DEN_PHONG_TAM': '1'});
    } else {
      FirebaseDatabase.instance.reference().update({'DEN_PHONG_TAM': '0'});
    }
    print('updatefirebasesss');
  }

  void readFirebase() {
    FirebaseDatabase.instance
        .reference()
        .once()
        .then((DataSnapshot dataSnapshot) {
      // print(dataSnapshot.value);
      setState(() {
        nhietDo = dataSnapshot.value["NHIET_DO"].toString();
        doAm = dataSnapshot.value["DO_AM"].toString();
        khiGas = dataSnapshot.value["KHI_GAS"].toString();

        ttCuaNha = dataSnapshot.value["CUA_NHA"].toString();
        ttQuanAo = dataSnapshot.value["PHOI_QUAN_AO"].toString();
        ttDenKhach = dataSnapshot.value["DEN_PHONG_KHACH"].toString();
        // ttDenKhach = dataSnapshot.value["DEN_PHONG_NGU_2"].toString();
        // ttQuatKhach = dataSnapshot.value["QUAT_PHONG_KHACH"].toString();
        ttQuatKhach = dataSnapshot.value["DEN_PHONG_NGU_2"].toString();
        ttDenNgu = dataSnapshot.value["DEN_PHONG_NGU"].toString();
        ttQuatNgu = dataSnapshot.value["QUAT_PHONG_NGU"].toString();
        ttDenBep = dataSnapshot.value["DEN_PHONG_BEP"].toString();
        ttQuatBep = dataSnapshot.value["QUAT_PHONG_BEP"].toString();
        ttDenTam = dataSnapshot.value["DEN_PHONG_TAM"].toString();
      });
    });
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  void checkText() {
    switch (resultText) {
      case "Bật đèn khách":
        {
          denKhach = true;
        }
        break;
      case "Tắt đèn khách":
        {
          denKhach = false;
        }
        break;
      case "Bật quạt khách":
        {
          quatKhach = true;
        }
        break;
      case "Tắt quạt khách":
        {
          quatKhach = false;
        }
        break;
      case "Bật đèn ngủ":
        {
          denNgu = true;
        }
        break;
      case "Tắt đèn ngủ":
        {
          denNgu = false;
        }
        break;

        

        case "bật đèn khách":
        {
          denKhach = true;
        }
        break;
      case "tắt đèn khách":
        {
          denKhach = false;
        }
        break;
      case "bật quạt khách":
        {
          quatKhach = true;
        }
        break;
      case "tắt quạt khách":
        {
          quatKhach = false;
        }
        break;
      case "bật đèn ngủ":
        {
          denNgu = true;
        }
        break;
      case "tắt đèn ngủ":
        {
          denNgu = false;
        }
        break;
      // case "Bật quạt ngủ":
      //   {
      //     quatNgu = true;
      //   }
      //   break;
      // case "Tắt quạt ngủ":
      //   {
      //     quatKhach = false;
      //   }
      //   break;
      default:
        {}
    }
  }

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
    checkText();
    Timer.periodic(Duration(microseconds: 1000), (timer) {
      readFirebase();
      // updateState();
      updateCuaNha();
      updateQuanAo();
      updateDenKhach();
      updateDenBep();
      updateDenNgu();
      updateDenTam();
      updateQuatKhach();
      updateQuatBep();
      updateQuatNgu();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(flex: 18, child: giaoDienChung()),
            Flexible(
                flex: 2,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                          flex: 6,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12.0,
                            ),
                            child: Text(
                              resultText,
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                          )),
                      Flexible(
                        flex: 2,
                        child: IconButton(
                          icon: Icon(
                            Icons.mic,
                            color: Colors.blueAccent,
                            size: 40,
                          ),
                          onPressed: () {
                            if (_isAvailable && !_isListening)
                              _speechRecognition
                                  .listen(locale: "en_US")
                                  // .listen(locale: "vi_VN")
                                  .then((result) => print('$result'));
                          },
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              resultText = "";
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget giaoDienChung() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Container(
          color: Colors.blue[50],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10.0),
                wTrangThaiChung(),
                // wSanNhaGara(),
                wPhongKhach(),
                wPhongNgu(),
                wPhongBep(),
                // wPhongTam(),
                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget wTrangThaiChung() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 0, 5),
              child: Text(
                'Trạng thái chung',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Card(
              margin: EdgeInsets.fromLTRB(13, 10, 13, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                width: double.infinity,
                height: 120,
                color: Colors.white12,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Sân nhà - Gara',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('Đèn ',
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    Text(denKhach ? "Bật" : "Tắt",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green)),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Quạt ',
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    Text(quatKhach ? "Bật" : "Tắt",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green)),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Phòng khách',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('Đèn ',
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    Text(denKhach ? "Bật" : "Tắt",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green)),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Quạt ',
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    Text(quatKhach ? "Bật" : "Tắt",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green)),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Phòng ngủ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text('Đèn ',
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                  Text(denNgu ? "Bật" : "Tắt",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Quạt ',
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                  Text(quatNgu ? "Bật" : "Tắt",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Phòng bếp',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('Đèn ',
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    Text(denBep ? "Bật" : "Tắt",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green)),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Quạt ',
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    Text(quatBep ? "Bật" : "Tắt",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green)),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Phòng tắm',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('Đèn ',
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    Text(denTam ? "Bật" : "Tắt",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green)),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('',
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    Text("",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green)),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(13, 10, 13, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                width: double.infinity,
                height: 100,
                color: Colors.white12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Nhiệt độ',
                            style: TextStyle(
                              fontSize: 15,
                            )),
                        Text(nhietDo,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Độ ẩm', style: TextStyle(fontSize: 15)),
                        Text(doAm,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Khí gas', style: TextStyle(fontSize: 15)),
                        Text(khiGas,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget wSanNhaGara() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 0, 5),
              child: Text(
                'Sân nhà - Gara',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                // physics: (),
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        vCuaNha();
                      },
                      splashColor: Colors.red,
                      child: Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Image.asset(cuaNha ? moCua : dongCua,
                                width: 50),
                          ),
                          Text(
                            cuaNha ? cuaMo : cuaDong,
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      )),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        vQuanAo();
                      },
                      splashColor: Colors.red,
                      child: Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                            child:
                                Image.asset(quanAo ? phoiDo : thuDo, width: 50),
                          ),
                          Text(
                            quanAo ? doPhoi : doThu,
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget wPhongKhach() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 0, 5),
              child: Text(
                'Phòng khách',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                // physics: (),
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        vDenKhach();
                      },
                      splashColor: Colors.red,
                      child: Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Image.asset(
                                denKhach ? batDenKhach : tatDenKhach,
                                width: 50),
                          ),
                          Text(
                            denKhach ? denKhachBat : denKhachTat,
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      )),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        vQuatKhach();
                      },
                      splashColor: Colors.red,
                      child: Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                            child: Image.asset(
                                quatKhach ? batQuatKhach : tatQuatKhach,
                                width: 50),
                          ),
                          Text(
                            quatKhach ? quatKhachBat : quatKhachTat,
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(13, 10, 13, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                width: double.infinity,
                height: 100,
                color: Colors.white12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Nhiệt độ',
                            style: TextStyle(
                              fontSize: 15,
                            )),
                        Text(nhietDo,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Độ ẩm', style: TextStyle(fontSize: 15)),
                        Text(doAm,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget wPhongNgu() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 0, 5),
              child: Text(
                'Phòng ngủ',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
              child: 
              // GridView.count(
              //   shrinkWrap: true,
              //   crossAxisCount: 2,
              //   // physics: (),
              //   children: <Widget>[
              //     Card(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15.0),
              //       ),
              //       child: InkWell(
              //         onTap: () {
              //           vDenNgu();
              //         },
              //         splashColor: Colors.red,
              //         child: Center(
              //             child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: <Widget>[
              //             Padding(
              //               padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              //               child: Image.asset(denNgu ? batDenNgu : tatDenNgu,
              //                   width: 50),
              //             ),
              //             Text(
              //               denNgu ? denNguBat : denNguTat,
              //               style: TextStyle(fontSize: 15),
              //             )
              //           ],
              //         )),
              //       ),
              //     ),
              //     Card(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15.0),
              //       ),
              //       child: InkWell(
              //         onTap: () {
              //           vQuatNgu();
              //         },
              //         splashColor: Colors.red,
              //         child: Center(
              //             child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: <Widget>[
              //             Padding(
              //               padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              //               child: Image.asset(
              //                   quatNgu ? batQuatNgu : tatQuatNgu,
              //                   width: 50),
              //             ),
              //             Text(
              //               quatNgu ? quatNguBat : quatNguTat,
              //               style: TextStyle(fontSize: 15),
              //             )
              //           ],
              //         )),
              //       ),
              //     ),
              //   ],
              // ),
              Container(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                height: 150,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      vDenNgu();
                    },
                    splashColor: Colors.red,
                    child: Center(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Image.asset(denNgu ? batDenNgu : tatDenNgu,
                              width: 50),
                        ),
                        Text(
                          denNgu ? denNguBat: denNguTat,
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    )),
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(13, 10, 13, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                width: double.infinity,
                height: 100,
                color: Colors.white12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Nhiệt độ',
                            style: TextStyle(
                              fontSize: 15,
                            )),
                        Text(nhietDo,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Độ ẩm', style: TextStyle(fontSize: 15)),
                        Text(doAm,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget wPhongBep() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 0, 5),
              child: Text(
                'Sân - Gara',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
              child:
                  // GridView.count(
                  //   shrinkWrap: true,
                  //   crossAxisCount: 2,
                  //   // physics: (),
                  //   children: <Widget>[
                  //     Card(
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(15.0),
                  //       ),
                  //       child: InkWell(
                  //         onTap: () {
                  //           vDenBep();
                  //         },
                  //         splashColor: Colors.red,
                  //         child: Center(
                  //             child: Column(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: <Widget>[
                  //             Padding(
                  //               padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  //               child: Image.asset(denBep ? batDenBep : tatDenBep,
                  //                   width: 50),
                  //             ),
                  //             Text(
                  //               denBep ? denBepBat : denBepTat,
                  //               style: TextStyle(fontSize: 15),
                  //             )
                  //           ],
                  //         )),
                  //       ),
                  //     ),
                  //     Card(
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(15.0),
                  //       ),
                  //       child: InkWell(
                  //         onTap: () {
                  //           vQuatBep();
                  //         },
                  //         splashColor: Colors.red,
                  //         child: Center(
                  //             child: Column(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: <Widget>[
                  //             Padding(
                  //               padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  //               child: Image.asset(
                  //                   quatBep ? batQuatBep : tatQuatBep,
                  //                   width: 50),
                  //             ),
                  //             Text(
                  //               quatBep ? quatBepBat : quatBepTat,
                  //               style: TextStyle(fontSize: 15),
                  //             )
                  //           ],
                  //         )),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Container(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                height: 150,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      vDenBep();
                    },
                    splashColor: Colors.red,
                    child: Center(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Image.asset(denBep ? batDenBep : tatDenBep,
                              width: 50),
                        ),
                        Text(
                          denBep ? denBepBat : denBepTat,
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    )),
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(13, 10, 13, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                width: double.infinity,
                height: 100,
                color: Colors.white12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Nhiệt độ',
                            style: TextStyle(
                              fontSize: 15,
                            )),
                        Text(nhietDo,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Độ ẩm', style: TextStyle(fontSize: 15)),
                        Text(doAm,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Khí gas', style: TextStyle(fontSize: 15)),
                        Text(khiGas,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget wPhongTam() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 0, 5),
              child: Text(
                'Phòng tắm',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Container(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
              height: 150,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () {
                    vDenTam();
                  },
                  splashColor: Colors.red,
                  child: Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Image.asset(denTam ? batDenTam : tatDenTam,
                            width: 50),
                      ),
                      Text(
                        denTam ? denTamBat : denTamTat,
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  )),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(13, 10, 13, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                width: double.infinity,
                height: 100,
                color: Colors.white12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Nhiệt độ',
                            style: TextStyle(
                              fontSize: 15,
                            )),
                        Text(nhietDo,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Độ ẩm', style: TextStyle(fontSize: 15)),
                        Text(doAm,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
