import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TextAreaComponent } from './text-area.component';
import { FormsModule } from '@angular/forms';
import { InputTextareaModule } from 'primeng/inputtextarea';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    InputTextareaModule
  ],
  declarations: [
    TextAreaComponent,
  ],
  exports: [TextAreaComponent]
})
export class TextAreaModule { }
