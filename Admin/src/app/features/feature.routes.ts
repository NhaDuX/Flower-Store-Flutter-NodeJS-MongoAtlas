import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ProductComponent } from './product/product.component';
import { WelcomePageComponent } from './welcome-page/welcome-page.component';
import { InvoiceComponent } from './invoice/invoice.component';
import { AccountComponent } from './account/account.component';

export const routes: Routes = [
    {
        path: '',
        redirectTo: '',
        pathMatch: 'full'
    },
    {
        path: '',
        component: WelcomePageComponent,   
    },
    {
        path: 'product',
        component: ProductComponent,   
    },
    {
        path: 'bill',
        component: InvoiceComponent,   
    },
    {
        path: 'account',
        component: AccountComponent,   
    },
];
@NgModule({
imports: [RouterModule.forChild(routes)],
exports: [RouterModule]
})
export class FeatureRoutingModule { }