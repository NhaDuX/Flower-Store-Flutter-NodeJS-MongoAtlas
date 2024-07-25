import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

export const routes: Routes = [
    {
        path: '',
        redirectTo: '',
        pathMatch: 'full'
      },
      {
        path: '',
        loadChildren: () => import('./features/feature.module').then(m => m.FeatureModule)
      },
];
@NgModule({
    imports: [RouterModule.forRoot(routes, {})],
    exports: [RouterModule]
  })
  export class AppRoutingModule { }