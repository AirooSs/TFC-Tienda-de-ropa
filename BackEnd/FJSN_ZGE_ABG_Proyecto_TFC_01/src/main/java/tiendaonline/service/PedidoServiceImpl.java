package tiendaonline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tiendaonline.entities.Pedido;
import tiendaonline.repository.PedidoRepository;

@Service
public class PedidoServiceImpl implements PedidoService {

	@Autowired
	private PedidoRepository pedidoRepository;

	@Override
	public List<Pedido> findAll() {

		return pedidoRepository.findAll();
	}

	@Override
	public Pedido findById(Long id) {

		return pedidoRepository.findById(id).orElse(null);
	}

	@Override
	public Pedido insertOne(Pedido pedido) {

		return pedidoRepository.save(pedido);
	}

	@Override
	public Pedido updateOne(Pedido pedido) {
		if (pedidoRepository.existsById(pedido.getIdPedido()))
			return pedidoRepository.save(pedido);
		else
			return null;
	}

	@Override
	public int deleteOne(Long id) {
		if (pedidoRepository.existsById(id)) {
			pedidoRepository.deleteById(id);
			return 1;
		}
		return 0;
	}

}
