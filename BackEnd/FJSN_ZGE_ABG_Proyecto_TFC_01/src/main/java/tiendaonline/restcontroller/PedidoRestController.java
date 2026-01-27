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

import tiendaonline.entities.Pedido;
import tiendaonline.service.PedidoService;

@RestController
@RequestMapping("/pedidos")
public class PedidoRestController {

	@Autowired
	private PedidoService pedidoService;
	
	@GetMapping("/")
	ResponseEntity<?> todos() {
		return ResponseEntity.ok(pedidoService.findAll());
	}

	@GetMapping("/{id}")
	ResponseEntity<?> uno(@PathVariable Long id) {
		return ResponseEntity.ok(pedidoService.findById(id));
	}

	@PostMapping("/")
	ResponseEntity<?> insertOne(@RequestBody Pedido pedido) {
		return ResponseEntity.ok(pedidoService.insertOne(pedido));
	}

	@PutMapping("/")
	ResponseEntity<?> updateOne(@RequestBody Pedido pedido) {
		return ResponseEntity.ok(pedidoService.updateOne(pedido));
	}

	@DeleteMapping("{id}")
	ResponseEntity<?> deleteOne(@PathVariable Long id) {
		pedidoService.deleteOne(id);
		return ResponseEntity.noContent().build();
	}
}
