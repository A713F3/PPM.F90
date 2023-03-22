# PPM Module - Fortran
Simple and easy-to-use module to create and modify ppm images.

## Features
- `point(x, y, color)` - Draws a point on the image.
- More coming soon...

## Basic Example
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

### Output (Upscaled): 
![example_output](imgs/example_output.png)