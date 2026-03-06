class Node {
  final String tag;
  final String? content;
  final List<Node>? children;
  final Map<String, String> attrs;
  final String? css;

  Node({
    required this.tag,
    this.content,
    this.children,
    Map<String, String?>? attrs,
    this.css,
  }) : attrs = (attrs ?? {}).entries
           .where((e) => e.value != null)
           .fold<Map<String, String>>({}, (prev, curr) {
             prev[curr.key] = curr.value!;
             return prev;
           });
}
