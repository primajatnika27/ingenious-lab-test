import 'package:flutter/material.dart';

class BlockLoader extends StatelessWidget {
  final String message;

  const BlockLoader({this.message = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const CircularProgressIndicator(),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () {
        return Future<bool>.value(false);
      },
    );
  }
}
