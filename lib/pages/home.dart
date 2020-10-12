import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override

  /// Create widget for Home class
  Widget build(BuildContext context) {

    /// Build simple container
    return Container(

      // Center container
      child: Center(

        // Put text in container
        child: Text(

            'Home',

          // Style text
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600
          )
        )
      )
    );
  }
}
