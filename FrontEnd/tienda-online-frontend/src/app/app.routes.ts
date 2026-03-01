import { Routes } from '@angular/router';

export const routes: Routes = [
  { path: '', redirectTo: '/inicio', pathMatch: 'full' },
  { path: 'inicio', loadComponent: () => import('./components/home/home').then(m => m.HomeComponent) },

  //  LOGIN
  { path: 'login', loadComponent: () => import('./components/login/login').then(m => m.LoginComponent) },

  // mientras no tengas perfil, redirige perfil a login:
  { path: 'perfil', redirectTo: '/login', pathMatch: 'full' },

  { path: 'about', loadComponent: () => import('./components/about/about').then(m => m.AboutComponent) },
  { path: 'favoritos', loadComponent: () => import('./components/favorites/favorites').then(m => m.FavoritesComponent) },
  { path: 'carrito', loadComponent: () => import('./components/cart/cart').then(m => m.CartComponent) },
  { path: 'busqueda', loadComponent: () => import('./components/busqueda/busqueda').then(m => m.BusquedaComponent) },
  { path: 'categoria/:tipo', loadComponent: () => import('./components/category/category').then(m => m.CategoryComponent) },
  { path: 'producto/:id', loadComponent: () => import('./components/product-detail/product-detail').then(m => m.ProductDetailComponent) },
  { path: 'categoria/:tipo/:subcategoria', loadComponent: () => import('./components/products/products').then(m => m.ProductsComponent) },
  { path: 'registro', loadComponent: () => import('./components/registro/registro').then(m => m.RegistroComponent) },
  { path: '**', redirectTo: '/inicio' }
];