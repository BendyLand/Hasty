import 'package:hasty/src/layout.dart';
import 'package:hasty/src/node.dart';
import 'package:hasty/src/style.dart';
import 'package:hasty/src/tags.dart';

// Combines a base style string with an optional extra Style, matching the
// same pattern used in layout.dart.
String? _mergeStyle(String base, Style? extra) {
  if (extra == null || extra.inlineStyle.isEmpty) return base;
  return '$base; ${extra.inlineStyle}';
}

// SECTION: Navigation

/// A link item for use inside [navBar].
Node navLink({
  required String label,
  required String href,
  String? classes,
  Style? style,
}) {
  return a(href: href, content: label, classes: classes, style: style);
}

/// A horizontal navigation bar containing [navLink] (or other) items.
/// Renders as a <nav> with a flex-row layout and a default gap between items.
Node navBar({
  required List<Node> links,
  String? id,
  String? classes,
  Style? style,
}) {
  return Node(
    tag: 'nav',
    attrs: {
      'id': id,
      'class': classes,
      'style': _mergeStyle(
        'display: flex; flex-direction: row; align-items: center; gap: 16px',
        style,
      ),
    },
    children: links,
  );
}

// SECTION: Card

/// A layout container that wraps [children] in a styled box.
/// Use [padding] and [backgroundColor] for quick visual customisation;
/// any further overrides can be passed via [style].
Node card({
  List<Node>? children,
  Style? style,
  double padding = 16,
  Color? backgroundColor,
  String? id,
  String? classes,
}) {
  final base = Style(
    padding: padding,
    borderRadius: 8,
    backgroundColor: backgroundColor,
  );
  return Node(
    tag: 'div',
    attrs: {
      'id': id,
      'class': classes,
      'style': _mergeStyle(base.inlineStyle, style),
    },
    children: children,
  );
}

// SECTION: Badge

/// An inline status chip displaying [label] on a [color] background.
Node badge(
  String label, {
  required Color color,
  String? classes,
  Style? style,
}) {
  final base = Style(
    backgroundColor: color,
    color: Colors.white,
    paddingTop: 3,
    paddingBottom: 3,
    paddingLeft: 8,
    paddingRight: 8,
    borderRadius: 12,
    fontSize: 12,
    fontWeight: FontWeight.semibold,
    display: Display.inlineBlock,
  );
  return Node(
    tag: 'span',
    content: label,
    attrs: {'class': classes, 'style': _mergeStyle(base.inlineStyle, style)},
  );
}

// SECTION: StatCard

/// A compound card displaying an [icon], a large [value] string, and a
/// [label] caption on a coloured background. Uses [card] internally.
Node statCard({
  required String icon,
  required String value,
  required String label,
  required Color color,
  String? id,
  String? classes,
  Style? style,
}) {
  return card(
    id: id,
    classes: classes,
    backgroundColor: color,
    style: style,
    children: [
      vStack(
        style: Style(gap: 4),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          text(icon, style: Style(fontSize: 28, textAlign: TextAlign.center)),
          text(
            value,
            kind: TextKind.h3,
            style: Style(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          ),
          text(
            label,
            kind: TextKind.caption,
            style: Style(color: Colors.white, textAlign: TextAlign.center),
          ),
        ],
      ),
    ],
  );
}
