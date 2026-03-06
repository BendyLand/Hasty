class Node {
  final String tag;
  final String? content;
  final List<Node>? children;
  final Map<String, String> attrs;
  final List<String> boolAttrs;
  final bool rawHtml;
  Node({
    required this.tag,
    this.content,
    this.children,
    Map<String, String?>? attrs,
    List<String>? boolAttrs,
    this.rawHtml = false,
  }) : attrs = (attrs ?? {}).entries
           .where((e) => e.value != null && e.value!.isNotEmpty)
           .fold<Map<String, String>>({}, (prev, curr) {
             prev[curr.key] = curr.value!;
             return prev;
           }),
       boolAttrs = boolAttrs ?? const [];
}
