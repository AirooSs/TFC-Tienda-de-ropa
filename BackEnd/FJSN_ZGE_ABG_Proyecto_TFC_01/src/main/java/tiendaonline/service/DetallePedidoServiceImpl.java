package tiendaonline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tiendaonline.entities.DetallePedido;
import tiendaonline.repository.Detalle_pedidoRepository;

@Service
public class DetallePedidoServiceImpl implements DetallePedidoService {

	@Autowired
	private Detalle_pedidoRepository detalle_pedidoRepository;

	@Override
	public List<DetallePedido> findAll() {

		return detalle_pedidoRepository.findAll();
	}

	@Override
	public DetallePedido findById(Integer id) {

		return detalle_pedidoRepository.findById(id).orElse(null);
	}

	@Override
	public DetallePedido insertOne(DetallePedido detalle) {
		// TODO Auto-generated method stub
		return detalle_pedidoRepository.save(detalle);
	}

	@Override
	public DetallePedido updateOne(DetallePedido detalle) {
		if (detalle_pedidoRepository.existsById(detalle.getId()))
			return detalle_pedidoRepository.save(detalle);
		else
			return null;
	}

	@Override
	public int deleteOne(Integer id) {
		if (detalle_pedidoRepository.existsById(id)) {
			detalle_pedidoRepository.deleteById(id);
			return 1;
		}
		return 0;
	}

}
