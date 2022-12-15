class Validate {
  static bool textValid(String? name) {
    return name != null && name.trim().isNotEmpty;
  }

  static bool emailValid(String? email) {
    return email != null &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email);
  }

  static bool addressCompanyValid(String? address) {
    return address != null && address.trim().isNotEmpty;
  }

  static bool descriptionValid(String? description) {
    return description != null && description.trim().isNotEmpty;
  }

  static bool linkValid(String? link) {
    return link != null && link.trim().isNotEmpty;
  }

  static bool privateKeyValid(String? privateKey) {
    return privateKey != null && privateKey.length == 64;
  }

  static bool numberValid(String? price) {
    try {
      return price != null && !price.startsWith(".") && double.parse(price) > 0;
    } on FormatException {
      return false;
    }
  }

  static bool addressEtherValid(String? address) {
    return address != null &&
        address.trim().isNotEmpty &&
        address.startsWith("0x") &&
        address.length == 42;
  }
}
