package tiendaonline.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import tiendaonline.entities.Categoria;

public interface CategoriaRepository extends JpaRepository<Categoria, Integer> {

}
