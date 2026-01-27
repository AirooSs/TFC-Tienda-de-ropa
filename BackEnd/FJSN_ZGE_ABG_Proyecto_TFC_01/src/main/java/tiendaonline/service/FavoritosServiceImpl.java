package tiendaonline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public Favoritos findById(Long id) {

		return favoritosRepository.findById(id).orElse(null);
	}

	@Override
	public Favoritos insertOne(Favoritos favoritos) {

		return favoritosRepository.save(favoritos);
	}

	@Override
	public Favoritos updateOne(Favoritos favoritos) {
		if (favoritosRepository.existsById(favoritos.getId_favorito()))
			return favoritosRepository.save(favoritos);
		else
			return null;
	}

	@Override
	public int deleteOne(Long id) {
		if (favoritosRepository.existsById(id)) {
			favoritosRepository.deleteById(id);
			return 1;
		}
		return 0;
	}

}
