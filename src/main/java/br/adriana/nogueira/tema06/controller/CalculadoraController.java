package br.adriana.nogueira.tema06.controller;

import br.adriana.nogueira.tema06.exception.InvalidOperationException;
import br.adriana.nogueira.tema06.operations.OperationLog;
import br.adriana.nogueira.tema06.service.CalculadoraService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/calculator")
public class CalculadoraController {

    private final CalculadoraService service;

    @Autowired
    public CalculadoraController(CalculadoraService service) {
        this.service = service;
    }

    @GetMapping("/sum")
    public Double sum(@RequestParam("numberX") Double numberX,
                      @RequestParam("numberY") Double numberY) {
        return service.sum(numberX, numberY);
    }

    @GetMapping("/subtraction")
    public Double subtract(@RequestParam("numberX") Double numberX,
                           @RequestParam("numberY") Double numberY) {
        return service.subtract(numberX, numberY);
    }

    @GetMapping("/multiply")
    public Double multiply(@RequestParam("numberX") Double numberX,
                           @RequestParam("numberY") Double numberY) {
        return service.multiply(numberX, numberY);
    }

    @GetMapping("/divide")
    public Double divide(@RequestParam("numberX") Double numberX,
                         @RequestParam("numberY") Double numberY) throws InvalidOperationException {
        return service.divide(numberX, numberY);
    }

    @GetMapping("/pow")
    public Double pow(@RequestParam("base") Double base,
                      @RequestParam("exponent") Double exponent) {
        return service.pow(base, exponent);
    }

    @GetMapping("/history")
    public OperationLog[] getHistory() {
        return service.getHistory();
    }

    @DeleteMapping("/history/clear")
    public void clearHistory() {
        service.clearHistory();
    }
}