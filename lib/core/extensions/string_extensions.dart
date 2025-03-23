extension StringX on String {
  String get errorToPresentableString =>
      replaceAll('-', ' ').replaceFirst(this[0], this[0].toUpperCase());
}
