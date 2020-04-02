import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/model/navigation_item.dart';
import 'package:workout_app/utils/global.dart';
import 'package:workout_app/utils/themes.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({
    this.height = 60,
    @required this.navItems,
    @required this.defaultIndex,
    @required this.onTap,
  });

  final double height;
  final List<NavigationItem> navItems;
  final int defaultIndex;
  final Function onTap;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  ValueListenable<ScaffoldGeometry> geometryListenable;
  double _padding = 5.0;
  int _selectedIndex;
  Size _size;

  @override
  initState() {
    super.initState();
    _selectedIndex = widget.defaultIndex;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    geometryListenable = Scaffold.geometryOf(context);
    _size = MediaQuery.of(context).size;
  }

  Widget _buildItem(NavigationItem item, int itemIndex, bool isSelected) {
    return Flexible(
      child: Container(
        height: widget.height,
        width: _size.width / widget.navItems.length,
        child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: gLargeBorderRadius),
          highlightColor: Themes.cLightViolet.withOpacity(0.1),
          splashColor: Themes.cLightViolet.withOpacity(0.1),
          onPressed: () {
            setState(() {
              _selectedIndex = itemIndex;
              widget.onTap(itemIndex);
            });
          },
          child: Icon(
            item.icon,
            size: 24.0,
            color: isSelected ? Themes.cButtonViolet : Themes.cLightGrey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _BottomNavBarClipper(
          geometry: geometryListenable,
          shape: CircularNotchedRectangle(),
          notchMargin: 5.0),
      child: Padding(
        padding: EdgeInsets.all(_padding),
        child: Container(
          width: _size.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Themes.cDarkGrey,
            borderRadius: gLargeBorderRadius,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.navItems.map((item) {
              int itemIndex = widget.navItems.indexOf(item);
              return _buildItem(item, itemIndex, _selectedIndex == itemIndex);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _BottomNavBarClipper extends CustomClipper<Path> {
  const _BottomNavBarClipper({
    @required this.geometry,
    @required this.shape,
    @required this.notchMargin,
  })  : assert(geometry != null),
        assert(shape != null),
        assert(notchMargin != null),
        super(reclip: geometry);

  final ValueListenable<ScaffoldGeometry> geometry;
  final NotchedShape shape;
  final double notchMargin;

  @override
  Path getClip(Size size) {
    final Rect button = geometry.value.floatingActionButtonArea?.translate(
      0.0,
      geometry.value.bottomNavigationBarTop * -1.0,
    );
    return shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));
  }

  @override
  bool shouldReclip(_BottomNavBarClipper oldClipper) {
    return oldClipper.geometry != geometry ||
        oldClipper.shape != shape ||
        oldClipper.notchMargin != notchMargin;
  }
}
