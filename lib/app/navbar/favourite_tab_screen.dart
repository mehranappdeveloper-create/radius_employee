import 'package:flutter/cupertino.dart';
import '../app_colors/app_colors.dart';

class FavouriteTabScreen extends StatelessWidget {
  const FavouriteTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.background,
        child: Center(
          child: Text(
            "Favourite Screen",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}