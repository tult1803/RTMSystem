RegExp checkFormatDate = RegExp(r'^[0,1]?\d{1}\/(([0-2]?\d{1})|([3][0,1]{1}))\/(([1]{1}[9]{1}[9]{1}\d{1})|([2-9]{1}\d{3}))$');

//Đúng khi nhập dưới 10 số còn nhập nhiều hơn 10 số bị sai ????
RegExp checkFormatPhone = RegExp(r'(^(?:[+0]9)?[0-9]{10,11}$)');
RegExp checkFormatCMND = RegExp(r'(^(?:[+0]9)?[0-9]{9,12}$)');

// Nhập password phải có chữ, số, chữ in hoa, ký tự đặt biệt và độ dài tối thiểu là 8
String  patternPassword = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
// Nhập password có chữ hoặc số và độ dài tối thiểu là 8
String  patternPassword1 = r'^(?=.*?[a-zA-Z0-9]).{8,}$';
// Nhập password có chữ và số và độ dài tối thiểu là 4
String  patternPassword2 = r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{4,}$';

RegExp checkFormatPassword = RegExp(patternPassword2);

//chua validate Address, Fullname