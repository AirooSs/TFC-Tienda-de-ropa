package tiendaonline.service;

import java.util.List;

import tiendaonline.entities.DetallePedido;



public interface DetallePedidoService {

	//CRUD BASICO
	
		List<DetallePedido> findAll();

		DetallePedido findById(Long id);

		DetallePedido insertOne(DetallePedido detalle);

		DetallePedido updateOne(DetallePedido detalle);

		int deleteOne(Long id);
}
