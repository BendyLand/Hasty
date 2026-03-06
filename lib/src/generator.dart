import 'dart:io';
import 'node.dart';

const _voidElements = {
  'area',
  'base',
  'br',
  'col',
  'embed',
  'hr',
  'img',
  'input',
  'link',
  'meta',
  'param',
  'source',
  'track',
  'wbr',
};

/// Escapes characters that are special inside HTML text content.
String _escapeHtml(String text) => text
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;');

/// Escapes characters that are special inside a double-quoted attribute value.
String _escapeAttr(String value) =>
    value.replaceAll('&', '&amp;').replaceAll('"', '&quot;');

void _generateLoop(Node node, StringBuffer htmlBuffer, Set<String> cssSet) {
  if (node.css != null) cssSet.add(node.css!);

  final attrString = node.attrs.entries
      .map((e) => ' ${e.key}="${_escapeAttr(e.value)}"')
      .join();

  final boolAttrString = node.boolAttrs.map((a) => ' $a').join();

  htmlBuffer.write('<${node.tag}$attrString$boolAttrString>');

  if (_voidElements.contains(node.tag)) return;

  if (node.content != null) {
    htmlBuffer.write(node.rawHtml ? node.content : _escapeHtml(node.content!));
  }
  else if (node.children != null) {
    for (var child in node.children!) {
      _generateLoop(child, htmlBuffer, cssSet);
    }
  }

  htmlBuffer.write('</${node.tag}>');
}

/// Returns the raw HTML string for [root] without writing any files.
String renderHtml(Node root) {
  final htmlBuffer = StringBuffer();
  final cssSet = <String>{};
  _generateLoop(root, htmlBuffer, cssSet);
  return htmlBuffer.toString();
}

/// Emits the generated code from [root].
Future<void> emit(
  Node root, {
  String outputDir = 'build',
  String fileName = 'index',
}) async {
  final htmlBuffer = StringBuffer();
  final cssSet = <String>{};

  _generateLoop(root, htmlBuffer, cssSet);

  final dir = Directory(outputDir);
  if (!await dir.exists()) await dir.create(recursive: true);

  // Write CSS if it exists
  if (cssSet.isNotEmpty) {
    await File('${dir.path}/$fileName.css').writeAsString(cssSet.join('\n'));
  }

  // Construct full HTML
  final cssLink = cssSet.isNotEmpty
      ? '<link rel="stylesheet" href="$fileName.css">'
      : '';

  final fullHtml =
      '''
<!DOCTYPE html>
<html>
<head>
  $cssLink
</head>
<body>
${htmlBuffer.toString()}
</body>
</html>
''';

  await File('${dir.path}/$fileName.html').writeAsString(fullHtml);
  print('Generated $fileName.html to $outputDir');
}
