import 'dart:core';

class AppValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return "Is required";
    }
    else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.trim()) &&
        !RegExp(r'^\+?\d{9,15}$').hasMatch(email.trim())) {
      return "Please Enter the correct Email ";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Is required";
    } else if (value.length < 8) {
      return "Password is weak";
    } else if (!RegExp(r'[a-zA-Z0-9]').hasMatch(value)) {
      return "Must contains uppercase and lowercase characters";
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Is required";
    }
    else if (value != password) {
      return "Password doesn't match";
    }
    else {
      return null;
    }

  }
  static String? validateUserName(String? value){
    if (value == null || value.isEmpty) {
      return "Is required";
    } else if (!RegExp(r'^[a-zA-Z]').hasMatch(value)) {
      return "Name must contain letters";
    } else {
      return null;
    }
  }
  static String? validatePhoneNumber(String? value) {
    {
      if (value == null || value.isEmpty) {
        return "Please enter phone number";
      }

      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
        return "Enter valid phone number";
      }
      return null;
    }
  }
}
