import { Component, EventEmitter, forwardRef, HostBinding, Input, Output } from '@angular/core';
import { ControlValueAccessor, NG_VALUE_ACCESSOR } from '@angular/forms';
import { uniqueId } from 'lodash';

@Component({
  selector: 'formly-text-area-input',
  templateUrl: './text-area.component.html',
  styleUrls: ['./text-area.component.scss'],
  providers: [{
    provide: NG_VALUE_ACCESSOR,
    useExisting: forwardRef(() => TextAreaComponent),
    multi: true
  }]
})
export class TextAreaComponent implements ControlValueAccessor {
  @HostBinding('class.form-control-host') defaultClass = true;
  uniqueId = uniqueId('textarea-');

  disabled = false;
  @Input() label: string = '';
  @Input() required = false;
  @Input() readonly = false;
  @Input() placeholder = '';
  @Input() height: number = 0;
  @Input() maxlength: number = 0;
  @Input() minlength: number = 0;
  @Input() updateOnBlur = false;
  @Output() keyup: EventEmitter<any> = new EventEmitter<any>();
  value: string = "";
  onChange?: (value: string) => void;

  onTouched?: (fn: any) => void;

  writeValue(value: any): void {
    console.log('here');
    this.value = value;
  }
  registerOnChange(fn: any): void {
    console.log('here');
    this.onChange = fn;
  }
  registerOnTouched(fn: any): void {
    console.log('here');
    this.onTouched = fn;
  }
  setDisabledState(isDisabled: boolean): void {
    this.disabled = isDisabled;
  }

  touched($event:any) {
    if (this.onTouched) {
      // if(this.value) {
      //   this.value = this.value.trim();
      //   this.change();
      // }
      this.onTouched($event);
    }
  }

  onKeyUp($event: KeyboardEvent) {
    this.keyup.emit($event);
    if (this.onTouched) {
      this.onTouched($event);
    }
    if(!this.updateOnBlur && this.onChange && this.value) this.onChange(this.value);
  }

  change() {
    console.log('here');
    
    if(this.onChange) this.onChange(this.value);
  }

}

