/// Mixin for any elements that are part of any classes.
mixin ClassInfo {
  /// Returns the formatted string of classes: ' class="class1 class2 etc."'
  String get classes =>
      classList.isNotEmpty ? ' class="${classList.join(" ")}"' : '';

  /// The list of classes that the element is part of.
  List<String> get classList;
}

/// Mixin for any elements with an id.
mixin IdInfo {
  /// Id of the element.
  String? get id;

  /// The formatted id string: ' id="id"'
  String get idStr => id != null ? ' id="$id"' : '';
}
