source_files = $(wildcard source/*.v)
output_file = build/spis.vo

build: $(output_file)

run: $(output_file)
	@vvp $(output_file)

clean:
	rm -r build
	rmdir build

$(output_file): $(source_files)
	mkdir -p $(dir $(output_file))
	iverilog $(source_files) -o $(output_file) -g2005-sv
