import { Component, OnInit } from '@angular/core';
import { AccountService } from '../service/account.service';
import { first } from 'rxjs';
import { IAccount } from '../../../models/account.model';
import { FormGroup } from '@angular/forms';
import { FormlyFieldConfig, FormlyFormOptions } from '@ngx-formly/core';
import { AccountDetailFields } from './account-edit.form';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { MessageService } from 'primeng/api';

@Component({
  selector: 'app-account-edit',
  templateUrl: './account-edit.component.html',
  styleUrl: './account-edit.component.scss'
})
export class AccountEditComponent implements OnInit {
  id: string = '';
  account: IAccount = {
    name: '',
    email: '',
    password: ''
  };
  fields: FormlyFieldConfig[] = [];
  form = new FormGroup({});
  options: FormlyFormOptions = {
    formState: {
      optionList: {
      },
      editMode: false
    }
  };
  title: string = 'Thêm Tài Khoản';
  constructor(private accountService: AccountService, private modal: NgbActiveModal,
    private toast: MessageService
  ) {}

  ngOnInit(): void {
    if(this.id) {
      this.getAccount();
      this.title = 'Sửa Tài Khoản';
      this.options.formState.editMode = true;
    }
    this.fields = AccountDetailFields();
  }

  getAccount() {
    this.accountService.getAcc(this.id)
    .pipe(first())
    .subscribe({
      next:(value) => {
        if(value) this.account = value;
        
      },
    })
  }

  submit() {
    this.accountService.save(this.account)
    .pipe(first())
    .subscribe({
      next:(value) => {
        if(value) {
          this.toast.add({ severity: 'success', summary: 'Thành công', detail: 'Lưu tài khoản thành công' });
          this.modal.close(true);
        }
      },
      error:(err) => {
        this.toast.add({ severity: 'danger', summary: 'Lỗi', detail: 'Lưu tài khoản không thành công' });
      },
    })
  }

  close() {
    this.modal.close();
  }
}
