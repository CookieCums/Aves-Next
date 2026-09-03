enum AppFlavor { izzy, libre }

extension ExtraAppFlavor on AppFlavor {
  bool get canEnableErrorReporting => false;

  bool get hasMapStyleDefault => false;
}
