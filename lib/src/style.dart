class Color {
  final String value;

  const Color.hex(String hex) : value = hex;
  const Color.rgb(int r, int g, int b) : value = 'rgb($r, $g, $b)';
  const Color.rgba(int r, int g, int b, double a)
    : value = 'rgba($r, $g, $b, $a)';

  @override
  String toString() => value;
}

abstract final class Colors {
  static const black = Color.hex('#000000');
  static const white = Color.hex('#ffffff');
  static const red = Color.hex('#ef4444');
  static const orange = Color.hex('#f97316');
  static const yellow = Color.hex('#eab308');
  static const green = Color.hex('#22c55e');
  static const teal = Color.hex('#14b8a6');
  static const blue = Color.hex('#3b82f6');
  static const indigo = Color.hex('#6366f1');
  static const purple = Color.hex('#a855f7');
  static const pink = Color.hex('#ec4899');
  static const gray = Color.hex('#6b7280');
  static const lightGray = Color.hex('#d1d5db');
  static const darkGray = Color.hex('#374151');
  static const transparent = Color.hex('transparent');
}

final class FontWeight {
  final String _value;
  const FontWeight._(this._value);

  static const thin = FontWeight._('100');
  static const light = FontWeight._('300');
  static const normal = FontWeight._('400');
  static const medium = FontWeight._('500');
  static const semibold = FontWeight._('600');
  static const bold = FontWeight._('700');
  static const extrabold = FontWeight._('800');

  @override
  String toString() => _value;
}

enum TextAlign { left, right, center, justify }

enum TextDecoration { none, underline, lineThrough, overline }

enum Position { static_, relative, absolute, fixed, sticky }

enum Display {
  block,
  inline,
  inlineBlock,
  flex,
  inlineFlex,
  grid,
  inlineGrid,
  none,
}

enum Float { none, left, right }

enum FlexWrap { nowrap, wrap, wrapReverse }

enum AlignSelf { auto, start, end, center, stretch, baseline }

class Style {
  final Color? color;
  final Color? backgroundColor;
  final double? padding;
  final double? paddingTop;
  final double? paddingRight;
  final double? paddingBottom;
  final double? paddingLeft;
  final double? margin;
  final double? marginTop;
  final double? marginRight;
  final double? marginBottom;
  final double? marginLeft;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? lineHeight;
  final double? letterSpacing;
  final double? width;
  final double? height;
  final double? maxWidth;
  final double? maxHeight;
  final double? minWidth;
  final double? minHeight;
  final double? borderRadius;
  final String? border;
  final Color? borderColor;
  final double? borderWidth;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final double? opacity;
  final String? overflow;
  final double? gap;
  final double? rowGap;
  final double? columnGap;
  final Position? position;
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;
  final int? zIndex;
  final Display? display;
  final Float? float;
  final FlexWrap? flexWrap;
  final AlignSelf? alignSelf;

  const Style({
    this.color,
    this.backgroundColor,
    this.padding,
    this.paddingTop,
    this.paddingRight,
    this.paddingBottom,
    this.paddingLeft,
    this.margin,
    this.marginTop,
    this.marginRight,
    this.marginBottom,
    this.marginLeft,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.lineHeight,
    this.letterSpacing,
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.minWidth,
    this.minHeight,
    this.borderRadius,
    this.border,
    this.borderColor,
    this.borderWidth,
    this.textAlign,
    this.textDecoration,
    this.opacity,
    this.overflow,
    this.gap,
    this.rowGap,
    this.columnGap,
    this.position,
    this.top,
    this.right,
    this.bottom,
    this.left,
    this.zIndex,
    this.display,
    this.float,
    this.flexWrap,
    this.alignSelf,
  });

