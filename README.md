# toy_robot_2020
Toy Robot Code Challenge

---
### Setup
To setup, ensure you have Ruby 2.7.0, clone this repository and then run

    bundle install

### Play
To run with regular inputs

    ruby bin/robot_cli.rb <input_file> <input:optional> <output:optional> <output_file:optional>

For very large input file with lots of commands

    ruby bin/robot_cli_large_file.rb <input_file>

input should be either:
- `IOHandlers::FileInput` (default),
- `IOHandlers::JsonInput`,
- `IOHandlers::StdInput` (enter `DONE` after the last command)

output is (only one option for now) `IOHandlers::GenericOutput`

output_file is `full/path/to/text_file`

### Command file format
Contents of the file should be in the format of

    Name: Command <Args>

Accepted actions are

| Command | Arguments    | Action taken |
|---------|--------------|--------------|
|PLACE    | X,Y,DIRECTION | Places robot on coordinates X, Y, Facing DIRECTION|
|MOVE     |  | Moves Robot 1 square forward in DIRECTION |
|LEFT     |  | Rotates Robot 90 degrees anti-clockwise |
|RIGHT    |  | Rotates Robot 90 degrees clockwise |
|REPORT   |  | Reports Robot position as a string X,Y,DIRECTION|

Accepted arguments for the PLACE command are
- `X` between `0` and `4`
- `Y` between `0` and `4`
- `DIRECTIONS` are either `NORTH`, `EAST`, `SOUTH` or `WEST`

### Sample
Below is the content of a sample file (found in `./spec/data/03_more_steps_and_one_rotate.txt`)

    PLACE 1,2,EAST
    MOVE
    MOVE
    LEFT
    MOVE
    REPORT

And the output will be

    3,3,NORTH

More sample command files are in the `./spec/data` directory

### Tests
To run tests

    bundle exec rspec
