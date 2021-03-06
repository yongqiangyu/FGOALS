!===============================================================================
! SVN $Id: seq_avdata_mod.F90 18516 2009-09-25 22:54:10Z kauff $
! SVN $URL: https://svn-ccsm-models.cgd.ucar.edu/drv/seq_mct/branch_tags/t3148b_tags/t3148b02_drvseq3_1_48/driver/seq_avdata_mod.F90 $
!===============================================================================
!BOP ===========================================================================
!
! !MODULE: seq_avdata_mod -- provides use access to public cpl7 aVect, domain,
!     and fraction data.
!
! !DESCRIPTION:
!
!    provides use access to public cpl7 aVect, domain, and fraction data.
!
! !REMARKS:
!
!    use access to public cpl7 aVect, domain, and fraction info is to avoid 
!    excessively long routine arg lists, eg. for history & restart modules.
!    Note: while cpl7's non-main program ("driver") routines CAN access this
!    data by use'ing this module, they SHOULD access it via agrument lists 
!    if it is reasonable to do so.  Do the right thing.
!
! !REVISION HISTORY:
!     2009-Sep-25 - B. Kauffman - initial version
!
! !INTERFACE: ------------------------------------------------------------------

module seq_avdata_mod

! !USES:

   use shr_kind_mod  ,only: IN => SHR_KIND_IN
   use mct_mod           ! mct_ wrappers for mct lib

   use seq_cdata_mod     ! "cdata" type & methods (domain + decomp + infodata in one datatype)
   use seq_infodata_mod  ! "infodata" gathers various control flags into one datatype

   implicit none

   public  ! default is public

