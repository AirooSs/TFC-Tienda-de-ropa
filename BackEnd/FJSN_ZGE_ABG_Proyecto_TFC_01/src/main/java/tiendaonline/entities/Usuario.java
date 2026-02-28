package tiendaonline.entities;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@EqualsAndHashCode(of = "idUsuario")
@Builder
@Entity
@Table(name = "usuarios")
public class Usuario implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_usuario")
	private Integer idUsuario;

	@Column(name = "nombre_usuario", nullable = false)
	private String nombreUsuario;

	@Column(name = "email_usuario", nullable = false, unique = true)
	private String emailUsuario;

	@Column(name = "password_usuario", nullable = false)
	private String passwordUsuario;

	@Column(name = "direccion_usuario")
	private String direccionUsuario;

	@Column(name = "role", nullable = false)
	private String role; // CLIENTE o ADMIN
}