package tiendaonline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tiendaonline.entities.Categoria;
import tiendaonline.repository.CategoriaRepository;

@Service
public class CategoriaServiceImpl implements CategoriaService {

	@Autowired
	private CategoriaRepository categoriaRepository;

	@Override
	public List<Categoria> findAll() {

		return categoriaRepository.findAll();
	}

	@Override
	public Categoria findById(Integer id) {

		return categoriaRepository.findById(id).orElse(null);
	}

	@Override
	public Categoria insertOne(Categoria categoria) {

		return categoriaRepository.save(categoria);
	}

	@Override
	public Categoria updateOne(Categoria categoria) {
		if (categoriaRepository.existsById(categoria.getIdCategoria()))
			return categoriaRepository.save(categoria);
		else
			return null;
	}

	@Override
	public int deleteOne(Integer id) {
		if (categoriaRepository.existsById(id)) {
			categoriaRepository.deleteById(id);
			return 1;
		}
		return 0;
	}
}
