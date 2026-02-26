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
@EqualsAndHashCode(of = "idCategoria")
@Builder
@Entity
@Table(name = "categorias")
public class Categoria implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="id_cat")
	private Integer idCategoria;
	
	@Column(name="nombre_cat")
	private String nombreCategoria;
	

}
