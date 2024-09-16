import 'package:flutter/material.dart';
import 'package:spaa/core/styles/app_colors.dart';
import 'package:spaa/core/styles/app_fonts.dart';

class ModalBottomCustom extends StatelessWidget {
  const ModalBottomCustom({super.key, required this.onRemove});

  final void Function() onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kcardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: 100,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ações',
              style: Theme.of(context)
                  .textTheme
                  .smallText
                  .copyWith(color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // ElevatedButton(
                //   child: Text('Editar',
                //       style: Theme.of(context).textTheme.smallText),
                //   onPressed: () => Navigator.pop(context),
                // ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: onRemove,
                  child: Text('Remover da sala',
                      style: Theme.of(context).textTheme.smallText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
