import { Component, Input, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-subcategories',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './subcategories.html',
  styleUrl: './subcategories.css'
})
export class SubcategoriesComponent implements OnInit {
  @Input() categoria: string = '';
  
  subcategoriasData: any = {
    'hombre': ['Camisetas', 'Pantalones', 'Sudaderas', 'Camisas'],
    'mujer': ['Vestidos', 'Suéter', 'Faldas', 'Camisas', 'Pantalones'],
    'junior': ['Chándal', 'Sudaderas']
  };
  
  subcategorias: string[] = [];
  
  ngOnInit() {
    this.actualizarSubcategorias();
  }
  
  ngOnChanges() {
    this.actualizarSubcategorias();
  }
  
  actualizarSubcategorias() {
    const key = this.categoria?.toLowerCase() || '';
    this.subcategorias = this.subcategoriasData[key] || [];
    console.log('Categoría recibida:', this.categoria, 'Subcategorías:', this.subcategorias);
  }
}