class InputValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) {
      return 'Por favor, informe um e-mail válido';
    }
    return null;
  }

  static String? validateComun(String? value) {
    {
      if (value == null || value.isEmpty) {
        return 'Campo obrigatório';
      }
      return null;
    }
  }

  static validateCpf(String cpf) {
    // Remove all non-digit characters
    cpf = cpf.replaceAll(RegExp(r'\D'), '');

    if (cpf.length != 11) {
      return false;
    }

    // Invalid CPF numbers
    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
      return false;
    }

    List<int> numbers = cpf.split('').map(int.parse).toList();

    // Validate first digit
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += numbers[i] * (10 - i);
    }
    int result = sum % 11;
    if (result < 2) {
      if (numbers[9] != 0) {
        return false;
      }
    } else if (numbers[9] != 11 - result) {
      return false;
    }

    // Validate second digit
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += numbers[i] * (11 - i);
    }
    result = sum % 11;
    if (result < 2) {
      if (numbers[10] != 0) {
        return false;
      }
    } else if (numbers[10] != 11 - result) {
      return false;
    }

    return true;
  }
}
