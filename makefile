source_files = $(wildcard source/*.v)
output_file = build/spis.vo

rom_data_src = $(wildcard source/*.asm)
rom_data_file = prog.bin

build: $(output_file) $(rom_data_file)

run: $(output_file) $(rom_data_file)
	@vvp $(output_file)

clean:
	rm -r build
	rmdir build
	rm $(rom_data_file)

$(output_file): $(source_files)
	mkdir -p $(dir $(output_file))
	iverilog $(source_files) -o $(output_file) -g2005-sv

$(rom_data_file): $(rom_data_src)
	customasm $(rom_data_src) -o $(rom_data_file) -fbinary
