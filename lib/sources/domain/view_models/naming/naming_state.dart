class NamingState {
  const NamingState();
}

class Changing extends NamingState {
  const Changing();
}

class Unknown extends NamingState {
  const Unknown();
}

class NoConnectivity extends Unknown {
  const NoConnectivity();
}

class Named extends NamingState {
  const Named(this.name);

  final String name;
}
