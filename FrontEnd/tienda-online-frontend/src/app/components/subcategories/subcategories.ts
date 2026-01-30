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
    'hombre': ['Camisetas', 'Pantalones', 'Sudaderas', 'Zapatos'],
    'mujer': ['Vestidos', 'Blusas', 'Faldas', 'Zapatos', 'Bolsos'],
    'junior': ['Camisetas', 'Pantalones', 'Sudaderas', 'Zapatos']
  };
  
  get subcategorias(): string[] {
    return this.subcategoriasData[this.categoria] || [];
  }
}