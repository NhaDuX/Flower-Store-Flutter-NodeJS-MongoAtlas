import { Injectable } from '@angular/core';
import { HttpService } from '../../service/http.service';
import { IInvoice } from '../../../models/invoices.model';

@Injectable({
  providedIn: 'root'
})
export class InvoiceService {

  constructor(private http: HttpService) { }
  
  getInvoice() {
    return this.http.get<IInvoice[]>({
      controller: 'Invoice', url: '/getall-invoice'
    })
  }
}
