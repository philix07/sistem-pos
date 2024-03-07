import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.width = 120,
    this.height = 40,
    this.iconWidth = 30,
    this.iconHeight = 30,
    this.fontSize = 14.0,
    this.withIcon = false,
    this.isActive = false,
    this.isRow = false,
    this.iconPath,
  });

  final double width;
  final double height;
  final String title;
  final double fontSize;
  final bool isActive;
  final bool withIcon;
  final bool isRow;
  final String? iconPath;
  final double iconWidth;
  final double iconHeight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color contentColor = isActive ? AppColor.white : AppColor.primary;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: isActive ? AppColor.primary : AppColor.white,
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 5.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: AppColor.black.withOpacity(0.2),
            ),
          ],
        ),
        child: withIcon
            ? isRow
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(
                        iconPath!,
                        colorFilter: ColorFilter.mode(
                          contentColor,
                          BlendMode.srcIn,
                        ),
                        width: iconWidth,
                        height: iconHeight,
                      ),
                      const SpaceWidth(10.0),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            style: isActive
                                ? AppTextStyle.white(fontSize: fontSize)
                                : AppTextStyle.blue(fontSize: fontSize),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        iconPath!,
                        colorFilter: ColorFilter.mode(
                          contentColor,
                          BlendMode.srcIn,
                        ),
                        width: iconWidth,
                        height: iconHeight,
                      ),
                      const SpaceHeight(5.0),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          title,
                          style: isActive
                              ? AppTextStyle.white(fontSize: fontSize)
                              : AppTextStyle.blue(fontSize: fontSize),
                        ),
                      ),
                    ],
                  )
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  style: isActive
                      ? AppTextStyle.white(fontSize: fontSize)
                      : AppTextStyle.blue(fontSize: fontSize),
                ),
              ),
      ),
    );
  }
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.title,
    required this.onTap,
    this.iconSize = 20,
    this.width = 140,
    this.height = 40,
    this.isBlue = false,
    this.isSvg = false,
    this.isRow = true,
    this.svgHeight,
    this.svgWidth,
    this.icon,
    this.iconPath,
    this.fontSize = 14,
  });

  final bool isBlue;
  final bool isSvg;
  final bool isRow;
  final double iconSize;
  final double width;
  final double height;
  final String title;
  final IconData? icon;
  final String? iconPath;
  final VoidCallback onTap;
  final double? svgWidth;
  final double? svgHeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    Color childColor = isBlue ? AppColor.white : AppColor.primary;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: isBlue ? AppColor.primary : AppColor.white,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 5.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: AppColor.black.withOpacity(0.2),
            ),
          ],
        ),
        child: isRow
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isSvg
                      ? Expanded(
                          child: SvgPicture.asset(
                            iconPath!,
                            width: svgWidth,
                            height: svgHeight,
                            colorFilter:
                                ColorFilter.mode(childColor, BlendMode.srcIn),
                          ),
                        )
                      : Icon(icon, color: childColor, size: iconSize),
                  const SpaceWidth(15.0),
                  Expanded(
                    flex: 6,
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      style: isBlue
                          ? AppTextStyle.white(
                              fontSize: fontSize, fontWeight: FontWeight.w700)
                          : AppTextStyle.blue(
                              fontSize: fontSize, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isSvg
                      ? SvgPicture.asset(
                          iconPath!,
                          width: svgWidth,
                          height: svgHeight,
                          colorFilter:
                              ColorFilter.mode(childColor, BlendMode.srcIn),
                        )
                      : Icon(icon, color: childColor, size: iconSize),
                  const SpaceHeight(15.0),
                  Text(
                    title,
                    textAlign: TextAlign.left,
                    style: isBlue
                        ? AppTextStyle.white(
                            fontSize: fontSize, fontWeight: FontWeight.w700)
                        : AppTextStyle.blue(
                            fontSize: fontSize, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
      ),
    );
  }
}

class AppCustomButton extends StatelessWidget {
  const AppCustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.width = 120,
    this.height = 40,
    this.isActive = false,
  });

  final double width;
  final double height;
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: isActive ? AppColor.primary : AppColor.white,
          borderRadius: const BorderRadius.all(Radius.circular(2.0)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 5.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: AppColor.black.withOpacity(0.2),
            ),
          ],
        ),
        child: Text(
          title,
          style: isActive
              ? AppTextStyle.white(fontSize: 14.0)
              : AppTextStyle.blue(fontSize: 14.0),
        ),
      ),
    );
  }
}
