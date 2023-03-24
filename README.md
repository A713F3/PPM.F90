# Portable Pixmap (PPM) Module - Fortran
Simple and easy-to-use module to create and modify ppm images.

## Features
- Draw
    - point
    - line (using a naive line-drawing algorithm but going to improve)
    - rectangle

## Basic Examples
### Rectangle Example
```f90
program rect_example
    use ppm

    call ppm_init(20, 20)

    call rect(2, 2, 8, 8, color(255, 0, 0))
    call rect(5, 5, 11, 11, color(255, 255, 255))
    call rect(11, 11, 8, 8, color(0, 255, 0))

    call render_image(1, "output")

    call ppm_release()
end program
```
#### Output (Upscaled):
<img width="180" src="imgs/rect_example.png">

### Point Example

``` f90
program ppm_example
    use ppm

    call ppm_init(3, 3)

    call point(1, 1, color(255, 0, 0))
    call point(2, 2, color(0, 255, 0))
    call point(3, 3, color(0, 0, 255))

    call render_image(1, "output")

    call ppm_release()
end program
```

#### Output (Upscaled): 
<img width="180" src="imgs/example_output.png">

## Build

``` sh
# Compile PPM before for .mod file
gfortran -c ppm.f90

# Compile Project
gfortran -c [FileName].f90
gfortran -o [OutputFile].out [FileName].o ppm.o
```

## List of All Procedures

| Procedure | Description |
| :---      | :---        |
| `ppm_init(width, height)` | Initializes ppm module. |
| `ppm_release()` | Releases all resources that ppm uses. |
| `render_image(unit, file_name)` | Renders the image for the given unit and filename. |
| `color(r, g, b)` | Returns a color. |
| `point(x, y, color)` | Draws a point on the image. |
| `line(x1, y1, x2, y2, color)` | Draws a line between two points. |
| `rect(x, y, w, h, color)` | Draws a rectangle with width and height from a point. |