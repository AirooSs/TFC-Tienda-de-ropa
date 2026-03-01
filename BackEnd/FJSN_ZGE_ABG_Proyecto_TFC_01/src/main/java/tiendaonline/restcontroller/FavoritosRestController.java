package tiendaonline.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import tiendaonline.entities.Favoritos;
import tiendaonline.service.FavoritosService;

@RestController
@RequestMapping("/favoritos")
public class FavoritosRestController {

	@Autowired
	private FavoritosService favoritosService;
	
	
	
    // Para obtener los  favoritos por usuario
	
    @GetMapping("/usuario/{idUsuario}")
    public ResponseEntity<List<Favoritos>> favoritosPorUsuario(@PathVariable Integer idUsuario) {
        List<Favoritos> favoritos = favoritosService.findByUsuarioId(idUsuario);
        return ResponseEntity.ok(favoritos);
    }
	
	

	
	
	@GetMapping("/")
	ResponseEntity<?> todos() {
		return ResponseEntity.ok(favoritosService.findAll());
	}

	@GetMapping("/{id}")
	ResponseEntity<?> uno(@PathVariable Integer id) {
		return ResponseEntity.ok(favoritosService.findById(id));
	}

	@PostMapping("/")
	public ResponseEntity<?> insertOne(@RequestBody Favoritos favorito) {
	    try {
	        // Verificar si ya existe
	        Favoritos existente = favoritosService.findByUsuarioAndProducto(
	            favorito.getUsuario().getIdUsuario(),
	            favorito.getProducto().getIdProducto()
	        );
	        
	        if (existente != null) {
	            return ResponseEntity.status(HttpStatus.CONFLICT)
	                .body("El producto ya está en favoritos");
	        }
	        
	        Favoritos nuevo = favoritosService.insertOne(favorito);
	        return ResponseEntity.ok(nuevo);
	        
	    } catch (Exception e) {
	        e.printStackTrace(); // Para ver el error exacto
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	            .body("Error al guardar favorito: " + e.getMessage());
	    }
	}

	@PutMapping("/")
	ResponseEntity<?> updateOne(@RequestBody Favoritos favoritos) {
		return ResponseEntity.ok(favoritosService.updateOne(favoritos));
	}

	@DeleteMapping("/{id}")
	ResponseEntity<?> deleteOne(@PathVariable Integer id) {
		favoritosService.deleteOne(id);
		return ResponseEntity.noContent().build();
	}
}
