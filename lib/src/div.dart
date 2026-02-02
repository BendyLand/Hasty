import 'package:hasty/src/element.dart';
import 'package:hasty/src/shared.dart';

/// Object to represent a <div></div> element.
///
/// Accepts a list of other children [Element]s.
class Div extends Element with IdInfo, ClassInfo {
  @override
  final String? id;
  @override
  final List<String> classList;
  @override
  String get str => '<div$idStr$classes>$content</div>';

  /// A list of `Element`s that are children of the current Element.
  final List<Element> children;

  /// Creates a Div object with optional [id], [classList], and [children].
  const Div({this.id, this.children = const [], this.classList = const []});

  /// Constructs a valid HTML string out of the elements from `this.children`.
  // FIX: Update to use StringBuilder for efficiency
  String get content => children.map((e) => e.str).join();
}
