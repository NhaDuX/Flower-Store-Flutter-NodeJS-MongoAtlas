import { Component, OnInit } from '@angular/core';
import { IInvoice } from '../../models/invoices.model';
import { InvoiceService } from './service/invoice.service';
import { first } from 'rxjs';

@Component({
  selector: 'app-invoice',
  templateUrl: './invoice.component.html',
  styleUrl: './invoice.component.scss'
})
export class InvoiceComponent implements OnInit {
  invoices: IInvoice[] = [];

  constructor(private invoiceService: InvoiceService) {}

  ngOnInit(): void {
    this.getInvoices();
  }

  getInvoices() {
    this.invoiceService.getInvoice()
    .pipe(first())
    .subscribe({
      next:(value) => {
        if(value && value.length) {
          this.invoices = value.map(invoice => 
            ({ ...invoice, 
              dateDisplay: invoice.details[0].date, 
              addressDisplay: invoice.details[0].address, 
              totalPrice: invoice.details.reduce((sum, curr) => sum + curr.price, 0) 
            })
          );
        }
      },
    })
  }
}
