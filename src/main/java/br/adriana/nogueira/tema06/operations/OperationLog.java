package br.adriana.nogueira.tema06.operations;

public class OperationLog {
    private Double numberX;
    private Double numberY;
    private OperationType operation;
    private Double result;

    public OperationLog(Double numberX, Double numberY, OperationType operation, Double result) {
        this.numberX = numberX;
        this.numberY = numberY;
        this.operation = operation;
        this.result = result;
    }

    public Double getNumberX() {
        return numberX;
    }

    public Double getNumberY() {
        return numberY;
    }

    public OperationType getOperation() {
        return operation;
    }


    public Double getResult() {
        return result;
    }

    @Override
    public String toString() {
        return "OperationLog{" +
                "numberX=" + numberX +
                ", numberY=" + numberY +
                ", operation=" + operation +
                ", result=" + result +
                '}';
    }

}