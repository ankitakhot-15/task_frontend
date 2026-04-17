import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Colors.indigo.shade600; // 🔥 professional color

    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: SizedBox(
          height: 80,
          width: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 🔄 Circular Loader
              SizedBox(
                height: 70,
                width: 70,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),

              // 📝 Text inside circle
              Text(
                "Please\nWait",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
