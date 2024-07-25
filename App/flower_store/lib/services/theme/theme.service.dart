class ThemeService {
  late bool isDarkMode;
  ThemeService({ bool? isDarkMode }) {
    this.isDarkMode = isDarkMode ?? false;
  }
}