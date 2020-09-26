import 'package:flutter/material.dart';
import 'package:flutter_check_app/views/note_list.dart';
import 'package:page_transition/page_transition.dart';

class SwipeButton extends StatefulWidget {
  @override
  _SwipeButtonState createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton> with TickerProviderStateMixin{
  
  AnimationController _scaleAnimationController, _scale2AnimationController, _widthController, _positionController;

  Animation<double> _scaleAnimation, _scale2Animation, _widthAnimation, _positionAnimation;

  bool hideIcon = false;

  final Color buttonColor =  Color(0xff1a237e);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scaleAnimationController = AnimationController(vsync: this, duration:Duration(milliseconds:300));

    _scaleAnimation = Tween<double>(
      begin: 1.0, 
      end: 0.8
    ).animate(_scaleAnimationController)..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _widthController.forward();
      }
    });


    _widthController = AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    _widthAnimation = Tween<double>(
      begin: 80.0,
      end: 300.0
    ).animate(_widthController)..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _positionController.forward();
      }
    });

    _positionController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

    _positionAnimation = Tween<double>(
      begin: -1.0,
      end: 1.0
    ).animate(_positionController)..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        setState(() {
          hideIcon = true;
        });
        _scale2AnimationController.forward();
      }
    });


    _scale2AnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _scale2Animation = Tween<double>(
      begin: 1.0,
      end: 32.0
    ).animate(_scale2AnimationController)..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: NoteList()));
        // Navigator.of(context).push(MaterialPageRoute(builder: (_) => NoteList() ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimationController,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: Center(
          child: AnimatedBuilder(
            animation: _widthController,
            builder: (context, child) => Container(
               width: _widthAnimation.value,
                height:80.0,
                padding: EdgeInsets.all(8.0),
               
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: buttonColor.withOpacity(.4),
                ),
                child: InkWell(
                  onTap: () => _scaleAnimationController.forward(),
                  child: AnimatedBuilder(
                    animation: _positionController,
                    builder: (context, child) => Align(
                        alignment: Alignment(_positionAnimation.value,0),
                        child: AnimatedBuilder(
                          animation: _scale2AnimationController,
                          builder: (context, child) => Transform.scale(
                            scale: _scale2Animation.value,
                            child: Container(
                              height: 60.0, width: 60.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: buttonColor
                              ),
                              child: hideIcon == false ? Icon(Icons.arrow_forward, color:Colors.white) : Container(),
                            ),
                          )
                          
                          
                        ),
                
                  )
                  ),
                ),
              )
          
          ),
        )
      )
    );
  }
}