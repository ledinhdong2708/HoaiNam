import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';

import '../../_services/MaterHocPhi/MaterHocPhiService.dart';
import '../../shared/utils/snackbar_helper.dart';
import 'dart:math' as math;

class DialogAddMaterHocPhiScreen extends StatefulWidget {
  final List? itemScreen1;
  const DialogAddMaterHocPhiScreen({Key? key, this.itemScreen1})
      : super(key: key);

  @override
  State<DialogAddMaterHocPhiScreen> createState() =>
      _DialogAddMaterHocPhiScreenState();
}

class _DialogAddMaterHocPhiScreenState
    extends State<DialogAddMaterHocPhiScreen> {
  bool isLoading = false;
  bool isChecked = false;
  List items = [];
  void initState() {
    super.initState();
    FetchMaterHocPhi();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Thêm tiện ích",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            onTap: SaveList,
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.save,
                color: Color(0xFF674AEF),
              ),
            ),
          )
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Visibility(
          visible: isLoading,
          child: Center(
            child: CircularProgressIndicator(),
          ),
          replacement: RefreshIndicator(
            onRefresh: FetchMaterHocPhi,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.all(16),
                        itemCount: items.length,
                        shrinkWrap: false,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = items[index] as Map;
                          return Card(
                            margin: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                    .toInt())
                                .withOpacity(1.0),
                            elevation: 30,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CheckboxListTile(
                                    checkColor: Colors.white,
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            getColor),
                                    value: item["status"],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        // print(value);
                                        // isChecked = value!;
                                        ChangeStatusCheckBoxAndAddList(
                                            value, item);
                                      });
                                    },
                                    title: Text(
                                      '${item["content"].toString()}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    subtitle: Text(
                                      '${(item["donViTinh"]).toString()}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> FetchMaterHocPhi() async {
    final response = await MaterHocPhiService.FetchMaterHocPhiStatusFalse();
    if (response != null) {
      setState(() {
        items = response;
        setState(() {
          var listScreen1 = widget.itemScreen1 as List;
          for (int i = 0; i < items.length; i++) {
            items[i]["total"] = 0;
            items[i]["quantity"] = 1;
            var existingItem = listScreen1.firstWhere(
                (element) => element["id"] == items![i]["id"],
                orElse: () => null);
            if (existingItem != null) {
              items[i]["status"] = true;
            } else {
              items[i]["status"] = false;
            }
          }
        });
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }

  ChangeStatusCheckBoxAndAddList(valueCheckBox, item) {
    if (valueCheckBox) {
      items[items.indexWhere((element) => element["id"] == item["id"])]
          ["status"] = true;
    } else {
      items[items.indexWhere((element) => element["id"] == item["id"])]
          ["status"] = false;
    }
  }

  SaveList() {
    var listScreen1 = widget.itemScreen1 as List;
    for (int i = 0; i < items.length; i++) {
      var existingItem = listScreen1.firstWhere(
          (element) => element["id"] == items[i]["id"],
          orElse: () => null);
      if (existingItem == null) {
        if (items[i]["status"] == true) {
          listScreen1.add(items[i]);
        }
      } else {
        if (existingItem["status"] != items[i]["status"]) {
          listScreen1.removeWhere((element) => element["id"] == items[i]["id"]);
        }
      }
    }
    Navigator.pop(context, listScreen1);
  }
}