! !PUBLIC DATA MEMBERS:

   !----------------------------------------------------------------------------
   ! Infodata: inter-model control flags, domain info
   !----------------------------------------------------------------------------

   type (seq_infodata_type) :: infodata ! single instance for cpl and all comps

   !----------------------------------------------------------------------------
   ! cdata types: contains pointers to domain info + component ID + infobuffer
   !----------------------------------------------------------------------------

   type (seq_cdata) :: cdata_aa    ! on component pes
   type (seq_cdata) :: cdata_ll
   type (seq_cdata) :: cdata_oo
   type (seq_cdata) :: cdata_ii
   type (seq_cdata) :: cdata_rr
   type (seq_cdata) :: cdata_gg
   type (seq_cdata) :: cdata_ss

   type (seq_cdata) :: cdata_ax    ! on cpl pes
   type (seq_cdata) :: cdata_lx
   type (seq_cdata) :: cdata_ox
   type (seq_cdata) :: cdata_ix
   type (seq_cdata) :: cdata_rx
   type (seq_cdata) :: cdata_gx
   type (seq_cdata) :: cdata_sx

   !----------------------------------------------------------------------------
   ! domain info: coords, fractions, decomps, area correction factors
   !----------------------------------------------------------------------------

   !--- domain coords, area, mask  (MCT General Grids) --

   type(mct_gGrid) :: dom_aa      ! atm domain on atm pes
   type(mct_gGrid) :: dom_ll      ! lnd domain
   type(mct_gGrid) :: dom_ii      ! ice domain
   type(mct_gGrid) :: dom_oo      ! ocn domain
   type(mct_gGrid) :: dom_rr      ! runoff domain
   type(mct_gGrid) :: dom_gg      ! glc domain
   type(mct_gGrid) :: dom_ss      ! sno domain

   type(mct_gGrid) :: dom_ax      ! atm domain on cpl pes
   type(mct_gGrid) :: dom_lx      ! lnd domain
   type(mct_gGrid) :: dom_ix      ! ice domain
   type(mct_gGrid) :: dom_ox      ! ocn domain
   type(mct_gGrid) :: dom_rx      ! runoff domain
   type(mct_gGrid) :: dom_gx      ! glc domain
   type(mct_gGrid) :: dom_sx      ! sno domain

   !--- domain fractions (only defined on cpl pes) ---

   type(mct_aVect) :: fractions_ax   ! Fractions on atm grid
   type(mct_aVect) :: fractions_lx   ! Fractions on lnd grid 
   type(mct_aVect) :: fractions_ix   ! Fractions on ice grid
   type(mct_aVect) :: fractions_ox   ! Fractions on ocn grid
   type(mct_aVect) :: fractions_gx   ! Fractions on glc grid

   !----------------------------------------------------------------------------
   ! State/flux field bundles (MCT attribute vectors)
   !----------------------------------------------------------------------------

   type(mct_aVect) :: x2a_aa    ! Atm import, atm grid, atm pes - defined in atm gc
   type(mct_aVect) :: a2x_aa    ! Atm export, atm grid, atm pes - defined in atm gc

   type(mct_aVect) :: x2a_ax    ! Atm import, atm grid, cpl pes - defined in map_atmatm
   type(mct_aVect) :: a2x_ax    ! Atm export, atm grid, cpl pes - defined in map_atmatm
   type(mct_aVect) :: a2x_lx    ! Atm export, lnd grid, cpl pes - defined in mrg_x2l
   type(mct_aVect) :: a2x_ix    ! Atm export, ice grid, cpl pes - defined in mrg_x2i
   type(mct_aVect) :: a2x_ox    ! Atm export, ocn grid, cpl pes - defined in mrg_x2o

   type(mct_aVect) :: x2l_ll    ! Lnd import, lnd grid, lnd pes - defined in lnd gc
   type(mct_aVect) :: l2x_ll    ! Lnd export, lnd grid, lnd pes - defined in lnd gc

   type(mct_aVect) :: x2l_lx    ! Lnd import, lnd grid, cpl pes - defined in map_lndlnd
   type(mct_aVect) :: l2x_lx    ! Lnd export, lnd grid, cpl pes - defined in map_lndlnd
   type(mct_aVect) :: l2x_ax    ! Lnd export, atm grid, cpl pes - defined in mrg_x2a

   type(mct_aVect) :: r2x_rr    ! Rof export, rof grid, lnd pes - defined in lnd gc

   type(mct_aVect) :: r2x_rx    ! Rof export, rof grid, cpl pes - defined in map_rofrof
   type(mct_accum) :: r2xacc_rx ! Rof export, rof grid, cpl pes - defined in driver
   type(mct_aVect) :: r2x_ox    ! Rof export, ocn grid, cpl pes - defined in mrg_x2o

   type(mct_aVect) :: x2s_ss    ! Sno import, sno grid, sno pes - defined in lnd gc
   type(mct_aVect) :: s2x_ss    ! Sno export, sno grid, sno pes - defined in lnd gc

   type(mct_aVect) :: x2s_sx    ! Sno import, sno grid, cpl pes - defined in map_snosno
   type(mct_aVect) :: s2x_sx    ! Sno export, sno grid, cpl pes - defined in map_snosno
   type(mct_aVect) :: s2x_gx    ! Sno export, glc grid, cpl pes - defined in mrg_x2g

   type(mct_aVect) :: x2i_ii    ! Ice import, ice grid, ice pes - defined in ice gc
   type(mct_aVect) :: i2x_ii    ! Ice export, ice grid, ice pes - defined in ice gc

   type(mct_aVect) :: x2i_ix    ! Ice import, ice grid, cpl pes - defined in map_iceice
   type(mct_aVect) :: i2x_ix    ! Ice export, ice grid, cpl pes - defined in map_iceice
   type(mct_aVect) :: i2x_ax    ! Ice export, atm grid, cpl pes - defined in mrg_x2a
   type(mct_aVect) :: i2x_ox    ! Ice export, ocn grid, cpl pes - defined in mrg_x2o

   type(mct_aVect) :: x2o_oo    ! Ocn import, ocn grid, ocn pes - defined in ocn gc
   type(mct_aVect) :: o2x_oo    ! Ocn export, ocn grid, ocn pes - defined in ocn gc

   type(mct_aVect) :: x2o_ox    ! Ocn import, ocn grid, cpl pes - defined in map_ocnocn
   type(mct_accum) :: x2oacc_ox ! Ocn import, ocn grid, cpl pes - defined in driver
   type(mct_aVect) :: o2x_ox    ! Ocn export, ocn grid, cpl pes - defined in map_ocnocn
   type(mct_aVect) :: o2x_ax    ! Ocn export, atm grid, cpl pes - defined in mrg_x2a
   type(mct_aVect) :: o2x_ix    ! Ocn export, ice grid, cpl pes - defined in mrg_x2i

   type(mct_aVect) :: xao_ox    ! Atm-ocn fluxes, ocn grid, cpl pes - defined in flux_ao gc 
   type(mct_aVect) :: xao_ax    ! Atm-ocn fluxes, atm grid, cpl pes - defined in flux_ao gc 

   type(mct_aVect) :: x2g_gg    ! Glc import, glc grid, ice pes - defined in glc gc
   type(mct_aVect) :: g2x_gg    ! Glc export, glc grid, ice pes - defined in glc gc

   type(mct_aVect) :: x2g_gx    ! Glc import, glc grid, cpl pes - defined in map_glcglc
   type(mct_aVect) :: g2x_gx    ! Glc export, glc grid, cpl pes - defined in map_glcglc
   type(mct_aVect) :: g2x_sx    ! Glc export, sno grid, cpl pes - defined in mrg_x2s

   integer(IN)     :: r2xacc_rx_cnt ! r2xacc_rx: number of time samples accumulated
   integer(IN)     :: x2oacc_ox_cnt ! x2oacc_ox: number of time samples accumulated

! !PUBLIC MEMBER FUNCTIONS

   ! no public routines

! !PUBLIC TYPES:

   ! no public types

end module seq_avdata_mod

!===============================================================================
