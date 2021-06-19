import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorAnimation;
  Animation<double> _sizeAnimation;
  bool state = false;
  Animation _curve;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _curve = CurvedAnimation(parent: _animationController, curve: Curves.slowMiddle);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: Tween<double>(begin: 30, end: 50), weight: 50),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 50, end: 30), weight: 50)
    ]).animate(_curve);

    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red).animate(_curve);

    _animationController.addListener(() {});

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        setState(() {
          state = true;
        });
      if (status == AnimationStatus.dismissed)
        setState(() {
          state = false;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: ((BuildContext context, _) => IconButton(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            icon: Icon(
              Icons.favorite,
              color: _colorAnimation.value,
              size: _sizeAnimation.value,
            ),
            onPressed: () {
              state ? _animationController.reverse() : _animationController.forward();
            },
          )),
    );
  }
}
