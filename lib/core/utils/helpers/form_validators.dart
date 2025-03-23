final class FormValidators {
  static String? email(value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }

    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) {
      return "Invalid email address";
    }
    return null;
  }

  static String? password(value) {
    if (value == null || value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  static String? name(value) {
    if (value == null || value.isEmpty) {
      return "Name cannot be empty";
    }

    if (value.length < 3) {
      return "Name must be at least 3 characters";
    }
    return null;
  }

  static String? phone(value) {
    if (value == null || value.isEmpty) {
      return "Phone number cannot be empty";
    }
    if (value.length < 10) {
      return "Phone number must be at least 10 characters";
    }
    return null;
  }

  static String? address(value) {
    if (value == null || value.isEmpty) {
      return "Address cannot be empty";
    }
    if (value.length < 10) {
      return "Address must be at least 10 characters";
    }
    return null;
  }
}
