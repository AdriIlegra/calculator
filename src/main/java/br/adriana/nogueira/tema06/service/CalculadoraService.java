package br.adriana.nogueira.tema06.service;

import br.adriana.nogueira.tema06.exception.InvalidOperationException;
import br.adriana.nogueira.tema06.operations.OperationLog;
import br.adriana.nogueira.tema06.operations.OperationType;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CalculadoraService {


    private final List<OperationLog> history;

    public CalculadoraService() {
        this.history = new ArrayList<>();
    }

    public Double sum(Double numberX, Double numberY) {
        Double result = numberX + numberY;
        logOperation(numberX, numberY, OperationType.SUM, result);
        return result;
    }

    public Double subtract(Double numberX, Double numberY) {
        Double result = numberX - numberY;
        logOperation(numberX, numberY, OperationType.SUBTRACT, result);
        return result;
    }

    public Double multiply(Double numberX, Double numberY) {
        Double result = numberX * numberY;
        logOperation(numberX, numberY, OperationType.MULTIPLY, result);
        return result;
    }

    public Double divide(Double numberX, Double numberY) throws InvalidOperationException {
        if (numberY == 0) {
            throw new InvalidOperationException("Cannot divide by zero");
        }
        Double result = numberX / numberY;
        logOperation(numberX, numberY, OperationType.DIVIDE, result);
        return result;
    }

    public Double pow(Double base, Double exponent) {
        Double result = Math.pow(base, exponent);
        logOperation(base, exponent, OperationType.POW, result);
        return result;
    }

    public OperationLog[] getHistory() {
        return history.toArray(new OperationLog[0]);
    }


    public void clearHistory() {
        history.clear();
    }

    private void logOperation(Double numberX, Double numberY, OperationType operation, Double result) {
        OperationLog log = new OperationLog(numberX, numberY, operation, result);
        history.add(log);
    }
}
