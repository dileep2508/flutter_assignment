class HomeState {
  final bool isLoading;
  final List<Map<String, String>> images;
  final String? error;

  HomeState({required this.isLoading, required this.images, this.error});

  factory HomeState.initial() => HomeState(isLoading: false, images: []);
}
