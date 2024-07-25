import { Injectable } from '@angular/core';
import { HttpService } from '../../service/http.service';
import { IAccount } from '../../../models/account.model';

@Injectable({
  providedIn: 'root'
})
export class AccountService {

  constructor(private http: HttpService) { }

  getList() {
    return this.http.get<IAccount[]>({
      controller: 'Accounts', url: '/get-list'
    })
  }

  getAcc(_id: string) {
    return this.http.get<IAccount>({
      controller: 'Accounts', url: `/get-by-id/${_id}`
    })
  }

  save(data: IAccount) {
    return this.http.post<IAccount>({
      controller: 'Accounts', url: `/signup-update`, data
    });
  }

  delete(_id: string) {
    return this.http.delete<boolean>({
      controller: 'Accounts', url: `/delete/${_id}`
    })
  }
}
