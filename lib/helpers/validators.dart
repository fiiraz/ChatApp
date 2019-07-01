class CustomValidators {
  static validate(value, validation) {
    try {
      validation(value);
    } catch (e) {
      return "Please check info";
    }
  }
}
