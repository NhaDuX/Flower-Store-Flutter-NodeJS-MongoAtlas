import { Injectable } from '@angular/core';
import { HttpService } from '../../service/http.service';
import { ICategory } from '../../../models/http/category.model';
import { IProduct } from '../../../models/product.model';
import { IComboboxOption } from '../../../models/combobox-option.model';
import { map } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProductService {

  constructor(private httpService: HttpService) { }

  getAllProduct(data: {ids?: string[], cateIds: string[]}) {
    return this.httpService.post<IProduct[]>({
      controller: 'Product',
      url: '/getall-product',
      data
    });
  }

  getAllCategories() {
    return this.httpService.get<ICategory[]>({
      controller: 'Categories', url: '/get-list-category'
    });
  }
  addCategory(data: ICategory) {
    return this.httpService.post({
      controller: 'Categories',
      url: '/add-category',
      data
    });
  }

  getProById(id: string) {
    return this.httpService.get<IProduct>({controller: 'Product', url: `/getbyid-product/${id}`})
  }

  updatePro(product: IProduct) {
    return this.httpService.put<IProduct>({
      controller: 'Product', url: `/update-product/${product._id}`, data: product
    })
  }

  newPro(product: IProduct) {
    return this.httpService.post<IProduct>({
      controller: 'Product', url: `/new-product`, data: product
    })
  }

  deleteCate(id: string) {
    return this.httpService.delete<boolean>({
      controller: 'Categories', url: `/delete-category/${id}`
    })
  }

  deletePro(id: string) {
    return this.httpService.delete<boolean>({
      controller: 'Product', url: `/delete-product/${id}`
    })
  }
}
