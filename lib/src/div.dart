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

  final List<Element> children;

  const Div({this.id, this.children = const [], this.classList = const []});

  // FIX: Update to use StringBuilder for efficiency
  /// Constructs a valid HTML string out of the elements from `this.children`.
  String get content => children.map((e) => e.str).join();
}
