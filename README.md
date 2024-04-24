# FIFO Testbench README

## Overview
This repository contains a testbench for verifying the functionality of a FIFO design implemented in RTL code. The testbench includes various components such as interface creation, input randomization, coverage points, assertions, and code coverage analysis to ensure thorough verification of the FIFO design.

## Files Included
1. `FIFO.v`: RTL code for the FIFO design.
2. `testbench.sv`: SystemVerilog testbench implementing verification components.
3. `README.md`: This README file providing an overview and instructions.

## Instructions for Use
1. **Setup Environment**: Ensure that you have a SystemVerilog simulator installed and configured.

2. **Clone the Repository**: Clone this repository to your local machine using the following command:
   ```bash
   git clone <repository_url>
   ```

3. **Run Simulation**:
   - Navigate to the repository directory:
     ```bash
     cd <repository_directory>
     ```
   - Compile and run the simulation using your preferred SystemVerilog simulator command:
     ```bash
     <simulator_executable> testbench.sv
     ```

4. **Review Results**:
   - After simulation completes, review the output logs and any generated reports to assess the verification results.
   - Check for any assertion failures, coverage metrics, and functional correctness of the FIFO design.

## Testbench Components
1. **Interface Creation**:
   - Developed an interface using clocking blocks to handle the clock signal for synchronous operations, ensuring proper sampling of input signals and driving of output signals.

2. **Input Randomization**:
   - Randomized the input data for the FIFO according to specified constraints.
   - Generated input data with appropriate ranges and probabilities as outlined in the task.

3. **Assertions**:
   - Assertion 1: Verified the condition that when the Write_enable signal is asserted and the FIFO is not full, the write pointer (write_ptr) should increment.
   - Assertion 2 (Bonus): Added an additional assertion for verifying an important aspect of the FIFO design (explained further in the assertion section).

4. **Coverage Points**:
   - Implemented cover points to ensure 100% coverage of the Full Flag and Empty Flag signals, ensuring comprehensive verification.

5. **Code Coverage**:
   - Performed code coverage analysis to assess the effectiveness of the testbench in exercising the RTL code, ensuring all code paths are adequately covered.

## Additional Information
- For any questions or issues regarding the testbench or verification process, please feel free to [contact the repository owner](mailto:adhamhedia@gmail.com).
- Contributions and feedback are welcome via pull requests and issues in the GitHub repository.

