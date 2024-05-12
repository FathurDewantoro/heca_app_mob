List<String> splitString(String input) {
  List<String> parts = input.split("_");

  if (parts.length != 2) {
    throw Exception("Pemisah tidak ditemukan atau terlalu banyak pemisah");
  }

  return parts;
}
