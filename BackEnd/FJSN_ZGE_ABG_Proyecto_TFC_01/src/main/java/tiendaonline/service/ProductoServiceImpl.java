package tiendaonline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tiendaonline.entities.Producto;
import tiendaonline.repository.ProductoRepository;

@Service
public class ProductoServiceImpl implements ProductoService {

	@Autowired
	private ProductoRepository productoRepository;

	@Override
	public List<Producto> findAll() {

		return productoRepository.findAll();
	}

	@Override
	public Producto findById(Integer id) {

		return productoRepository.findById(id).orElse(null);
	}

	@Override
	public Producto insertOne(Producto producto) {

		return productoRepository.save(producto);
	}

	@Override
	public Producto updateOne(Producto producto) {
		if (productoRepository.existsById(producto.getIdProducto()))
			return productoRepository.save(producto);
		else
			return null;
	}

	@Override
	public int deleteOne(Integer id) {
		if (productoRepository.existsById(id)) {
			productoRepository.deleteById(id);
			return 1;
		}
		return 0;
	}
	@Override
	public List<Producto> findByCategoriaNombre(String nombreCategoria) {
    	return productoRepository.findByCategoria_NombreCategoriaIgnoreCase(nombreCategoria);
}

}
