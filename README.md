# UART Transmitter-Receiver using Verilog

## Description

This project implements a UART (Universal Asynchronous Receiver Transmitter) system using Verilog HDL. The transmitter sends data serially one bit at a time, and the receiver reconstructs the original data from the received serial stream. The design was simulated and verified using EDA Playground and EPWave.

## Features

* UART Transmitter
* UART Receiver
* Serial data communication
* Start Bit and Stop Bit implementation
* LSB First data transmission
* Waveform verification using EPWave

## Working

1. Data is provided as input (`data_in`).
2. The `tx_start` signal initiates transmission.
3. UART sends a Start Bit (0).
4. Data bits are transmitted serially (LSB first).
5. UART sends a Stop Bit (1).
6. The transmitted data is reconstructed at `data_out`.
7. The received data matches the transmitted data.

## Input Data

10101010 (0xAA)

## Waveform Observation

* `tx_start` acts as the transmission trigger.
* `tx_busy` indicates transmission in progress.
* `tx` carries serial data bits.
* `data_out` gradually reconstructs the transmitted data.
* Final output becomes `AA`, confirming successful data transfer.

## Tools Used

* Verilog HDL
* EDA Playground
* Icarus Verilog
* EPWave

## Files

* `uart.v` : UART Transmitter Receiver module
* `uart_tb.v` : Testbench for simulation
* `uart_waveform.png` : Simulation waveform

* <h2>Waveform</h2>

<img src="https://github.com/SujalPatil1616/UART-Transmitter-Receiver/blob/main/uart_waveform.png" width="900">

## Result

The UART Transmitter-Receiver was successfully simulated and verified. The transmitted data `10101010 (0xAA)` was correctly received and reconstructed at the output.

## Author

**Sujal Patil**
