module lnd_comp_esmf

! !USES:

  use ESMF_MOD
  use esmfshr_mod
!
! !PUBLIC TYPES:
  implicit none
  save
  private ! except

!--------------------------------------------------------------------------
! Public interfaces
!--------------------------------------------------------------------------

  public :: lnd_init_esmf
  public :: lnd_run_esmf
  public :: lnd_final_esmf
  public :: lnd_register_esmf

!--------------------------------------------------------------------------
! Private data interfaces
!--------------------------------------------------------------------------

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CONTAINS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
subroutine lnd_register_esmf(comp, rc)
    type(ESMF_GridComp)  :: comp
    integer, intent(out) :: rc

    rc = ESMF_SUCCESS

    print *, "In lnd register routine"
    ! Register the callback routines.

    call ESMF_GridCompSetEntryPoint(comp, ESMF_SETINIT, &
      lnd_init_esmf, phase=ESMF_SINGLEPHASE, rc=rc)
    if (rc /= ESMF_SUCCESS) call ESMF_Finalize(rc=rc, terminationflag=ESMF_ABORT)
    call ESMF_GridCompSetEntryPoint(comp, ESMF_SETRUN, &
      lnd_run_esmf, phase=ESMF_SINGLEPHASE, rc=rc)
    if (rc /= ESMF_SUCCESS) call ESMF_Finalize(rc=rc, terminationflag=ESMF_ABORT)
    call ESMF_GridCompSetEntryPoint(comp, ESMF_SETFINAL, &
      lnd_final_esmf, phase=ESMF_SINGLEPHASE, rc=rc)
    if (rc /= ESMF_SUCCESS) call ESMF_Finalize(rc=rc, terminationflag=ESMF_ABORT)


end subroutine

!===============================================================================

!===============================================================================
!BOP ===========================================================================
!
! !IROUTINE: lnd_init_esmf
!
! !DESCRIPTION:
!     initialize dead lnd model
!
! !REVISION HISTORY:
!
! !INTERFACE: ------------------------------------------------------------------

subroutine lnd_init_esmf(comp, import_state, export_state, EClock, rc)

! !INPUT/OUTPUT PARAMETERS:
   type(ESMF_GridComp)          :: comp
   type(ESMF_State)             :: import_state
   type(ESMF_State)             :: export_state
   type(ESMF_Clock)             :: EClock
   integer, intent(out)         :: rc

   ! Local variables
   character(ESMF_MAXSTR) :: convCIM, purpComp

!EOP

    rc = ESMF_SUCCESS

    ! Set flag to specify dead components
    call ESMF_AttributeSet(export_state, name="lnd_present", value=.false., rc=rc)
    if (rc /= ESMF_SUCCESS) call ESMF_Finalize(rc=rc, terminationflag=ESMF_ABORT)

    call ESMF_AttributeSet(export_state, name="lnd_prognostic", value=.false., rc=rc)
    if (rc /= ESMF_SUCCESS) call ESMF_Finalize(rc=rc, terminationflag=ESMF_ABORT)

    call ESMF_AttributeSet(export_state, name="rof_present", value=.false., rc=rc)
    if (rc /= ESMF_SUCCESS) call ESMF_Finalize(rc=rc, terminationflag=ESMF_ABORT)

    call ESMF_AttributeSet(export_state, name="sno_present", value=.false., rc=rc)
    if (rc /= ESMF_SUCCESS) call ESMF_Finalize(rc=rc, terminationflag=ESMF_ABORT)

    call ESMF_AttributeSet(export_state, name="sno_prognostic", value=.false., rc=rc)
    if (rc /= ESMF_SUCCESS) call ESMF_Finalize(rc=rc, terminationflag=ESMF_ABORT)

    convCIM  = "CIM 1.0"
    purpComp = "Model Component Simulation Description"

    call ESMF_AttributeAdd(comp,  &
                           convention=convCIM, purpose=purpComp, rc=rc)

    call ESMF_AttributeSet(comp, "ShortName", "SLND", &
                           convention=convCIM, purpose=purpComp, rc=rc)
    call ESMF_AttributeSet(comp, "LongName", &
                           "Land Stub Model", &
                           convention=convCIM, purpose=purpComp, rc=rc)
    call ESMF_AttributeSet(comp, "ReleaseDate", "2010", &
                           convention=convCIM, purpose=purpComp, rc=rc)
    call ESMF_AttributeSet(comp, "ModelType", "Land", &
                           convention=convCIM, purpose=purpComp, rc=rc)

    call ESMF_AttributeSet(comp, "Name", "Sam Levis", &
                           convention=convCIM, purpose=purpComp, rc=rc)
    call ESMF_AttributeSet(comp, "EmailAddress", &
                           "slevis@ucar.edu", &
                           convention=convCIM, purpose=purpComp, rc=rc)
    call ESMF_AttributeSet(comp, "ResponsiblePartyRole", "contact", &
                           convention=convCIM, purpose=purpComp, rc=rc)

end subroutine lnd_init_esmf

!===============================================================================
!BOP ===========================================================================
!
! !IROUTINE: lnd_run_esmf
!
! !DESCRIPTION:
!     run method for dead lnd model
!
! !REVISION HISTORY:
!
! !INTERFACE: ------------------------------------------------------------------

subroutine lnd_run_esmf(comp, import_state, export_state, EClock, rc)

! !INPUT/OUTPUT PARAMETERS:
   type(ESMF_GridComp)          :: comp
   type(ESMF_State)             :: import_state
   type(ESMF_State)             :: export_state
   type(ESMF_Clock)             :: EClock
   integer, intent(out)         :: rc


!EOP

   rc = ESMF_SUCCESS

end subroutine lnd_run_esmf

!===============================================================================
!BOP ===========================================================================
!
! !IROUTINE: lnd_final_esmf
!
! !DESCRIPTION:
!     finalize method for dead model
!
! !REVISION HISTORY:
!
! !INTERFACE: ------------------------------------------------------------------

subroutine lnd_final_esmf(comp, import_state, export_state, EClock, rc)

! !INPUT/OUTPUT PARAMETERS:
   type(ESMF_GridComp)          :: comp
   type(ESMF_State)             :: import_state
   type(ESMF_State)             :: export_state
   type(ESMF_Clock)             :: EClock
   integer, intent(out)         :: rc
 

   rc = ESMF_SUCCESS

end subroutine lnd_final_esmf
!===============================================================================

end module lnd_comp_esmf
