import 'package:hasty/src/node.dart';

/// A generic container (div).
Node div({String? id, String? classes, List<Node>? children, String? css}) {
  return Node(
    tag: 'div',
    attrs: {'id': id, 'class': classes},
    children: children,
    css: css,
  );
}

/// A standard paragraph.
Node p(String text, {String? classes, String? css}) {
  return Node(tag: 'p', attrs: {'class': classes}, content: text, css: css);
}

/// A main heading.
Node h1(String text, {String? classes, String? css}) {
  return Node(tag: 'h1', attrs: {'class': classes}, content: text, css: css);
}

/// An anchor link.
Node a({
  required String href,
  required String text,
  String? classes,
  String? target,
}) {
  return Node(
    tag: 'a',
    attrs: {'href': href, 'class': classes, 'target': target},
    content: text,
  );
}
