import 'dart:core';

// This is message list on report 3

//’name field’ + không được để trống.
String MSG001 = "không được để trống.";
String MSG002 = "Tạo mới thành công.";
String MSG003 = "Cập nhật thông tin thành công.";
String MSG004 = "Tên đăng nhập sai.";
String MSG005 = "Tài khoản đã bị khóa.";
String MSG006 = "Số tiền phải lớn hơn hoặc bằng 100,000 VND";
String MSG007 = "Độ dài của tên khách hàng nhỏ hơn 50 ký tự.";
String MSG008 = "Không có dữ liệu.";
String MSG009 = "Tên khách hàng không tồn tại.";
String MSG010 = "Vui lòng chọn loại hóa đơn.";
String MSG011 = "Hóa đơn đã được xác nhận không thể thay đổi.";
String MSG012 = "Đã xác nhận thành công.";
String MSG013 = "Vui lòng chọn loại sản phẩm.";
String MSG014 = "Số điện thoại là 10 hoặc 11 số.";
String MSG015 = "Vui lòng chọn ngày sinh.";
String MSG016 = "Độ dài mật khẩu lớn hơn 6 ký tự, bao gồm chữ và số.";
String MSG017 = "Đã hủy bỏ thành công.";
String MSG018 = "Từ chối xác nhận thông tin?";
String MSG019 = "Đã trả tiền thành công.";
//’name field’  + sai
String MSG020 = "sai.";
String MSG021 = "Vui lòng nhập đúng mật khẩu mới.";
String MSG022 = "Đã nhận tiền thành công.";
String MSG023 = "Vui lòng chọn sản phẩm.";
String MSG024 = "Tạo thất bại.";
String MSG025 = "Cập nhật thất bại.";
String MSG026 = "Vui lòng chỉ nhập số.";
String MSG027 = "Vui lòng thử lại!";
String MSG028 = "Xác nhận quý khách sẽ trả nợ bằng các hóa đơn này?";
String MSG029 = "Xác nhận quý khách sẽ nhận tiền bằng các hóa đơn này?";


//use to show message
String showMessage(String name, String msg){
  return name.isEmpty || name == null? msg : name + " " + msg;
}