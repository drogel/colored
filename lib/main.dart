import 'dart:async';

import 'package:colored/sources/colored.dart';
import 'package:colored/sources/domain/inherited/converter/converter_updater.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/view_models/converter/converter_view_model.dart';
import 'package:colored/sources/presentation/pages/converter.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      Colored(
        home: ConverterUpdater(
          viewModel: ConverterViewModel(
              stateController: StreamController<ConverterState>()),
          child: Converter(),
        ),
      ),
    );
