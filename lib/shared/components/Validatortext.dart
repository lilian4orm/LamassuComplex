import 'package:flutter/material.dart';

import '../../modules/form/cubit/state.dart';

class Validator {
  static String? validateNameController(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }

  static String? validateNumberController(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }

  static String? occupationController(String? value, TextEditingController priceController, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
    }

    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    int? firstPayment = int.tryParse(value.replaceAll(',', ''));
    int? price = int.tryParse(priceController.text.replaceAll(',', ''));

    if (firstPayment != null && price != null && firstPayment > price) {
      return "القيمة المدخلة أكبر من السعر";
    }

    return null;
  }
  static String? addressController(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }

  static String? familyCountController(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }

  static String? reasonController(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }

  static String? reasonController1(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }

  static String? reasonController2(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }
  static String? reasonController3(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }

  static String? reasonController4(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }

  static String? reasonController5(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }

  static String? reasonController6(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }

  static String? reasonController7(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }

  static String? reasonController8(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }

  static String? reasonController9(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }

  static String? reasonController10(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }

  static String? reasonController11(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }
}
