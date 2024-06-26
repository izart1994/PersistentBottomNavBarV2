part of "../persistent_bottom_nav_bar_v2.dart";

class Style2BottomNavBar extends StatelessWidget {
  const Style2BottomNavBar({
    required this.navBarConfig,
    this.navBarDecoration = const NavBarDecoration(),
    this.itemAnimationProperties = const ItemAnimation(),
    this.itemPadding = const EdgeInsets.all(5),
    super.key,
  });

  final NavBarConfig navBarConfig;
  final NavBarDecoration navBarDecoration;
  final EdgeInsets itemPadding;

  /// This controls the animation properties of the items of the NavBar.
  final ItemAnimation itemAnimationProperties;

  Widget _buildItem(ItemConfig item, bool isSelected, double deviceWidth) =>
      Column(
        children: [
          AnimatedContainer(
            width: isSelected ? deviceWidth * 0.18 : deviceWidth * 0.12,
            duration: itemAnimationProperties.duration,
            curve: itemAnimationProperties.curve,
            padding: itemPadding,
            decoration: BoxDecoration(
              color: isSelected
                  ? item.activeBackgroundColor
                  : item.inactiveBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(
                    size: item.iconSize,
                    color: isSelected
                        ? item.activeForegroundColor
                        : item.inactiveForegroundColor,
                  ),
                  child: isSelected ? item.icon : item.inactiveIcon,
                ),
              ],
            ),
          ),
          Flexible(
            child: Text(
              item.title!,
              softWrap: false,
              style: item.textStyle.apply(
                fontWeightDelta: isSelected ? 2 : 1,
                color: isSelected
                    ? const Color(0xFF2D365C)
                    : item.inactiveForegroundColor,
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) => DecoratedNavBar(
        decoration: navBarDecoration,
        filter: navBarConfig.selectedItem.filter,
        opacity: navBarConfig.selectedItem.opacity,
        height: 63,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: navBarConfig.items.map((item) {
            final int index = navBarConfig.items.indexOf(item);
            return InkWell(
              onTap: () {
                navBarConfig.onItemSelected(index);
              },
              child: _buildItem(
                item,
                navBarConfig.selectedIndex == index,
                MediaQuery.of(context).size.width,
              ),
            );
          }).toList(),
        ),
      );
}
