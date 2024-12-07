

class Validator {
  static const String emailPattern =
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";

  static String? validateEmail(String? email) {
    if ((email ?? "").trim().isEmpty) {
      return "Email must not be empty";
    } else if (!RegExp(emailPattern).hasMatch(email!)) {
      return "Invalid email address. Please enter a valid email address.";
    } else {
      return null;
    }
  }

  static emptyValueValidation(String? value,
      {String? errmsg = "Strings.emptyValueMessage"}) {
    return (value ??= "").trim().isEmpty ? errmsg : null;
  }

  static String? validatePhoneNumber(String? value) {
    final pattern = RegExp(r"^[0-9]{1,4}[\s-]?[0-9]{1,4}[\s-]?[0-9]{1,6}$");

    if ((value ?? "").trim().isEmpty) {
      return "Phone number must not be empty";
    } else if (!pattern.hasMatch(value!)) {
      return "Invalid phone number. Please enter a valid numeric phone number with 9 to 14 digits, including the country code if applicable.";
    } else {
      return null;
    }
  }




  static String? validateName(String? value, {String? errmsg = "Strings.emptyValueMessage"}) {
    final pattern = RegExp(r"^[a-zA-ZÀ-ÖØ-öø-ÿ '-]+$");

    if ((value ?? "").trim().isEmpty) {
      return errmsg;
    } else if (!pattern.hasMatch(value!)) {
      return "Invalid name. Please use only letters, spaces, hyphens, or apostrophes.";
    } else {
      return null;
    }
  }

  static nullCheckValidator(String? value, {int? requiredLength}) {
    if (value!.isEmpty) {
      return "Field must not be empty";
    } else if (requiredLength != null) {
      if (value.length < requiredLength) {
        return "Text must be $requiredLength character long";
      } else {
        return null;
      }
    }

    return null;
  }



  static String? validatePassword(String? password, {String? secondFieldValue}) {
    if (password == null || password.isEmpty) {
      return "Password must not be empty";
    } else if (password.length < 8) {
      return "Password must be at least 8 characters long";
    }

    // Check for uppercase and lowercase letters
    if (!password.contains(RegExp(r'[A-Z]')) || !password.contains(RegExp(r'[a-z]'))) {
      return "Password must contain both uppercase and lowercase letters";
    }

    // Check for numbers and special characters
    if (!password.contains(RegExp(r'[0-9]')) || !password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      return "Password must contain numbers and special characters";
    }

    // Avoid common words or patterns
    if (password.contains("password") || password.contains("123456")) {
      return "Avoid using common words or patterns";
    }

    // Check if passwords match (if a second field value is provided)
    if (secondFieldValue != null && password != secondFieldValue) {
      return "Both fields must match";
    }

    return null;
  }



}


// regex Strings.(.*?)(?=[,|\n|\)|}|'|"|])