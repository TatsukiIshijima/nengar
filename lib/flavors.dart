enum Flavor {
  DEVELOPMENT,
  PRODUCTION,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
        return 'Dev Nengar';
      case Flavor.PRODUCTION:
        return 'Nengar';
      default:
        return 'title';
    }
  }
}
