!
! This work (Common Community Physics Package), identified by NOAA, NCAR,
! CU/CIRES, is free of known copyright restrictions and is placed in the
! public domain.
!
! THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
! IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
! FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
! THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
! IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
! CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
!

!>
!! @brief Type definitions module.
!!
!! @details The types module provides definitions for
!!          atmospheic driver to call the IPD and
!!          the CCPP.
!
module ccpp_types

    use, intrinsic :: iso_c_binding,                                   &
                      only: c_ptr, c_funptr

    implicit none

    private
    public :: CCPP_STR_LEN,                                            &
              ccpp_t,                                                  &
              ccpp_field_t,                                            &
              ccpp_scheme_t,                                           &
              ccpp_suite_t,                                            &
              ccpp_ipd_t,                                              &
              ccpp_subcycle_t

    !> @var CCPP_STR_LEN Parameter defined for string lengths.
    integer, parameter                          :: CCPP_STR_LEN = 256

    !>
    !! @breif CCPP field type
    !!
    !! The field type contains all the information/meta-data and data
    !! for fields that need to be passed between the atmosphere driver
    !! and the physics drivers.
    type :: ccpp_field_t
            character(len=CCPP_STR_LEN)                       :: standard_name
            character(len=CCPP_STR_LEN)                       :: long_name
            character(len=CCPP_STR_LEN)                       :: units
            integer                                           :: rank
            integer, allocatable, dimension(:)                :: dims
            type(c_ptr)                                       :: ptr
    end type ccpp_field_t

    !>
    !! @breif CCPP scheme type
    !!
    !! The scheme type contains all the scheme information.
    !
    type :: ccpp_scheme_t
            character(:), allocatable                         :: name
            character(:), allocatable                         :: library
            character(:), allocatable                         :: version
            type(c_ptr)                                       :: scheme_hdl
            type(c_ptr)                                       :: library_hdl
    end type ccpp_scheme_t

    !>
    !! @breif CCPP subcycle type
    !!
    !! The subcycle type contains all the scheme names and the number of
    !! times the subcycle will loop. It is a direct mapping to the IPD
    !! suite subcycle XML.
    !
    type :: ccpp_subcycle_t
            integer                                           :: loop
            integer                                           :: schemes_max
            integer                                           :: scheme_n
            type(ccpp_scheme_t), allocatable, dimension(:)    :: schemes
    end type ccpp_subcycle_t

    !>
    !! @breif CCPP IPD type
    !!
    !! The ipd type contains all the subcycles and part number of
    !! the ipd call. It is a direct mapping to the IPD suite ipd 
    !! element in XML.
    !
    type :: ccpp_ipd_t
            integer                                             :: part
            integer                                             :: subcycles_max
            integer                                             :: subcycle_n
            type(ccpp_subcycle_t), allocatable, dimension(:)    :: subcycles
    end type ccpp_ipd_t

    !>
    !! @breif CCPP suite type
    !!
    !! The suite type contains all the ipd parts names and number of
    !! times the subcycle will loop. It is a direct mapping to the
    !! IPD suite subcycle XML.
    !
    type :: ccpp_suite_t
            character(:), allocatable                           :: name
            character(:), allocatable                           :: library
            character(:), allocatable                           :: version
            type(ccpp_scheme_t)                                 :: init
            type(ccpp_scheme_t)                                 :: fini
            integer                                             :: ipds_max
            integer                                             :: ipd_n
            type(ccpp_ipd_t), allocatable, dimension(:)         :: ipds
    end type ccpp_suite_t

    !>
    !! @breif CCPP Atmosphere/IPD/Physics type.
    !!
    !! Generic type that contains all components to run the CCPP.
    !!
    !! - Array of fields to all the atmospheric data needing to go
    !!   the physics drivers.
    !! - The suite definitions in a ccpp_suite_t type.
    !
    type :: ccpp_t
            type(c_ptr)                                         :: fields_idx
            type(ccpp_field_t), allocatable, dimension(:)       :: fields
            type(ccpp_suite_t)                                  :: suite
    end type ccpp_t

end module ccpp_types
