const palette_start r0
const memory_start r1
const vga_data r2

const NULL r14


movhi palette_start, NULL, 4
movlo palette_start, palette_start, 176

movlo vga_data, NULL, 16


movhi vga_data, vga_data, 41
vgaw memory_start, vga_data, 0

movhi vga_data, vga_data, 42
vgaw memory_start, vga_data, 1

movhi vga_data, vga_data, -1
movlo vga_data, vga_data, -1
vgaw palette_start, vga_data, 0

movhi vga_data, NULL, 0
vgaw palette_start, vga_data, 1