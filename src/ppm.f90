module ppm
implicit none

    type color_type
        integer :: r, g, b
    end type

    logical, private :: initialized = .false.
    integer, private :: image_width, image_height
    type(color_type), dimension(:, :), allocatable, private :: image_matrix

    contains

    ! =======================================
    ! Utility Functions

    ! Initialize ppm module
    subroutine ppm_init(width,  height)
        integer, intent(in) :: width, height

        image_height = height
        image_width = width

        if (initialized) then
            deallocate(image_matrix)
        end if

        allocate(image_matrix(height, width))

        initialized = .true.

    end subroutine

    ! Deinitialize ppm module
    subroutine ppm_release()
        deallocate(image_matrix)
        initialized = .false.
    end subroutine ppm_release

    ! Function for rendering image matrix
    subroutine render_image(unit, file_name)
        character, intent(in) :: file_name
        integer, intent(in) :: unit
        integer :: i, j
        type(color_type) :: write_color

        open(unit, file=file_name // ".ppm", status="new")

        write(unit, "(A2)") "P3"
        write(unit, "(I5, X, I5)") image_width, image_height
        write(unit, "(I3)") 255

        do i=1, image_height
            do j=1, image_width
                write_color = image_matrix(i, j)

                write(unit, "(I3, X, I3, X, I3, X)", advance="no") &
                    write_color%r, write_color%g, write_color%b
            end do
        end do

    end subroutine render_image

    ! =======================================

    ! =======================================
    ! Drawing Functions

    ! Function to construct a color
    function color(r, g, b)
        type(color_type) :: color
        integer :: r, g, b

        color%r = r
        color%g = g
        color%b = b
    end function

    function distance(x1, y1, x2, y2)
        integer :: x1, y1, x2, y2
        real :: distance
        distance = sqrt(real((x1 - x2)**2 + (y1 - y2)**2))
    end function

    subroutine point(x, y, point_color)
        integer, intent(in) :: x, y
        type(color_type), intent(in) :: point_color

        image_matrix(y, x) = point_color
    end subroutine point

    subroutine line(x1, y1, x2, y2, line_color)
        integer, intent(in) :: x1, y1, x2, y2
        type(color_type), intent(in) :: line_color
        integer :: x, y, dx, dy

        dx = x2 - x1
        dy = y2 - y1

        do x=x1, x2
            y = y1 + dy * (x - x1) / dx

            image_matrix(y, x) = line_color
        end do
    end subroutine line

    subroutine rect(x, y, width, height, rect_color)
        integer, intent(in) :: x, y, width, height
        type(color_type), intent(in) :: rect_color
        integer :: i

        ! Draw horizontal lines
        do i=x, x+width
            ! Top line
            image_matrix(y, i) = rect_color

            ! Bottom line
            image_matrix(y+height, i) = rect_color
        end do

        ! Draw vertical lines
        do i=y, y+height
            ! Left line
            image_matrix(i, x) = rect_color

            ! Right line
            image_matrix(i, x+width) = rect_color
        end do
        
    end subroutine rect

    ! =======================================
end module ppm