  String get inlineStyle {
    final parts = <String>[];
    if (color != null) parts.add('color: $color');
    if (backgroundColor != null) {
      parts.add('background-color: $backgroundColor');
    }
    if (padding != null) parts.add('padding: ${padding}px');
    if (paddingTop != null) parts.add('padding-top: ${paddingTop}px');
    if (paddingRight != null) parts.add('padding-right: ${paddingRight}px');
    if (paddingBottom != null) parts.add('padding-bottom: ${paddingBottom}px');
    if (paddingLeft != null) parts.add('padding-left: ${paddingLeft}px');
    if (margin != null) parts.add('margin: ${margin}px');
    if (marginTop != null) parts.add('margin-top: ${marginTop}px');
    if (marginRight != null) parts.add('margin-right: ${marginRight}px');
    if (marginBottom != null) parts.add('margin-bottom: ${marginBottom}px');
    if (marginLeft != null) parts.add('margin-left: ${marginLeft}px');
    if (fontSize != null) parts.add('font-size: ${fontSize}px');
    if (fontWeight != null) parts.add('font-weight: $fontWeight');
    if (fontFamily != null) parts.add('font-family: $fontFamily');
    if (lineHeight != null) parts.add('line-height: $lineHeight');
    if (letterSpacing != null) parts.add('letter-spacing: ${letterSpacing}px');
    if (width != null) parts.add('width: ${width}px');
    if (height != null) parts.add('height: ${height}px');
    if (maxWidth != null) parts.add('max-width: ${maxWidth}px');
    if (maxHeight != null) parts.add('max-height: ${maxHeight}px');
    if (minWidth != null) parts.add('min-width: ${minWidth}px');
    if (minHeight != null) parts.add('min-height: ${minHeight}px');
    if (borderRadius != null) parts.add('border-radius: ${borderRadius}px');
    if (border != null) parts.add('border: $border');
    if (borderColor != null) parts.add('border-color: $borderColor');
    if (borderWidth != null) parts.add('border-width: ${borderWidth}px');
    if (textAlign != null) {
      parts.add('text-align: ${_textAlignValue(textAlign!)}');
    }
    if (textDecoration != null) {
      parts.add('text-decoration: ${_textDecorationValue(textDecoration!)}');
    }
    if (opacity != null) parts.add('opacity: $opacity');
    if (overflow != null) parts.add('overflow: $overflow');
    if (gap != null) parts.add('gap: ${gap}px');
    if (rowGap != null) parts.add('row-gap: ${rowGap}px');
    if (columnGap != null) parts.add('column-gap: ${columnGap}px');
    if (position != null) parts.add('position: ${_positionValue(position!)}');
    if (top != null) parts.add('top: ${top}px');
    if (right != null) parts.add('right: ${right}px');
    if (bottom != null) parts.add('bottom: ${bottom}px');
    if (left != null) parts.add('left: ${left}px');
    if (zIndex != null) parts.add('z-index: $zIndex');
    if (display != null) parts.add('display: ${_displayValue(display!)}');
    if (float != null) parts.add('float: ${_floatValue(float!)}');
    if (flexWrap != null) parts.add('flex-wrap: ${_flexWrapValue(flexWrap!)}');
    if (alignSelf != null) {
      parts.add('align-self: ${_alignSelfValue(alignSelf!)}');
    }
    return parts.join('; ');
  }

  String _textAlignValue(TextAlign a) => switch (a) {
    TextAlign.left => 'left',
    TextAlign.right => 'right',
    TextAlign.center => 'center',
    TextAlign.justify => 'justify',
  };

  String _textDecorationValue(TextDecoration d) => switch (d) {
    TextDecoration.none => 'none',
    TextDecoration.underline => 'underline',
    TextDecoration.lineThrough => 'line-through',
    TextDecoration.overline => 'overline',
  };

  String _positionValue(Position p) => switch (p) {
    Position.static_ => 'static',
    Position.relative => 'relative',
    Position.absolute => 'absolute',
    Position.fixed => 'fixed',
    Position.sticky => 'sticky',
  };

  String _displayValue(Display d) => switch (d) {
    Display.block => 'block',
    Display.inline => 'inline',
    Display.inlineBlock => 'inline-block',
    Display.flex => 'flex',
    Display.inlineFlex => 'inline-flex',
    Display.grid => 'grid',
    Display.inlineGrid => 'inline-grid',
    Display.none => 'none',
  };

  String _floatValue(Float f) => switch (f) {
    Float.none => 'none',
    Float.left => 'left',
    Float.right => 'right',
  };

  String _flexWrapValue(FlexWrap w) => switch (w) {
    FlexWrap.nowrap => 'nowrap',
    FlexWrap.wrap => 'wrap',
    FlexWrap.wrapReverse => 'wrap-reverse',
  };

  String _alignSelfValue(AlignSelf a) => switch (a) {
    AlignSelf.auto => 'auto',
    AlignSelf.start => 'flex-start',
    AlignSelf.end => 'flex-end',
    AlignSelf.center => 'center',
    AlignSelf.stretch => 'stretch',
    AlignSelf.baseline => 'baseline',
  };
}
