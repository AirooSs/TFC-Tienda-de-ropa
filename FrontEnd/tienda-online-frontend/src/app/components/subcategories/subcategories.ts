// subcategories.ts
import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-subcategories',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './subcategories.html',
  styleUrl: './subcategories.css'
})
export class SubcategoriesComponent {
  @Input() categoria: string = '';
  
  // cargamos algunas subcategorias
  subcategoriasData: any = {
    'hombre': ['Camisetas', 'Pantalones', 'Sudaderas', 'Camisas'],
    'mujer': ['Vestidos', 'Suéter', 'Faldas', 'Camisas', 'Pantalones'],
    'junior': ['Chándal', 'Sudaderas']
  };
  
  get subcategorias(): string[] {
    return this.subcategoriasData[this.categoria] || [];
  }
}