import 'dart:math';

import 'package:application/common/entities/Pair.dart';
import 'package:flutter/material.dart';

class Pairwidget extends StatelessWidget {
  final Pair pair;
  final bool isActive;

  const Pairwidget({super.key, required this.pair, required this.isActive});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),

      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            isActive ? SizedBox(width: 10) : SizedBox(width: 0),

            Container(
              width: 12,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    textAlign: TextAlign.right,
                    pair.pairNum,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: "montserrat",
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      textAlign: TextAlign.start,
                      pair.subjectType,
                      style: TextStyle(
                        
                        height: 1,
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: "montserrat",
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 5),

            Container(
              color: isActive
                  ? theme.cardColor.withAlpha(100)
                  : theme.cardColor,

              width: 5,
            ),

            SizedBox(width: 5),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                  Text(
                    pair.subjectName,
                    style: theme.textTheme.bodyMedium,
                    overflow: TextOverflow.fade,
                  ),

                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              pair.subGroup != ""
                                  ? Text(
                                      pair.subGroup,

                                      style: theme.textTheme.bodySmall,
                                    )
                                  : SizedBox(),

                              Text(pair.time, style: theme.textTheme.bodySmall),

                              Text(
                                pair.roomNum,

                                style: theme.textTheme.bodySmall,

                                overflow: TextOverflow.fade,
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Text(
                            textAlign: TextAlign.right,

                            pair.teacherName,

                            style: theme.textTheme.bodyMedium,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // return Container(
    //   padding: EdgeInsets.symmetric(horizontal: 20),
    //   child: IntrinsicHeight(
    //     child: Row(
    //       mainAxisSize: MainAxisSize.max,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         isActive ? SizedBox(width: 10) : SizedBox(width: 0),
    //         Text(
    //           pair.pairNum,
    //           style: TextStyle(
    //             fontSize: 16,
    //             color: Colors.black,
    //             fontFamily: "montserrat",
    //           ),
    //         ),
    //         const SizedBox(width: 5),
    //         Container(
    //           color: isActive
    //               ? theme.cardColor.withAlpha(100)
    //               : theme.cardColor,
    //           width: 5,
    //         ),

    //         SizedBox(width: 5),
    //         Expanded(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.stretch,
    //             children: [
    //               Text(
    //                 pair.subjectName,
    //                 style: theme.textTheme.bodyMedium,
    //                 overflow: TextOverflow.fade,
    //               ),
    //               Expanded(
    //                 child: Row(
    //                   mainAxisSize: MainAxisSize.max,
    //                   crossAxisAlignment: CrossAxisAlignment.end,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     Expanded(
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.end,
    //                         children: [
    //                           Text(
    //                             textAlign: TextAlign.left,
    //                             pair.teacherName,
    //                             style: theme.textTheme.bodyMedium?.copyWith(
    //                               fontWeight: FontWeight.w500,
    //                               fontSize: 14,
    //                             ),
    //                           ),
    //                           pair.subGroup != ""
    //                               ? Text(
    //                                   pair.subGroup,
    //                                   style: theme.textTheme.bodySmall,
    //                                 )
    //                               : SizedBox(),
    //                         ],
    //                       ),
    //                     ),

    //                     Flexible(
    //                       fit: FlexFit.loose,
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.end,
    //                         children: [
    //                           Text(
    //                             textAlign: TextAlign.end,
    //                             pair.roomNum,
    //                             style: theme.textTheme.bodySmall?.copyWith(
    //                               fontSize: 14,
    //                             ),
    //                             overflow: TextOverflow.fade,
    //                           ),
    //                           Text(pair.time, style: theme.textTheme.bodySmall),
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
