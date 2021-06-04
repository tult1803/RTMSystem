
getStatus({int status}) {
  String txtStatus = "";
  if (status == 1) {
    txtStatus = "Hoạt động";
  } else if (status == 2) {
    txtStatus = "Không hoạt động";
  } else if (status == 3) {
    txtStatus = "Hoàn thành";
  } else if (status == 4) {
    txtStatus = "Đang xử lý";
  } else if (status == 5) {
    txtStatus = "Từ chối";
  } else if (status == 6) {
    txtStatus = "Chấp nhận";
  }
  return txtStatus;
}
