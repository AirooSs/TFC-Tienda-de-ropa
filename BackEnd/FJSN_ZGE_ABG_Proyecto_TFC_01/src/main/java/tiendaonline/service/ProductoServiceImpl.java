package tiendaonline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tiendaonline.entities.Producto;
import tiendaonline.repository.ProductoRepository;
import tiendaonline.repository.UsuarioRepository;

@Service
public class ProductoServiceImpl implements ProductoService {

    private final UsuarioRepository usuarioRepository;

	@Autowired
	private ProductoRepository productoRepository;

    ProductoServiceImpl(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

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

	//Busca productos por nombre de la categoria
	@Override
	public List<Producto> findByCategoriaNombre(String nombreCategoria) {
    	return productoRepository.findByCategoria_NombreCategoriaIgnoreCase(nombreCategoria);
	}
	
	//Busca productos por nombre del producto
	@Override
    public List<Producto> findByNombre(String nombreProducto) {
        if (nombreProducto == null || nombreProducto.trim().isEmpty()) {
            return List.of();
        }
        return productoRepository.findByNombreProductoContainingIgnoreCase(nombreProducto.trim());
    }

	
	//Filtro necesario de categoria + publico
	
	@Override
	public List<Producto> findByCategoriaYPublico(String nombreCategoria, String nombrePublico) {
		if (nombreCategoria == null || nombrePublico == null) {
			return List.of();
		}
		
		return productoRepository.findByCategoria_NombreCategoriaIgnoreCaseAndPublico_NombrePublicoIgnoreCase(
				nombreCategoria.trim(), 
				nombrePublico.trim()
				);
	}
	//Filtro necesario por tipo de público
	@Override
	public List<Producto> findByPublicoNombre(String nombrePublico) {
		return productoRepository.findByPublico_NombrePublicoIgnoreCase(nombrePublico);

	}
}
