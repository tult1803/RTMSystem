import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:rtm_system/presenter/Manager/product/show_product_manager.dart';
import 'package:rtm_system/helpers/dialog.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/check_data.dart';
import 'package:rtm_system/ultils/get_api_data.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/ultils/src/message_list.dart';
import 'package:rtm_system/view/table_price.dart';

// ignore: must_be_immutable, camel_case_types
class updatePriceProduct extends StatefulWidget {
  String chosenValue;
  Widget widgetToNavigate;

  updatePriceProduct({this.chosenValue, this.widgetToNavigate});

  @override
  _updatePriceProductState createState() => _updatePriceProductState();
}

// ignore: camel_case_types
class _updatePriceProductState extends State<updatePriceProduct> {
  TextEditingController _controller = TextEditingController();
  int indexValue;
  String error, productId;
  double price, currentPrice;
  bool isClick = false;
  String _value;
  final FocusNode _nodePrice = FocusNode();
  @override
  void initState() {
    super.initState();
    isNotEmptyChoose();
  }

  @override
  void dispose() {
    super.dispose();
    _nodePrice.dispose();
  }

  void isNotEmptyChoose() {
    try {
      if (this.widget.chosenValue != null) {
        setState(() {
          isClick = true;
          _value = this.widget.chosenValue;
          indexValue = itemNameUpdatePrice.indexOf(this.widget.chosenValue);
          price = double.parse(itemPriceUpdatePrice[indexValue]);
          currentPrice = double.parse(itemPriceUpdatePrice[indexValue]);
          productId = itemIdUpdatePrice[indexValue];
          getDataTextField("${getFormatPrice("$price")}");
        });
      }
    } catch (_) {
      EasyLoading.showError(showMessage("", MSG045),
          duration: Duration(seconds: 2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leadingAppbar(context, widget: this.widget.widgetToNavigate),
        centerTitle: true,
        backgroundColor: welcome_color,
        title: titleAppBar("C???p nh???t gi??")
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: new Container(
          margin: EdgeInsets.only(top: 24),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 200,
                child: Row(
                  children: [Expanded(child: _dropDownList())],
                ),
              ),
              _txt(this.widget.chosenValue),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: btnSubmitValidate(
                    context, 200, 40, welcome_color, "C???p nh???t"),
              ),
              showTablePrice(idProduct: productId),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: missing_return
  Future getDataTextField(String txt) {
    if (txt != null) {
      setState(() {
        _controller.value = _controller.value.copyWith(
          text: txt,
          selection:
              TextSelection(baseOffset: txt.length, extentOffset: txt.length),
          composing: TextRange.empty,
        );
      });
    }
  }

  bool checkDate(value) {
    int index = itemNameUpdatePrice.indexOf(value);
    DateTime productDate =
        DateTime.tryParse(itemDateUpdatePrice.elementAt(index));
    if (productDate.day - DateTime.now().day == 0) {
      return true;
    }
    return false;
  }

  Widget _dropDownList() {
    return Container(
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<String>(
        focusColor: Colors.white,
        value: _value,
        style: TextStyle(color: Colors.white),
        iconEnabledColor: Colors.black,
        isExpanded: true,
        underline: Container(
          color: backgroundColor,
        ),
        items:
            itemNameUpdatePrice.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("$value", style: TextStyle(color: Colors.black)),
                checkDate(value)
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : SizedBox(),
              ],
            ),
          );
        }).toList(),
        hint: Text("Ch???n s???n ph???m"),
        onChanged: (String value) {
          setState(() {
            isClick = true;
            _value = value;
            indexValue = itemNameUpdatePrice.indexOf(value);
            price = double.parse(itemPriceUpdatePrice[indexValue]);
            currentPrice = double.parse(itemPriceUpdatePrice[indexValue]);
            productId = itemIdUpdatePrice[indexValue];
            getDataTextField("${getFormatPrice("$price")}");
          });
        },
      ),
    );
  }

  KeyboardActionsConfig keyBoardConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      // keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodePrice,
          displayDoneButton: true,
          onTapAction: () {},
        ),
      ],
    );
  }

  Widget _txt(String value) {
    return Container(
      height: 45,
      width: 200,
      margin: EdgeInsets.only(top: 20),
      child: KeyboardActions(
        disableScroll: true,
        config: keyBoardConfig(context),
        child: TextField(
          focusNode: _nodePrice,
          maxLength: 9,
          textAlign: TextAlign.right,
          controller: _controller,
          keyboardType: TextInputType.number,
          cursorColor: welcome_color,
          style: TextStyle(fontSize: 15),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            counterText: "",
            hintText: "000.000",
            //Sau khi click v??o "Nh???p ti??u ?????" th?? m??u vi???n s??? ?????i
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: welcome_color),
            ),

            //Hi???n th??? text g??c ph???i
            prefixIcon: Container(
                // margin: EdgeInsets.only(top: 15, left: 10),
                width: 200 * 0.2,
                child: Center(
                  child: AutoSizeText(
                    "Gi??",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                )),

            //Hi???n th??? Icon g??c ph???i
            suffixIcon: Container(
              width: 200 * 0.1,
              child: Center(
                child: AutoSizeText(
                  "VN??",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ),
            ),

            //Hi???n th??? l???i
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
            ),
            //Nh???n th??ng b??o l???i
            errorText: error,

            // contentPadding: EdgeInsets.all(15),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          ),
          onChanged: (value) {
            setState(() {
              if (value.isEmpty) {
                price = null;
              } else {
                price = double.parse(value);
                getDataTextField("${getFormatPrice("$price")}");
              }
            });
          },
        ),
      ),
    );
  }

  Widget btnSubmitValidate(BuildContext context, double width, double height,
      Color color, String tittleButtonAlertDialog) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextButton(
          onPressed: () async {
            bool checkInput = await checkUpdatePriceProduct(context,
                isClick: isClick, price: price);
            if (checkInput) {
              currentPrice == price
                  ? showEasyLoadingError(context, MSG055)
                  // ignore: unnecessary_statements
                  : {
                      putAPIUpdatePrice(
                          context, productId, price, this.widget.chosenValue),
                    };
            }
          },
          child: Center(
            child: Text(
              tittleButtonAlertDialog,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ));
  }
}
