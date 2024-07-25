class GenericFactory<T> {
  final T Function() _instanceCreator;

  GenericFactory(this._instanceCreator);

  T createInstance() {
    return _instanceCreator();
  }
}