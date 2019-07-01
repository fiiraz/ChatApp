class CommentBuilder {
  static String commentText(text, screen, index) {
    if (screen == "reviews_home") {
      if (text.length > 14) {
        return text.substring(0, 14) + "...";
      } else
        return text;
    } else if (screen == "reviews_recents") {
      if (text.length > 47) {
        return text.substring(0, 47) + "...";
      } else
        return text;
    } else if (screen == "reviews_search") {
      if (text.length > 47) {
        return text.substring(0, 47) + "...";
      } else
        return text;
    }
  }

  static String SurnameBuilder(text) {
    bool surname = text.contains(" ");
    if (surname) {
      int index = text.indexOf(" ");
      var result = text.substring(0, index + 2) + ".";
      return result;
    } else
      return text;
  }
}
