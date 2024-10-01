import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String btnText;
  final ContextCallback onPressed;
  CustomButton({required this.btnText,required this.onPressed});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: ElevatedButton(
          onPressed: (){
            _onHover(true);
            _isHovered ? Colors.black : Color(0xFF4DB6AC);
            widget.onPressed(context);
          },
          style: ElevatedButton.styleFrom(
            fixedSize: Size(260, 50),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            primary: _isHovered ? Colors.black : Color(0xFF4DB6AC),
          ),
          child: Text(
            widget.btnText,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}
typedef ContextCallback = void Function(BuildContext);