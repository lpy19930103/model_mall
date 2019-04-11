import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
//使用接口OnSkipClickListener回调点击事件
abstract class OnSkipClickListener {
  void onSkipClick();
}
class _DrawProgress extends CustomPainter {
  final Color color;
  final double radius;
  double angle;
  AnimationController animationController;

  Paint circleFillPaint;
  Paint progressPaint;
  Rect rect;

  _DrawProgress(this.color, this.radius,
      {double this.angle, AnimationController this.animationController}) {
    circleFillPaint = new Paint();
    circleFillPaint.color = Colors.white;
    circleFillPaint.style = PaintingStyle.fill;

    progressPaint = new Paint();
    progressPaint.color = color;
    progressPaint.style = PaintingStyle.stroke;
    progressPaint.strokeCap = StrokeCap.round;
    progressPaint.strokeWidth = 4.0;
//    动画使用AnimationController， 他们有start方法，使用forward()方法开启动画
    if (animationController != null && !animationController.isAnimating) {
      animationController.forward();
    }
  }

//  实现绘制进度界面，绘制圆和绘制圆弧。根据传入的angle值来绘制圆弧的大小
  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width / 2;
    double y = size.height / 2;
    Offset center = new Offset(x, y);
    canvas.drawCircle(center, radius - 2, circleFillPaint);
    rect = Rect.fromCircle(center: center, radius: radius);
    angle = angle * (-1);
    double startAngle = -math.pi / 2;
    double sweepAngle = math.pi * angle / 180;
    Path path = new Path();
    path.arcTo(rect, startAngle, sweepAngle, true);
    canvas.drawPath(path, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class SkipDownTimeProgress extends StatefulWidget {
  final Color color;
  final double radius;
  final Duration duration;
  final Size size;
  String skipText;
  OnSkipClickListener clickListener;

  SkipDownTimeProgress(
    this.color,
    this.radius,
    this.duration,
    this.size, {
    Key key,
    String this.skipText = "跳过",
    OnSkipClickListener this.clickListener,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _SkipDownTimeProgressState();
  }
}

class _SkipDownTimeProgressState extends State<SkipDownTimeProgress>
    with TickerProviderStateMixin {
  AnimationController animationController;
  double curAngle = 360.0;

  @override
  void initState() {
    super.initState();
    animationController =
        new AnimationController(vsync: this, duration: widget.duration);
    animationController.addListener(_change);
    _doAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose----------------------');
    animationController.dispose();
  }

  void _onSkipClick() {
    if (widget.clickListener != null) {
      print('skip onclick ---------------');
      widget.clickListener.onSkipClick();
    }
  }

  void _doAnimation() async {
    Future.delayed(new Duration(milliseconds: 50), () {
      if (mounted) {
        animationController.forward().orCancel;
      } else {
        _doAnimation();
      }
    });
  }

  void _change() {
    double ange =
        double.parse(((animationController.value * 360) ~/ 1).toString());

    //新界面的方式, 类似于Android原生的ListView
    //使用Adapter更新界面的原理，即：UI层通过数据来绘制界面，
    //数据改变之后，通知适配器根据新数据重新绘制UI。所以在写代码的时候要牢记 通过修改数据来修改界面。
    //setSate方法就类似于通知适配器重绘的功能
    setState(() {
      curAngle = (360.0 - ange);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _onSkipClick,
      child: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          new CustomPaint(
            painter:
                new _DrawProgress(widget.color, widget.radius, angle: curAngle),
            size: widget.size,
          ),
          Text(
            widget.skipText,
            style: TextStyle(
                color: widget.color,
                fontSize: 13.5,
                decoration: TextDecoration.none),
          ),
        ],
      ),
    );
  }
}


