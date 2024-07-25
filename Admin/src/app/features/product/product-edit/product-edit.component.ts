import { Component, OnInit } from '@angular/core';
import { ProductService } from '../service/product.service';
import { IProduct } from '../../../models/product.model';
import { first } from 'rxjs';
import { FormGroup } from '@angular/forms';
import { FormlyFieldConfig, FormlyFormOptions } from '@ngx-formly/core';
import { ProductDetailFields } from './product-edit.form';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { IComboboxOption } from '../../../models/combobox-option.model';
import { MessageService } from 'primeng/api';

@Component({
  selector: 'app-product-edit',
  templateUrl: './product-edit.component.html',
  styleUrl: './product-edit.component.scss'
})
export class ProductEditComponent implements OnInit {
  id: string = '';
  product: IProduct = {
    nameProduct: '',
    price: 0,
    quantity: 0,
    descrip: '',
    inclueId: [],
    cateid: '',
    fav: false
  };
  fields: FormlyFieldConfig[] = [];
  form = new FormGroup({});
  options: FormlyFormOptions = {
    formState: {
      optionList: {
        categories: [] = [],
        products: [] = []
      }
    }
  };
  title: string = 'Thêm Sản Phẩm'
  constructor(private productService: ProductService, private modal: NgbActiveModal,
    private toast: MessageService
  ) {}

  ngOnInit(): void {
    this.fields = ProductDetailFields();
    this.getCategories();
    this.getPros();
    if(this.id) this.getPro();
  }

  getPro() {
    this.productService.getProById(this.id)
    .pipe(first())
    .subscribe({
      next:(value) => {
        if(value) {
          this.product = {...value, includeIdForEdit: value.inclueId.length ? value.inclueId.map(i => i._id) : [] };
        }
      },
    })
  }

  getPros() {
    this.productService.getAllProduct({cateIds: []})
    .pipe(first())
    .subscribe({
      next:(value) => {
        if(value && value.length) 
          value = value.filter(i => i._id !== this.product._id);
          this.options.formState.optionList.products = 
          value.map(c => ({ label: c.nameProduct, value: c._id } as IComboboxOption));
      },
    })
  }

  getCategories() {
    this.productService.getAllCategories()
    .pipe(first())
    .subscribe({
      next:(value) => {
        if(value && value.length) 
          this.options.formState.optionList.categories = 
          value.map(c => ({ label: c.name, value: c._id } as IComboboxOption));
      },
    })
  }

  submit() {
    this.product.inclueId = this.product.includeIdForEdit;
    const obser$ = this.product._id 
      ? this.productService.updatePro(this.product)
      : this.productService.newPro(this.product);
    obser$
    .pipe(first())
    .subscribe({
      next:(value) => {
        if(value)
        this.modal.close(true);
        this.toast.add({ severity: 'success', summary: 'Thành công', detail: 'Lưu thông tin sản phẩm thành công' });
      },
      error:(err) => {
        this.toast.add({ severity: 'danger', summary: 'Lỗi', detail: 'Lưu thông tin sản phẩm không thành công' });
      },
    })
  }

  close() {
    this.modal.close();
  }
}
