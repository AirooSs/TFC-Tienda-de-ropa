package tiendaonline.entities;

import java.io.Serializable;

import jakarta.persistence.Id;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
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
	private Long idUsuario;

	@Column(name = "nombre_usuario")
	private String nombreUsuario;

	@Column(name = "email_usuario")
	private String emailUsuario;

	@Column(name = "direccion_usuario")
	private String direccionUsuario;

}
