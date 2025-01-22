class Validators {
  static String? validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "$fieldName est obligatoire.";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "L'email est obligatoire.";
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return "L'email n'est pas valide.";
    }
    return null;
  }
}
