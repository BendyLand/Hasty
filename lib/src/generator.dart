import 'dart:io';
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

void _generateLoop(Node node, StringBuffer buf, int indent) {
  final attrString = node.attrs.entries
      .map((e) => ' ${e.key}="${_escapeAttr(e.value)}"')
      .join();
  final boolAttrString = node.boolAttrs.map((a) => ' $a').join();
  final pad = '  ' * indent;

  if (_voidElements.contains(node.tag)) {
    buf.writeln('$pad<${node.tag}$attrString$boolAttrString>');
    return;
  }

  if (node.content != null) {
    final content = node.rawHtml ? node.content! : _escapeHtml(node.content!);
    buf.writeln(
      '$pad<${node.tag}$attrString$boolAttrString>$content</${node.tag}>',
    );
  } else if (node.children != null && node.children!.isNotEmpty) {
    buf.writeln('$pad<${node.tag}$attrString$boolAttrString>');
    for (final child in node.children!) {
      _generateLoop(child, buf, indent + 1);
    }
    buf.writeln('$pad</${node.tag}>');
  } else {
    buf.writeln('$pad<${node.tag}$attrString$boolAttrString></${node.tag}>');
  }
}

/// Returns the raw HTML string for [root] without writing any files.
String renderHtml(Node root) {
  final buf = StringBuffer();
  _generateLoop(root, buf, 0);
  return buf.toString();
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
    final buf = StringBuffer();
    _generateLoop(root, buf, 2);
    final headLines = [
      '    <meta charset="utf-8">',
      '    <meta name="viewport" content="width=device-width, initial-scale=1.0">',
      if (title.isNotEmpty) '    <title>$title</title>',
    ];
    final fullHtml =
        '<!DOCTYPE html>\n'
        '<html lang="$lang">\n'
        '  <head>\n'
        '${headLines.join('\n')}\n'
        '  </head>\n'
        '  <body>\n'
        '${buf.toString().trimRight()}\n'
        '  </body>\n'
        '</html>\n';
    final dir = Directory(outputDir);
    if (!await dir.exists()) await dir.create(recursive: true);
    await File('${dir.path}/$fileName.html').writeAsString(fullHtml);
    progress.complete('Generated $fileName.html → $outputDir');
  } catch (e) {
    progress.fail('Failed to generate $fileName.html');
    rethrow;
  }
}
