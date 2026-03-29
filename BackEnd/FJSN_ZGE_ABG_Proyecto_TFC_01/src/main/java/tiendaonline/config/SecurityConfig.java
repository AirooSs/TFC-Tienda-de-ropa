package tiendaonline.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import tiendaonline.security.JwtAuthFilter;

@Configuration
public class SecurityConfig {

    private final JwtAuthFilter jwtAuthFilter;

    public SecurityConfig(JwtAuthFilter jwtAuthFilter) {
        this.jwtAuthFilter = jwtAuthFilter;
    }

    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http
            .csrf(csrf -> csrf.disable())
            .cors(cors -> {})
            .sessionManagement(sm -> sm.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
            .authorizeHttpRequests(auth -> auth

                // Swagger - público
                .requestMatchers(
                    "/v3/api-docs/**",
                    "/swagger-ui/**",
                    "/swagger-ui.html",
                    "/swagger-resources/**",
                    "/webjars/**"
                ).permitAll()

                // Auth
                .requestMatchers("/auth/**").permitAll()

                // Registro público
                .requestMatchers(HttpMethod.POST, "/usuarios").permitAll()

                // CORS preflight
                .requestMatchers(HttpMethod.OPTIONS, "/**").permitAll()

                // PRODUCTOS Y CATEGORÍAS - públicos (GET)
                .requestMatchers(HttpMethod.GET, "/productos/**").permitAll()
                .requestMatchers(HttpMethod.GET, "/categoria/**").permitAll()
                .requestMatchers(HttpMethod.GET, "/productos/categoria/**").permitAll()
                .requestMatchers(HttpMethod.GET, "/productos/buscar/**").permitAll()


                // Solo ADMIN puede modificar productos
                .requestMatchers(HttpMethod.POST, "/productos/**").hasRole("ADMIN")
                .requestMatchers(HttpMethod.PUT, "/productos/**").hasRole("ADMIN")
                .requestMatchers(HttpMethod.DELETE, "/productos/**").hasRole("ADMIN")

                // Ejemplo: pedidos → usuario autenticado
                .requestMatchers("/pedidos/**").hasAnyRole("USER", "ADMIN")

                // Imágenes estáticas - públicas
                .requestMatchers("/static/**", "/img/**", "/images/**").permitAll()

                // Error - público
                .requestMatchers("/error").permitAll()

                // Todo lo demás requiere autenticación
                .anyRequest().authenticated()
            )
            .addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }
}