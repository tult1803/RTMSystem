// import 'package:flutter/material.dart';
// import 'package:rtm_system/model/getAPI_product.dart';
// import 'package:rtm_system/model/model_product.dart';
// import 'package:rtm_system/view/customer/advance/detail_advance.dart';
// import 'package:rtm_system/view/detailAdvanceRequest.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class showAdvance extends StatefulWidget {
//   const showAdvance({Key key}) : super(key: key);
//
//   @override
//   _showAdvanceState createState() => _showAdvanceState();
// }
//
// class _showAdvanceState extends State<showAdvance> {
//   String token;
//   List<DataProduct> dataListProduct = [];
//
//   Future _getToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       token = prefs.getString("access_token");
//     });
//   }
//
//   Future _getProduct() async {
//     List<dynamic> dataList = [];
//     GetProduct getProduct = GetProduct();
//     //Nếu dùng hàm này thì FutureBuilder sẽ chạy vòng lập vô hạn
//     //Phải gọi _getToken trước khi gọi hàm _getProduct
//     // await _getToken();
//     // gọi APIProduct và lấy dữ liệu
//
//     //Khi click nhiều lần vào button "Sản phẩm" thì sẽ có hiện tượng dữ liệu bị ghi đè
//     //Clear là để xoá dữ liệu cũ, ghi lại dữ liệu mới
//     dataListProduct.clear();
//
//     //Nếu ko có If khi FutureBuilder gọi hàm _getProduct lần đầu thì Token chưa trả về nên sẽ bằng null
//     //FutureBuilder sẽ gọi đến khi nào có giá trị trả về
//     //Ở lần gọi thứ 2 thì token mới có giá trị
//     if (token.isNotEmpty) {
//       dataList = await getProduct.getProduct(token, "");
//       //Parse dữ liệu
//       dataList.forEach((element) {
//         Map<dynamic, dynamic> data = element;
//         dataListProduct.add(DataProduct.fromJson(data));
//       });
//
//       return dataListProduct;
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _getToken();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height * 0.45,
//       width: size.width,
//       child: new FutureBuilder(
//         future: _getProduct(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: 3,
//               // snapshot.data.length,
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     _cardInvoice(
//                         'Mủ nước', '20/04/2021', '10,000,000', 'chưa trả'),
//                   ],
//                 );
//               },
//             );
//           }
//           return Container(
//               height: size.height * 0.7,
//               child: Center(child: CircularProgressIndicator()));
//         },
//       ),
//     );
//   }
//
//   Widget _cardInvoice(
//       String product, String date, String price, String status) {
//     return FlatButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => DetailAdvancePage(
//                     )),
//           );
//         },
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           elevation: 10,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 title: Text(
//                   '${product}',
//                   style: TextStyle(
//                     fontSize: 16,
//                   ),
//                 ),
//                 subtitle: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           '${price} VND',
//                           style: TextStyle(
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           '${date}',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Color(0xFF0BB791),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 trailing: Text('${status}'),
//               ),
//             ],
//           ),
//         ));
//   }
// }
