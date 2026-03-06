import 'dart:io';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:mason_logger/mason_logger.dart';
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

void _generateLoop(Node node, StringBuffer htmlBuffer) {
  final attrString = node.attrs.entries
      .map((e) => ' ${e.key}="${_escapeAttr(e.value)}"')
      .join();
  final boolAttrString = node.boolAttrs.map((a) => ' $a').join();
  htmlBuffer.write('<${node.tag}$attrString$boolAttrString>');
  if (_voidElements.contains(node.tag)) return;
  if (node.content != null) {
    htmlBuffer.write(node.rawHtml ? node.content : _escapeHtml(node.content!));
  } else if (node.children != null) {
    for (var child in node.children!) {
      _generateLoop(child, htmlBuffer);
    }
  }
  htmlBuffer.write('</${node.tag}>');
}

/// Returns the raw HTML string for [root] without writing any files.
String renderHtml(Node root) {
  final htmlBuffer = StringBuffer();
  _generateLoop(root, htmlBuffer);
  return htmlBuffer.toString();
}

/// Emits the generated code from [root].
Future<void> emit(
  Node root, {
  String outputDir = 'build',
  String fileName = 'index',
  String title = '',
  String lang = 'en',
}) async {
  final logger = Logger();
  final progress = logger.progress('Building $fileName.html');
  try {
    final htmlBuffer = StringBuffer();
    _generateLoop(root, htmlBuffer);
    final dir = Directory(outputDir);
    if (!await dir.exists()) await dir.create(recursive: true);
    final headLines = [
      '  <meta charset="utf-8">',
      '  <meta name="viewport" content="width=device-width, initial-scale=1.0">',
      if (title.isNotEmpty) '  <title>$title</title>',
    ];
    final rawHtml =
        '''<!DOCTYPE html>
<html lang="$lang">
<head>
${headLines.join('\n')}
</head>
<body>
${htmlBuffer.toString()}
</body>
</html>''';
    final fullHtml = BeautifulSoup(rawHtml).prettify();
    await File('${dir.path}/$fileName.html').writeAsString(fullHtml);
    progress.complete('Generated $fileName.html → $outputDir');
  } catch (e) {
    progress.fail('Failed to generate $fileName.html');
    rethrow;
  }
}
