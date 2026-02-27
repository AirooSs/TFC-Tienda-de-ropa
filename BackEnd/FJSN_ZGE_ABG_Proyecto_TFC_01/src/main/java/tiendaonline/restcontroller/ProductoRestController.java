package tiendaonline.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestParam;

import tiendaonline.entities.Producto;
import tiendaonline.service.ProductoService;
import java.util.List;

@RestController
@RequestMapping("/productos")
public class ProductoRestController {

	@Autowired
	private ProductoService productoService;

	@GetMapping("/")
	ResponseEntity<?> todos() {
		return ResponseEntity.ok(productoService.findAll());
	}

	@GetMapping("/{id}")
	ResponseEntity<?> uno(@PathVariable Integer id) {
		return ResponseEntity.ok(productoService.findById(id));
	}

	@PostMapping("/")
	ResponseEntity<?> insertOne(@RequestBody Producto producto) {
		return ResponseEntity.ok(productoService.insertOne(producto));
	}

	@PutMapping("/")
	ResponseEntity<?> updateOne(@RequestBody Producto producto) {
		return ResponseEntity.ok(productoService.updateOne(producto));
	}

	@DeleteMapping("/{id}")
	ResponseEntity<?> deleteOne(@PathVariable Integer id) {
		productoService.deleteOne(id);
		return ResponseEntity.noContent().build();
	}

	//Metodo propio
	@GetMapping("/categoria/{nombreCategoria}")
	public List<Producto> productosPorCategoria(@PathVariable String nombreCategoria) {
    	return productoService.findByCategoriaNombre(nombreCategoria);
}
	//Metodo propio
	@GetMapping("/buscar")
    public ResponseEntity<List<Producto>> buscar(
            @RequestParam("nombre") String nombre) {

        return ResponseEntity.ok(
                productoService.findByNombre(nombre)
        );
    }

}
