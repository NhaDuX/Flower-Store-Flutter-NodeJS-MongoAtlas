import { IAccount } from "./account.model";
import { IProduct } from "./product.model";

export interface IInvoice {
    _id?: string;
    nameInvoice: string
    details: IDetailInvoice[];
    accountId: string;
    account: IAccount;
    dateDisplay?: string;
    addressDisplay?: string;
    totalPrice?: number;
}

export interface IDetailInvoice {
    _id?: string;
    productId: string;
    product: IProduct;
    quantity: number;
    price: number;
    address: string;
    date: string;
}