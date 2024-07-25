import { Component } from '@angular/core';
import { FieldType } from '@ngx-formly/core';

@Component({
    selector: 'formly-field-textarea',
    template: `
      <formly-text-area-input
        [label]="props.label ?? ''"
        [required]="props['required'] ?? false" 
        [height]="props['height']" 
        [formlyAttributes]="field"
        [tabindex]="to.tabindex"
        [formControl]="$any(formControl)" 
        [formlyAttributes]="field"
        >
      </formly-text-area-input>
  `,
})
export class FormlyFieldTextArea extends FieldType {
}