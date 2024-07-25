import { CommonModule } from "@angular/common";
import { NgModule } from "@angular/core";
import { CheckBoxModule } from "./checkbox/checkbox.module";
import { DatatimePickerModule } from "./datetime-picker/datatime-picker.module";
import { InputTextModule } from "./input-text/input-text.module";
import { NgSelectItemModule } from "./ng-select/ng-select.module";
import { TextAreaModule } from "./text-area/text-area.module";

@NgModule({
    imports: [
      InputTextModule,
      NgSelectItemModule,
      CheckBoxModule,
      DatatimePickerModule,
      CommonModule,
      TextAreaModule
    ],
    declarations: [
  ]
  })
  export class FormsModule { }