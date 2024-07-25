import { Component, OnInit } from '@angular/core';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { first } from 'rxjs';
import { ICategory } from '../../models/http/category.model';
import { IProduct } from '../../models/product.model';
import { ProductEditComponent } from './product-edit/product-edit.component';
import { ProductService } from './service/product.service';
import { ConfirmationDialogService } from '../service/confirmation.service';
import { MessageService } from 'primeng/api';

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrl: './product.component.scss'
})
export class ProductComponent implements OnInit {

  products: IProduct[] = [];
  categories: ICategory[] = [
    {
      _id: 'all',
      name: 'All'
    }
  ];
  selectedCate: ICategory | undefined;
  newCate: string = '';
  constructor(private productService: ProductService,
    private modal: NgbModal,
    private confirmDialog: ConfirmationDialogService,
    private toast: MessageService
  ) {}

  ngOnInit(): void {
    this.getProducts();
    this.getCategories();
  }

  getProducts() {
    const cateIds = this.selectedCate && 
    this.selectedCate._id && 
    this.selectedCate._id !== 'all' ? [this.selectedCate._id] : [];
    
    this.productService.getAllProduct({
      cateIds: cateIds
    })
    .pipe(first())
    .subscribe({
      next:(value) => {
        this.products = value && value?.length ? value : [];
      },
    })
  }

  editProduct(id?: string) {
    const modalRef = this.modal.open(ProductEditComponent, {
      size: 'md',
      centered: true,
      backdrop: 'static'
    });
    const instance = <ProductEditComponent>modalRef.componentInstance;
    instance.id = id ?? '';
    instance.title = `${id ? 'Sửa' : 'Thêm'} Sản Phẩm`;

    modalRef.result.then(val => {
      if(val) this.getProducts();
    })
  }

  deletePro(id: string) {
    this.confirmDialog.showConfirmDialog(
      'Bạn có chắc muốn xóa thể loại này?',
      'Xác nhận xóa'
    ).subscribe({
      next:(value) => {
        if(value) {
          this.productService.deletePro(id)
          .pipe(first())
          .subscribe({
            next:(value) => {
              if(value) {
                this.toast.add({ severity: 'success', summary: 'Thành công', detail: 'Xóa thành công' });
                this.getProducts();
              }
            },
          })
        }
      },
    })
  }

  getCategories() {
    this.productService.getAllCategories()
    .pipe(first())
    .subscribe({
      next:(value) => {
        if(value && value.length) {
          this.categories = [{
            _id: 'all',
            name: 'All'
          }]
          this.categories = [...this.categories, ...value];
        }
      },
    })
  }

  cateChange(cate: ICategory) {
    this.selectedCate = {...cate};
    this.getProducts();
  }

  newCategory() {
    if(this.newCate) {
      this.productService.addCategory({name: this.newCate})
      .pipe(first())
      .subscribe({
        next:(value) => {
          if(value) {
            this.getCategories();
          }
        },
      })
    }
  }

  deleteCate(cateId: string) {
    this.confirmDialog.showConfirmDialog(
      'Bạn có chắc muốn xóa thể loại này?',
      'Xác nhận xóa'
    ).subscribe({
      next:(value) => {
        if(value) {
          this.productService.deleteCate(cateId)
          .pipe(first())
          .subscribe({
            next:(value) => {
              if(value) {
                this.toast.add({ severity: 'success', summary: 'Thành công', detail: 'Xóa thành công' });
                this.getCategories();
              }
            },
          })
        }
      },
    })
  }
}