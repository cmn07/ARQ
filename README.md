# ARQ
Repositório da matéria Arquitetura de Computadores realizada no 3 semestre

---

# 📟 Processador RISC-V Monociclo (RV32I + Extensões Simples)

## Descrição

Este repositório contém a implementação de um **processador RISC-V monociclo**, desenvolvido para fins didáticos. O processador é compatível com o conjunto básico de instruções **RV32I**, com suporte a algumas extensões simples como **instruções de multiplicação (MUL)** e operações de leitura de **byte com sinal (LB)**.

O projeto foi desenvolvido em **SystemVerilog**, durante os laboratórios de Arquitetura de Computadores.

---

## Funcionalidades implementadas

✅ Instruções aritméticas e lógicas:

* `ADD`, `SUB`, `AND`, `OR`, `XOR`, `SLT`
* `ADDI`, `SLLI`

✅ Acesso à memória:

* `LW` (Load Word)
* `SW` (Store Word)
* `LB` (Load Byte, com sign-extend)

✅ Controle de fluxo:

* `BEQ` (Branch if Equal)
* `BNE` (Branch if Not Equal)
* `JAL` (Jump and Link)

✅ Extensões extras:

* `MUL` (Multiplicação de inteiros com sinal)

