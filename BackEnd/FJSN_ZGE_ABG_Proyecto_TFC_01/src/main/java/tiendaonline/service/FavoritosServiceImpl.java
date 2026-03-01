package tiendaonline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import jakarta.validation.ConstraintViolationException;
import tiendaonline.entities.Favoritos;
import tiendaonline.repository.FavoritosRepository;

@Service
public class FavoritosServiceImpl implements FavoritosService {

	@Autowired
	private FavoritosRepository favoritosRepository;

	@Override
	public List<Favoritos> findAll() {

		return favoritosRepository.findAll();
	}

	@Override
	public Favoritos findById(Integer id) {

		return favoritosRepository.findById(id).orElse(null);
	}

	
	//Para controlar los duplicados, modificamos el método de la sigiente manera:
	@Override
	public Favoritos insertOne(Favoritos favorito) {
	    try {
	        return favoritosRepository.save(favorito);
	    } catch (DataIntegrityViolationException e) {
	        // Si es por duplicado (unique constraint), lanzamos una excepcion evidentísima! 
	        if (e.getCause() instanceof ConstraintViolationException) {
	            throw new RuntimeException("El producto ya está en favoritos");
	        }
	        throw e;
	    }
	}
	
	
	@Override
	public Favoritos updateOne(Favoritos favoritos) {
		if (favoritosRepository.existsById(favoritos.getIdFavorito()))
			return favoritosRepository.save(favoritos);
		else
			return null;
	}

	@Override
	public int deleteOne(Integer id) {
		if (favoritosRepository.existsById(id)) {
			favoritosRepository.deleteById(id);
			return 1;
		}
		return 0;
	}

	
	
	//Para la  búsqueda de favoritos por ususario
	
	@Override
	public List<Favoritos> findByUsuarioId(Integer idUsuario) {
		return favoritosRepository.findByUsuarioIdUsuario(idUsuario);
	}

	
	
	
	@Override
	public Favoritos findByUsuarioAndProducto(Integer idUsuario, Integer idProducto) {
	    return favoritosRepository.findByUsuarioAndProducto(idUsuario, idProducto);
	}
	
	
}
