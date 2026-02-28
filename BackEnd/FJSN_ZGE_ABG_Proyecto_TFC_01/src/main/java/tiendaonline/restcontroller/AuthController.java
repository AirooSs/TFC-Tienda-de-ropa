package tiendaonline.restcontroller;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import tiendaonline.entities.Usuario;
import tiendaonline.repository.UsuarioRepository;
import tiendaonline.security.JwtService;

@RestController
@RequestMapping("/auth")
@CrossOrigin(origins = "http://localhost:4200")
public class AuthController {

    private final UsuarioRepository usuarioRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;

    public AuthController(
            UsuarioRepository usuarioRepository,
            PasswordEncoder passwordEncoder,
            AuthenticationManager authenticationManager,
            JwtService jwtService
    ) {
        this.usuarioRepository = usuarioRepository;
        this.passwordEncoder = passwordEncoder;
        this.authenticationManager = authenticationManager;
        this.jwtService = jwtService;
    }

    // ✅ Register recibiendo Usuario (sin DTOs, Swagger lo entiende perfecto)
    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody Usuario u) {

        if (u.getNombreUsuario() == null || u.getEmailUsuario() == null || u.getPasswordUsuario() == null) {
            return ResponseEntity.badRequest().body(Map.of("error", "Faltan campos"));
        }

        if (usuarioRepository.existsByEmailUsuario(u.getEmailUsuario())) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(Map.of("error", "Email ya registrado"));
        }

        // Por si te lo mandan o viene basura
        u.setIdUsuario(null);

        // Hash password
        u.setPasswordUsuario(passwordEncoder.encode(u.getPasswordUsuario()));

        // Role por defecto
        if (u.getRole() == null || u.getRole().isBlank()) {
            u.setRole("CLIENTE");
        }

        Usuario saved = usuarioRepository.save(u);

        String token = jwtService.generateToken(saved.getEmailUsuario(), saved.getRole());

        return ResponseEntity.status(HttpStatus.CREATED).body(Map.of(
                "token", token,
                "idUsuario", saved.getIdUsuario(),
                "email", saved.getEmailUsuario(),
                "nombre", saved.getNombreUsuario(),
                "role", saved.getRole()
        ));
    }

    // ✅ Login SIN DTOs (recibe email/password en JSON)
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, Object> body) {

        String email = (String) body.get("email");
        String password = (String) body.get("password");

        if (email == null || password == null) {
            return ResponseEntity.badRequest().body(Map.of("error", "Faltan campos"));
        }

        // Esto valida credenciales usando tu UsuarioDetailsService + BCrypt
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(email, password)
        );

        Usuario u = usuarioRepository.findByEmailUsuario(email).orElseThrow();

        String token = jwtService.generateToken(u.getEmailUsuario(), u.getRole());

        return ResponseEntity.ok(Map.of(
                "token", token,
                "idUsuario", u.getIdUsuario(),
                "email", u.getEmailUsuario(),
                "nombre", u.getNombreUsuario(),
                "role", u.getRole()
        ));
    }
}