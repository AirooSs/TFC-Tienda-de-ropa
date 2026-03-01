import { Component, inject, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule,RouterModule],
  templateUrl: './login.html',
  styleUrls: ['./login.css']
})
export class LoginComponent {
  private auth = inject(AuthService);
  private router = inject(Router);

  emailUsuario = '';
  passwordUsuario = '';

  loading = signal(false);
  error = signal<string | null>(null);

  submit() {
    this.error.set(null);
    this.loading.set(true);

    this.auth.login({
      emailUsuario: this.emailUsuario,
      passwordUsuario: this.passwordUsuario
    }).subscribe({
      next: (res) => {
        this.loading.set(false);

        // Redirección según rol que devuelve el backend
        if (res.role === 'ADMIN') {
          this.router.navigateByUrl('/admin');
        } else {
          this.router.navigateByUrl('/');
        }
      },
      error: (e) => {
        this.loading.set(false);
        this.error.set(e?.error?.message ?? 'Login incorrecto');
      }
    });
  }
}