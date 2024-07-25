import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class InputTextField {
  FormBuilderTextField inputString (
    {
      required String name, 
      required String label,
      List<String? Function(String?)>? validators,
      InputDecoration? decoration,
      String? initValue,
      bool? enabled
    }
  ) {
    return FormBuilderTextField (
      name: name,
      initialValue: initValue,
      enabled: enabled ?? true,
      validator: FormBuilderValidators.compose(validators ?? []),
      decoration: decoration ?? InputDecoration(labelText: label),
    );
  }

  FormBuilderTextField inputEmail (
    {
      required String name, 
      required String label,
      List<String? Function(String?)>? validators,
      InputDecoration? decoration
    }
  ) {
    if(validators != null && !validators.any((validate) => validate == FormBuilderValidators.email())) {
      validators.add(FormBuilderValidators.email());
    }

    return FormBuilderTextField (
      name: name,
      validator: FormBuilderValidators.compose(validators ?? [FormBuilderValidators.email()]),
      decoration: decoration ?? InputDecoration(labelText: label),
    );
  }
}