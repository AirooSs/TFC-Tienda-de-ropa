import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../environments/environment';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';

export interface LoginRequest {
  // Te dejo ambos formatos para que no te dé 400
  emailUsuario?: string;
  passwordUsuario?: string;
  email?: string;
  password?: string;
}

export interface RegisterRequest {
  // Formato “entidad” (como tu backend)
  nombreUsuario: string;
  emailUsuario: string;
  passwordUsuario: string;
  direccionUsuario?: string | null;
  role?: 'CLIENTE' | 'ADMIN';

  // (por si tu front lo llama con nombres cortos)
  nombre?: string;
  email?: string;
  password?: string;
  direccion?: string | null;
}

export interface AuthResponse {
  nombre: string;
  token: string;
  role: 'CLIENTE' | 'ADMIN';
  email: string;
  idUsuario: number;
}

@Injectable({ providedIn: 'root' })
export class AuthService {
  private http = inject(HttpClient);
  private readonly API = environment.apiUrl;

  private readonly TOKEN_KEY = 'auth_token';
  private readonly ROLE_KEY = 'auth_role';
  private readonly NAME_KEY = 'auth_name';
  private readonly EMAIL_KEY = 'auth_email';
  private readonly ID_KEY = 'auth_idUsuario';


  login(body: LoginRequest): Observable<AuthResponse> {
    const payload = {
      email: body.email ?? body.emailUsuario ?? '',
      password: body.password ?? body.passwordUsuario ?? ''
    };

    return this.http.post<AuthResponse>(`${this.API}/auth/login`, payload).pipe(
      tap((res) => {
        localStorage.setItem(this.TOKEN_KEY, res.token);
        localStorage.setItem(this.ROLE_KEY, res.role);
        localStorage.setItem(this.NAME_KEY, res.nombre);
        localStorage.setItem(this.EMAIL_KEY, res.email);
        localStorage.setItem(this.ID_KEY, String(res.idUsuario));
      })
    );
  }

  register(body: RegisterRequest): Observable<any> {
    const payload = {
      nombreUsuario: body.nombreUsuario ?? body.nombre ?? '',
      emailUsuario: body.emailUsuario ?? body.email ?? '',
      passwordUsuario: body.passwordUsuario ?? body.password ?? '',
      direccionUsuario: body.direccionUsuario ?? body.direccion ?? null,
      role: body.role ?? 'CLIENTE'
    };

    return this.http.post(`${this.API}/auth/register`, payload);
  }

  logout(): void {
    localStorage.removeItem(this.TOKEN_KEY);
    localStorage.removeItem(this.ROLE_KEY);
    localStorage.removeItem(this.NAME_KEY);
    localStorage.removeItem(this.EMAIL_KEY);
    localStorage.removeItem(this.ID_KEY);
  }

  getToken(): string | null {
    return localStorage.getItem(this.TOKEN_KEY);
  }

  getRole(): 'CLIENTE' | 'ADMIN' | null {
    return (localStorage.getItem(this.ROLE_KEY) as any) ?? null;
  }

  getName(): string | null {
    return localStorage.getItem(this.NAME_KEY);
  }

  getEmail(): string | null {
    return localStorage.getItem(this.EMAIL_KEY);
  }

  getIdUsuario(): number | null {
    const v = localStorage.getItem(this.ID_KEY);
    return v ? Number(v) : null;
  }

  isLogged(): boolean {
    return !!this.getToken();
  }

  isAdmin(): boolean {
    return this.getRole() === 'ADMIN';
  }
}