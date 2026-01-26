package tiendaonline.entities;

import java.io.Serializable;
import java.time.LocalDate;

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
@EqualsAndHashCode(of = "idPedido")
@Builder
@Entity
@Table(name = "pedidos")
public class Pedido implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_pedido")
	private Long idPedido;

	@Column(name = "fecha_pedido")
	private LocalDate fechaPedido;

	@Column(name = "direccion_pedido")
	private String direccionPedido;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario")
	private Usuario usuario;
}
