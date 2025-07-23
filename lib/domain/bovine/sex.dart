enum Sex {
  male("male", "Macho"),
  female("female", "Fêmea");

  const Sex(this.code, this.label);

  final String code;
  final String label;

  @override
  String toString() => label;
}
