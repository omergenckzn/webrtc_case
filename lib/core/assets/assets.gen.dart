/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/Add-User.svg
  SvgGenImage get addUser => const SvgGenImage('assets/icons/Add-User.svg');

  /// File path: assets/icons/Gem.svg
  SvgGenImage get gemSvg => const SvgGenImage('assets/icons/Gem.svg');

  /// File path: assets/icons/gem.png
  AssetGenImage get gemPng => const AssetGenImage('assets/icons/gem.png');

  /// File path: assets/icons/Hide.svg
  SvgGenImage get hide => const SvgGenImage('assets/icons/Hide.svg');

  /// File path: assets/icons/Message.svg
  SvgGenImage get message => const SvgGenImage('assets/icons/Message.svg');

  /// File path: assets/icons/Unlock.svg
  SvgGenImage get unlock => const SvgGenImage('assets/icons/Unlock.svg');

  /// File path: assets/icons/account-circle-line.svg
  SvgGenImage get accountCircleLine =>
      const SvgGenImage('assets/icons/account-circle-line.svg');

  /// File path: assets/icons/account.svg
  SvgGenImage get account => const SvgGenImage('assets/icons/account.svg');

  /// File path: assets/icons/alert-fill.svg
  SvgGenImage get alertFill => const SvgGenImage('assets/icons/alert-fill.svg');

  /// File path: assets/icons/alert_warning.svg
  SvgGenImage get alertWarning =>
      const SvgGenImage('assets/icons/alert_warning.svg');

  /// File path: assets/icons/apple.svg
  SvgGenImage get apple => const SvgGenImage('assets/icons/apple.svg');

  /// File path: assets/icons/arrow_left.svg
  SvgGenImage get arrowLeft => const SvgGenImage('assets/icons/arrow_left.svg');

  /// File path: assets/icons/cute_arrow.png
  AssetGenImage get cuteArrow =>
      const AssetGenImage('assets/icons/cute_arrow.png');

  /// File path: assets/icons/eye_open.svg
  SvgGenImage get eyeOpen => const SvgGenImage('assets/icons/eye_open.svg');

  /// File path: assets/icons/facebook.svg
  SvgGenImage get facebook => const SvgGenImage('assets/icons/facebook.svg');

  /// File path: assets/icons/hashtag.svg
  SvgGenImage get hashtag => const SvgGenImage('assets/icons/hashtag.svg');

  /// File path: assets/icons/hearth.png
  AssetGenImage get hearth => const AssetGenImage('assets/icons/hearth.png');

  /// File path: assets/icons/pop_button.svg
  SvgGenImage get popButton => const SvgGenImage('assets/icons/pop_button.svg');

  /// List of all assets
  List<dynamic> get values => [
        addUser,
        gemSvg,
        gemPng,
        hide,
        message,
        unlock,
        accountCircleLine,
        account,
        alertFill,
        alertWarning,
        apple,
        arrowLeft,
        cuteArrow,
        eyeOpen,
        facebook,
        hashtag,
        hearth,
        popButton
      ];
}

class Assets {
  Assets._();

  static const String aEnv = '.env';
  static const $AssetsIconsGen icons = $AssetsIconsGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
