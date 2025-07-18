.text
main:
    # ----------------------------------------------------
    # 1. Inicialização e Operações Aritméticas
    # ----------------------------------------------------
    addi x1, x0, 15      # x1 = 15
    addi x2, x0, 5       # x2 = 5
    add x3, x1, x2       # x3 = x1 + x2 = 15 + 5 = 20
    slli x3, x3, 1       # x3 = 20 << 1 = 40 (Shift Left Logical Immediate)

    # ----------------------------------------------------
    # 2. Acesso à Memória (um SW e um LW)
    #    Usamos o endereço 0(x0) ou um endereço baixo fixo.
    #    Lembre-se que seu processador deve ter este endereço mapeado para a memória de dados.
    # ----------------------------------------------------
    sw   x3, 0(x0)       # mem[0x00000000] = x3 (40)
    lw   x5, 0(x0)       # x5 = mem[0x00000000] = 40

    # ----------------------------------------------------
    # 3. Operação para Condição de Branch
    # ----------------------------------------------------
    sub  x6, x5, x2      # x6 = x5 - x2 = 40 - 5 = 35
    addi x7, x0, 35      # x7 = 35

    # ----------------------------------------------------
    # 4. Desvio Condicional (BEQ)
    #    Deve desviar, pois x6 (35) == x7 (35)
    # ----------------------------------------------------
    beq  x6, x7, branch_target # Se x6 == x7, desvia para 'branch_target'

    addi x8, x0, 99      # x8 = 99 (Esta instrução NÃO deve ser executada)

branch_target:
    addi x9, x0, 1       # x9 = 1 (Instrução executada após o desvio)

    # ----------------------------------------------------
    # 5. Loop de Parada para Simulação
    # ----------------------------------------------------
end_loop:
    beq x0, x0, end_loop # Loop infinito para parar a execução do processador