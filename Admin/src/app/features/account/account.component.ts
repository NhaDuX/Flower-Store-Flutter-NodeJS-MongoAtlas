import { Component, OnInit } from '@angular/core';
import { IAccount } from '../../models/account.model';
import { AccountService } from './service/account.service';
import { first } from 'rxjs';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { MessageService } from 'primeng/api';
import { ConfirmationDialogService } from '../service/confirmation.service';
import { AccountEditComponent } from './account-edit/account-edit.component';

@Component({
  selector: 'app-account',
  templateUrl: './account.component.html',
  styleUrl: './account.component.scss'
})
export class AccountComponent implements OnInit {
  accounts: IAccount[] = [];
  
  constructor(private accountService: AccountService,
    private modal: NgbModal,
    private confirmDialog: ConfirmationDialogService,
    private toast: MessageService) {}
  
  ngOnInit(): void {
    this.getList();
  }
  
  getList() {
    this.accountService.getList()
    .pipe(first())
    .subscribe({
      next:(value) => {
        if(value && value.length) this.accounts = value;
      },
    })
  }

  editAccount(_id?: string) {
    const modalRef = this.modal.open(AccountEditComponent, {
      size: 'md',
      centered: true,
      backdrop: 'static'
    });
    const instance = <AccountEditComponent>modalRef.componentInstance;
    instance.id = _id;

    modalRef.result.then(val => {
      if(val) this.getList();
    })
  }

  deleteAcc(id: string) {
    if(id) {
      this.confirmDialog.showConfirmDialog(
        'Bạn có chắc muốn xóa tài khoản này?',
        'Xác nhận xóa'
      ).subscribe({
        next:(value) => {
          if(value) {
            this.accountService.delete(id)
            .pipe(first())
            .subscribe({
              next:(value) => {
                if(value) {
                  this.getList();
                  this.toast.add({ severity: 'success', summary: 'Thành công', detail: 'Xóa tài khoản thành công' });
                }
              },
              error:(err) => {
                this.toast.add({ severity: 'danger', summary: 'Lỗi', detail: 'Xóa tài khoản không thành công' });
              },
            })
          }
        },
      })
    }
  }
    
}
