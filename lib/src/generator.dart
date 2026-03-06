import 'dart:io';
import 'node.dart';

void _generateLoop(Node node, StringBuffer htmlBuffer, Set<String> cssSet) {
  if (node.css != null) cssSet.add(node.css!);

  // Attributes are already non-null thanks to the Node constructor
  final attrString = node.attrs.entries
      .map((e) => ' ${e.key}="${e.value}"')
      .join();

  htmlBuffer.write('<${node.tag}$attrString>');

  if (node.content != null) {
    htmlBuffer.write(node.content);
  }
  else if (node.children != null) {
    for (var child in node.children!) {
      _generateLoop(child, htmlBuffer, cssSet);
    }
  }

  htmlBuffer.write('</${node.tag}>');
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
