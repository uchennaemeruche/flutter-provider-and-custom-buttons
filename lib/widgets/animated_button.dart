import 'package:flutter/material.dart';

class ButtonAnimation extends StatefulWidget {
  final Color primaryColor, darkPrimaryColor;

  ButtonAnimation({this.primaryColor, this.darkPrimaryColor});
  @override
  _ButtonAnimationState createState() => _ButtonAnimationState();
}

class _ButtonAnimationState extends State<ButtonAnimation>with TickerProviderStateMixin {
  AnimationController _animationController,
      _scaleAnimationController,
      _fadeAnimationController;

  Animation<double> _animation, _scaleAnimation, _fadeAnimation;

  double buttonWidth = 200.0, scale = 1.0, barColorOpacity = 0.6;
  bool animationComplete = false, animationStart = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _scaleAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _fadeAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _fadeAnimation =
        Tween<double>(begin: 50.0, end: 0.0).animate(_fadeAnimationController);

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.05).animate(_scaleAnimationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _scaleAnimationController.reverse();
              _fadeAnimationController.forward();
              _animationController.forward();
            }
          });

    _animation = Tween<double>(begin: 0.0, end: buttonWidth)
        .animate(_animationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                animationComplete = true;
                barColorOpacity = 0.0;
              });
            }
          });
  }

  @override
  void dispose() {
    
    super.dispose();
    _animationController.dispose();
    _fadeAnimationController.dispose();
    _scaleAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _scaleAnimationController,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: InkWell(
              onTap: () => _scaleAnimationController.forward(),
              child: Container(
                height: 50.0,
                width: buttonWidth,
                decoration: BoxDecoration(
                  color: widget.primaryColor,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        child: animationComplete == false ? Text(
                          "Download",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ): Icon(Icons.check, color: Colors.white,),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _fadeAnimationController,
                      builder: (context, child) => Container(
                        height: 50.0,
                        width: _fadeAnimation.value,
                        decoration: BoxDecoration(
                          color: widget.darkPrimaryColor,
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => Positioned(
            left: 0,
            top: 0,
            height: 50,
            width: _animation.value,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              opacity: barColorOpacity,
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}