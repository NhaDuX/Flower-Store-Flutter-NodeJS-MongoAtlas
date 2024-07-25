import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { RouterModule } from '@angular/router';
import { FormlyModule } from '@ngx-formly/core';
import { BadgeModule } from 'primeng/badge';
import { InputSwitchModule } from 'primeng/inputswitch';
import { InputTextModule } from 'primeng/inputtext';
import { RadioButtonModule } from 'primeng/radiobutton';
import { RippleModule } from 'primeng/ripple';
import { SidebarModule } from 'primeng/sidebar';
import { AppRoutingModule } from './app.routes';
import { TopbarComponent } from './features/shared/topbar/topbar.component';
import { FormlyModule as AppFormlyModule } from './formly/formly.module';
import { ConfirmationService } from 'primeng/api';
import { ConfirmationDialogService } from './features/service/confirmation.service';
import { ConfirmDialogModule } from 'primeng/confirmdialog';


@NgModule({
  declarations: [
    
  ],
  imports: [
    CommonModule,
    AppRoutingModule,
    TopbarComponent,
    BrowserModule,
    FormsModule,
    BrowserAnimationsModule,
    InputTextModule,
    SidebarModule,
    BadgeModule,
    RadioButtonModule,
    InputSwitchModule,
    RippleModule,
    RouterModule,
    AppFormlyModule,
    FormlyModule.forChild({}),
    FormsModule,
    ReactiveFormsModule,
  ],
  bootstrap: [],
  exports: [TopbarComponent],
  providers: [ConfirmationService, ConfirmationDialogService]
})
export class AppModule { }
