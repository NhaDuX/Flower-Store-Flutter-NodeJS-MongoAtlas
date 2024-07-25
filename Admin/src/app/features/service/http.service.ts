import { HttpClient, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, tap, map } from 'rxjs';
import { IQueryData } from '../../models/http/query.model';

@Injectable({
  providedIn: 'root'
})
export class HttpService {

  constructor(
    private http: HttpClient,
    // private toastSevice: ToastService,
    // private pubSubService: PubsubService
  ) { }

  get<T>(query: IQueryData, id?: string) {
    return this.getDataFromResponse<T> (
      this.http.get<T>(
        `api/${query.controller}${query.url}`,
        { observe: 'response'}
      )
    );
  }

  customUriGet<T>(path: string, query?: IQueryData) {
    return this.getDataFromResponse<T> (
      this.http.get<T>(
        path,
        { observe: 'response'}
      )
    );
  }

  post<T>(query: IQueryData) {
    return this.getDataFromResponse<T> (
      this.http.post<T> (
        `api/${query.controller}${query.url}`,
        query.data,
        { observe: 'response'}
      ),
    );
  }

  put<T>(query: IQueryData) {
    return this.getDataFromResponse<T> (
      this.http.put<T> (
        `api/${query.controller}${query.url}`,
        query.data,
        { observe: 'response'}
      ),
    );
  }

  delete<T>(query: IQueryData) {
    return this.getDataFromResponse<T> (
      this.http.delete<T> (
        `api/${query.controller}${query.url}`,
        { observe: 'response'}
      ),
    );
  }

  customUriPost<T>(path: string, data: any) {
    return this.getDataFromResponse<T> (
      this.http.post<T> (
        path,
        data,
        { observe: 'response'}
      ),
    );
  }


  getDataFromResponse<T>(result$: Observable<HttpResponse<T>>) {
    return result$.pipe(
      map(res => {
        return res.body
      })
    );
  }
}
