package tiendaonline.entities;

import java.io.Serializable;

import jakarta.persistence.Id;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
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
@EqualsAndHashCode(of = "idProducto")
@Builder
@Entity
@Table(name = "productos")

public class Producto implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_producto")
	private Integer idProducto;

	@Column(name = "nombre_producto")
	private String nombreProducto;

	@Column(name = "precio_producto")
	private double precioProducto;

	@Column(name = "stock_producto")
	private int StockProducto;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_cat")
	private Categoria categoria;

}
