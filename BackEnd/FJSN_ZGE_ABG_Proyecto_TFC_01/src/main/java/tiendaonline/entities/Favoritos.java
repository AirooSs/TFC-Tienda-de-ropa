package tiendaonline.entities;

import java.io.Serializable;

import jakarta.persistence.Id;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@EqualsAndHashCode(of = "producto")
@Builder
@Entity
@Table(name = "favoritos")

public class Favoritos implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id_favorito;
	
	@JoinColumn(name = "id_producto")
	@ManyToOne
	private Producto producto;

	
	@JoinColumn(name = "id_usuario")
	@ManyToOne
	private Usuario usuario;

}
