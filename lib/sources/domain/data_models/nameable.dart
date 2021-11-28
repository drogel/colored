class Nameable {
  const Nameable(this.name);

  final String name;

  @override
  bool operator ==(Object other) => other is Nameable && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
