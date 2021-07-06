
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:rtm_system/presenter/Manager/product/show_product_manager.dart';
import 'package:rtm_system/helpers/dialog.dart';
import 'package:rtm_system/helpers/component.dart';
import 'package:rtm_system/ultils/get_api_data.dart';
import 'package:rtm_system/ultils/get_data.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';
import 'package:rtm_system/view/table_price.dart';

class updatePriceProduct extends StatefulWidget {
  String chosenValue;
  Widget widgetToNavigate;
  updatePriceProduct({this.chosenValue, this.widgetToNavigate});

  @override
  _updatePriceProductState createState() => _updatePriceProductState();
}

class _updatePriceProductState extends State<updatePriceProduct> {
  TextEditingController _controller = TextEditingController();
  int indexValue;
  String error, productId;
  double price, currentPrice;
  bool isClick = false;
  String _value;
  @override
  void initState() {
    super.initState();
    isNotEmptyChoose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void isNotEmptyChoose(){
    if(this.widget.chosenValue != null){
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leadingAppbar(context, widget: this.widget.widgetToNavigate),
        // leading: leadingAppbar(context),
        centerTitle: true,
        backgroundColor: welcome_color,
        title: Text(
          "Cập nhật giá",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: new Container(
          margin: EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _dropDownList(),
              _txt(this.widget.chosenValue),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: btnSubmitValidate(
                    context, 200, 40, welcome_color, "Cập nhật"),
              ),
             showTablePrice(idProduct: productId,),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget _dropDownList() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<String>(
          focusColor: Colors.white,
          value: _value,
          //elevation: 5,
          style: TextStyle(color: Colors.white),
          iconEnabledColor: Colors.black,
          items:
              itemNameUpdatePrice.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          hint: Text(
            "Chọn sản phẩm",
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
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
      ),
    );
  }

  Widget _txt(String value) {
    return Container(
      height: 50,
      width: 200,
      margin: EdgeInsets.only(top: 20),
      child: TextField(
        textAlign: TextAlign.right,
        controller: _controller,
        keyboardType: TextInputType.number,
        cursorColor: welcome_color,
        style: TextStyle(fontSize: 15),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "000,000",
          //Sau khi click vào "Nhập tiêu đề" thì màu viền sẽ đổi
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: welcome_color),
          ),

          //Hiển thị text góc phải
          prefixIcon: Container(
              // margin: EdgeInsets.only(top: 15, left: 10),
              width: 200 * 0.2,
              child: Center(
                child: AutoSizeText(
                  "Giá",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              )),

          //Hiển thị Icon góc phải
          suffixIcon: Container(
            width: 200 * 0.1,
            child: Center(
              child: AutoSizeText(
                "VNĐ",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
          ),

          //Hiển thị lỗi
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
          //Nhận thông báo lỗi
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
    );
  }

  Widget btnSubmitValidate(BuildContext context, double width, double height,
      Color color, String tittleButtonAlertDialog) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: () {
            if (_checkSubmit()) {
              currentPrice == price
                  ? showCustomDialog(context,
                      content: "Xin hãy nhập giá mới", isSuccess: false)
                  // ignore: unnecessary_statements
                  : { itemIdUpdatePrice.clear(),
                      itemPriceUpdatePrice.clear(),
                      itemNameUpdatePrice.clear(),
                      putAPIUpdatePrice(context, productId, price, this.widget.chosenValue),};
            }
          },
          child: Center(
            child: Text(
              tittleButtonAlertDialog,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ));
  }

  _checkSubmit() {
    if (isClick) {
      if (price != null) {
        if (price > 1000) {
          return true;
        } else {
          showCustomDialog(context,
              content: "Giá phải lớn hơn 1000đ", isSuccess: false);
          return false;
        }
      } else {
        showCustomDialog(context, content: "Giá đang trống", isSuccess: false);
        return false;
      }
    } else {
      showCustomDialog(context, content: "Hãy chọn sản phẩm", isSuccess: false);
      return false;
    }
  }
}
