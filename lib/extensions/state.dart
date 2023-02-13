import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

extension PageContext on State {
  Future<bool> rebuild() async {
    if (!mounted) return false;

    // if there's a current frame,
    if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
      // wait for the end of that frame.
      await SchedulerBinding.instance.endOfFrame;
      if (!mounted) return false;
    }

    // ignore: invalid_use_of_protected_member
    setState(() {});
    return true;
  }
}
