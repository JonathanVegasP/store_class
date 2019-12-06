import 'package:flutter/material.dart';

class HomeCardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final String image;

  const HomeCardButton({
    Key key,
    this.title,
    this.icon,
    this.onPressed,
    this.backgroundColor = Colors.transparent,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(
        vertical: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backgroundColor,
                ),
                child: image == null
                    ? Icon(
                        icon,
                        color: Colors.white,
                        size: 50,
                      )
                    : Image.asset(
                        image,
                        height: 50,
                        width: 50,
                      ),
              ),
              SizedBox(
                width: 16.0,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
