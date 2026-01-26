package tiendaonline.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import tiendaonline.entities.Favoritos;

public interface FavoritosRepository extends JpaRepository<Favoritos, Long>{

}
