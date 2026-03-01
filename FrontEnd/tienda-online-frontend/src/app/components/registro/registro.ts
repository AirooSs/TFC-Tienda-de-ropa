import { Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';

type ToastType = 'success' | 'error';

@Component({
  selector: 'app-registro',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './registro.html',
  styleUrl: './registro.css'
})
export class RegistroComponent {

  private http = inject(HttpClient);
  private router = inject(Router);

  nombre = '';
  apellidos = '';
  email = '';
  password = '';

  // Toast
  toastVisible = false;
  toastMessage = '';
  toastType: ToastType = 'success';
  private toastTimer?: number;

  private showToast(message: string, type: ToastType = 'success', durationMs = 2500) {
    this.toastMessage = message;
    this.toastType = type;
    this.toastVisible = true;

    if (this.toastTimer) window.clearTimeout(this.toastTimer);

    this.toastTimer = window.setTimeout(() => {
      this.toastVisible = false;
    }, durationMs);
  }

  registrar() {
    const payload = {
      nombreUsuario: `${this.nombre} ${this.apellidos}`.trim(),
      emailUsuario: this.email,
      passwordUsuario: this.password,
      role: 'CLIENTE'
    };

    this.http.post('http://localhost:9008/auth/register', payload)
      .subscribe({
        next: (res: any) => {
          localStorage.setItem('token', res.token);

          this.showToast(' Usuario creado exitosamente', 'success', 2000);

          setTimeout(() => {
            this.router.navigate(['/inicio']);
          }, 1200);
        },
        error: (err) => {
          console.error(err);

          if (err.status === 409) {
            this.showToast(' Ese email ya está registrado', 'error');
          } else if (err.status === 400) {
            this.showToast(' Faltan campos obligatorios', 'error');
          } else {
            this.showToast(' Error al registrar usuario', 'error');
          }
        }
      });
  }

  cerrarToast() {
    this.toastVisible = false;
    if (this.toastTimer) window.clearTimeout(this.toastTimer);
  }
}