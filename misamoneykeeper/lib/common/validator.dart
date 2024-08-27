class EmailValidator {
  static String? validate(String? value) {
    // Kiểm tra nếu giá trị rỗng
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email';
    }
    // Kiểm tra định dạng email bằng regular expression
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Vui lòng nhập đúng định dạng email';
    }
    // Trả về null nếu định dạng email hợp lệ
    return null;
  }
}

class PhoneNumberValidator {
  static String? validate(String? value) {
    // Kiểm tra nếu giá trị rỗng
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập số điện thoại';
    }
    // Kiểm tra định dạng số điện thoại bằng regular expression
    final phoneRegExp = RegExp(r'^[0-9]{10}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Vui lòng nhập số điện thoại hợp lệ';
    }
    // Trả về null nếu định dạng số điện thoại hợp lệ
    return null;
  }
}
