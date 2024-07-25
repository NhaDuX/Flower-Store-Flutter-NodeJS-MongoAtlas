export interface IProduct {
    _id?: string;
    nameProduct: string;
    price: number;
    quantity: number;
    descrip?: string;
    inclueId?: IProduct[] | string[];
    includeIdForEdit?: string[];
    cateid: string;
    fav?: boolean;
    img?: string;
}