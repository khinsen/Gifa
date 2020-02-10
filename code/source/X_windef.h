/* This include file is used to defined name of C function
  depending on the UNDERSCORE state */


#ifdef UNDERSCORE

#define ARROW_CURSOR_IN_ALL_SHELL arrow_cursor_in_all_shell_
#define WAIT_CURSOR_IN_ALL_SHELL wait_cursor_in_all_shell_
#define MOTIF_INIT motif_init_
#define MOTIF_LOOP motif_loop_
#define WIN_ERASE win_erase_
#define EXECUTE execute_
#define JOURCOMMON jourcommon_
#define WIN_COMMON win_common_
#define WIN_REFRESH win_refresh_
#define CREATE_ZOOMBOX create_zoombox_
#define ZOOMBOX_CLOSE zoombox_close_
#define CREATE_3DBOX create_3dbox_
#define CREAT_TITRE creat_titre_
#define MAKE_SEPARATEUR make_separateur_
#define BUTT_COMM butt_comm_
#define AFF_ALL_TITRE aff_all_titre_
#define SET_ZOOM_PARAM set_zoom_param_
#define SET_ZOOM_COORD set_zoom_coord_
#define SET_SELECT_VAR set_select_var_
#define QUIT_ALL quit_all_
#define CREAT_FORMULAIRE creat_formulaire_
#define MAKE_SEPARATEUR_FORM make_separateur_form_
#define ALIGN_FIELD_FORM align_field_form_
#define CREATE_CHAMPS create_champs_
#define CLOSE_BOX close_box_
#define AFF_FORMULAIRE aff_formulaire_
#define GETVAR getvar_
#define ASSIGN assign_
#define CHECKVAR checkvar_
#define CHECKVAR_F2C checkvar_f2c_
#define F_MSG_OK f_msg_ok_
#define F_MSG_OK_CANCEL f_msg_ok_cancel_
#define F_SAISIE f_saisie_
#define CONTCLEAR contclear_
#define SETVCONTEXT setvcontext_
#define GETVCONTEXT getvcontext_
#define SHIFT_IMAGE shift_image_
#define ZOOM_PARAM_RETURN zoom_param_return_
#define DOREFRESH dorefresh_
#define SET_SCALE set_scale_
#define SET_ZOOM_ZERO set_zoom_zero_
#define RESET_ALL reset_all_
#define WHICH_DIM which_dim_
#define WHICH_VIEW which_view_
#define SET_POINT_XY set_point_xy_
#define SET_LAST_BUTT set_last_butt_
#define RECUP_UNIT recup_unit_
#define UPDATE_LABEL_DIM update_label_dim_
#define CREATE_PHASEBOX create_phasebox_
#define SET_PHASE_VAR set_phase_var_
#define DISPLAY_PIVOT_POINT display_pivot_point_
#define CURRUNIT currunit_
#define CURRUNITR currunitr_
#define GET_VAR_3D get_var_3d_
#define SET_VAR_3D set_var_3d_
#define WIN_SET_POINTER_PATTERN win_set_pointer_pattern_
#define WIN_GET_POINTER_POSITION win_get_pointer_position_
#define WIN_UPDATE win_update_
#define CLOSE_3DBOX close_3dbox_
#define DISPLAY_ICON display_icon_
#define GET_ZOOM_COORD get_zoom_coord_
#define TRACE_CADRE_ICON trace_cadre_icon_
#define WHICH_INT which_int_
#define SET_PDMENU set_pdmenu_
#define SET_NB_ROWS set_nb_rows_
#define SET_AXIS set_axis_
#define UNIT_2_WINCOORD unit_2_wincoord_
#define WIN_WRITE win_write_
#define WIN_PLOT_1D win_plot_1d_
#define GET_CURRUNIT get_currunit_
#define WIN_CONFIG win_config_
#define WIN_OPEN_GENE win_open_gene_
#define WIN_CLOSE win_close_
#define WIN_SNAPSHOT win_snapshot_
#define WIN_FGCOLOR win_fgcolor_
#define WIN_BGCOLOR win_bgcolor_
#define WIN_IMAGE_2D win_image_2d_
#define WIN_SET_WRITING_MODE win_set_writing_mode_
#define WIN_ENABLE_DISPLAY_LIST win_enable_display_list_
#define WIN_PLOT_ARRAY win_plot_array_
#define WIN_GET_BUTTONS win_get_buttons_
#define CREATEFREEZE createfreeze_
#define MONOPOINT monopoint_
#define ZOOM_CATCHCB zoom_catchcb_
#define D_ITOPR d_itopr_
#define D_PTOIR d_ptoir_
#define WIN2INDEXR win2indexr_
#define INDEX2WINR index2winr_
#define SETUP_VIEW setup_view_

#else
#ifdef F2C 

#define ARROW_CURSOR_IN_ALL_SHELL arrow_cursor_in_all_shell__
#define WAIT_CURSOR_IN_ALL_SHELL wait_cursor_in_all_shell__
#define MOTIF_INIT motif_init__
#define MOTIF_LOOP motif_loop__
#define WIN_ERASE win_erase__
#define EXECUTE execute_
#define JOURCOMMON jourcommon_
#define WIN_COMMON win_common__
#define WIN_REFRESH win_refresh__
#define CREATE_ZOOMBOX create_zoombox__
#define ZOOMBOX_CLOSE zoombox_close__
#define CREATE_3DBOX create_3dbox__
#define CREAT_TITRE creat_titre__
#define MAKE_SEPARATEUR make_separateur__
#define BUTT_COMM butt_comm__
#define AFF_ALL_TITRE aff_all_titre__
#define SET_ZOOM_PARAM set_zoom_param__
#define SET_ZOOM_COORD set_zoom_coord__
#define SET_SELECT_VAR set_select_var__
#define QUIT_ALL quit_all__
#define MAKE_SEPARATEUR_FORM make_separateur_form__
#define ALIGN_FIELD_FORM align_field_form__
#define CREATE_CHAMPS create_champs__
#define CLOSE_BOX close_box__
#define AFF_FORMULAIRE aff_formulaire__
#define CREAT_FORMULAIRE creat_formulaire__
#define GETVAR getvar_
#define ASSIGN assign_
#define CHECKVAR checkvar_
#define CHECKVAR_F2C checkvar_f2c__
#define F_MSG_OK f_msg_ok__
#define F_MSG_OK_CANCEL f_msg_ok_cancel__
#define F_SAISIE f_saisie__
#define CONTCLEAR contclear_
#define SETVCONTEXT setvcontext_
#define GETVCONTEXT getvcontext_
#define SHIFT_IMAGE shift_image__
#define ZOOM_PARAM_RETURN zoom_param_return__
#define DOREFRESH dorefresh_
#define SET_SCALE set_scale__
#define SET_ZOOM_ZERO set_zoom_zero__
#define RESET_ALL reset_all__
#define WHICH_DIM which_dim__
#define WHICH_VIEW which_view__
#define SET_POINT_XY set_point_xy__
#define SET_LAST_BUTT set_last_butt__
#define RECUP_UNIT recup_unit__
#define UPDATE_LABEL_DIM update_label_dim__
#define CREATE_PHASEBOX create_phasebox__
#define SET_PHASE_VAR set_phase_var__
#define DISPLAY_PIVOT_POINT display_pivot_point__
#define CURRUNIT currunit_
#define CURRUNITR currunitr_
#define GET_VAR_3D get_var_3d__
#define SET_VAR_3D set_var_3d__
#define WIN_SET_POINTER_PATTERN win_set_pointer_pattern__
#define WIN_GET_POINTER_POSITION win_get_pointer_position__
#define WIN_UPDATE win_update__
#define CLOSE_3DBOX close_3dbox__
#define DISPLAY_ICON display_icon__
#define GET_ZOOM_COORD get_zoom_coord__
#define TRACE_CADRE_ICON trace_cadre_icon__
#define WHICH_INT which_int__
#define SET_PDMENU set_pdmenu__
#define SET_NB_ROWS set_nb_rows__
#define SET_AXIS set_axis__
#define UNIT_2_WINCOORD unit_2_wincoord__
#define WIN_WRITE win_write__
#define WIN_PLOT_1D win_plot_1d__
#define GET_CURRUNIT get_currunit__
#define WIN_CONFIG win_config__
#define WIN_OPEN_GENE win_open_gene__
#define WIN_CLOSE win_close__
#define WIN_SNAPSHOT win_snapshot__
#define WIN_FGCOLOR win_fgcolor__
#define WIN_BGCOLOR win_bgcolor__
#define WIN_IMAGE_2D win_image_2d__
#define WIN_SET_WRITING_MODE win_set_writing_mode__
#define WIN_ENABLE_DISPLAY_LIST win_enable_display_list__
#define WIN_PLOT_ARRAY win_plot_array__
#define WIN_GET_BUTTONS win_get_buttons__
#define CREATEFREEZE createfreeze_
#define MONOPOINT monopoint_
#define ZOOM_CATCHCB zoom_catchcb__
#define D_ITOPR d_itopr__
#define D_PTOIR d_ptoir__
#define WIN2INDEXR win2indexr_
#define INDEX2WINR index2winr_
#define SETUP_VIEW setup_view__

#else

#define ARROW_CURSOR_IN_ALL_SHELL arrow_cursor_in_all_shell
#define WAIT_CURSOR_IN_ALL_SHELL wait_cursor_in_all_shell
#define MOTIF_INIT motif_init
#define MOTIF_LOOP motif_loop
#define WIN_ERASE win_erase
#define EXECUTE execute
#define JOURCOMMON jourcommon
#define WIN_COMMON win_common
#define WIN_REFRESH win_refresh
#define CREAT_TITRE creat_titre
#define MAKE_SEPARATEUR make_separateur
#define CREATE_ZOOMBOX create_zoombox
#define ZOOMBOX_CLOSE zoombox_close
#define CREATE_3DBOX create_3dbox
#define BUTT_COMM butt_comm
#define AFF_ALL_TITRE aff_all_titre
#define SET_ZOOM_PARAM set_zoom_param
#define SET_ZOOM_COORD set_zoom_coord
#define SET_SELECT_VAR set_select_var
#define QUIT_ALL quit_all
#define MAKE_SEPARATEUR_FORM make_separateur_form
#define ALIGN_FIELD_FORM align_field_form
#define CREATE_CHAMPS create_champs
#define CLOSE_BOX close_box
#define AFF_FORMULAIRE aff_formulaire
#define CREAT_FORMULAIRE creat_formulaire
#define GETVAR getvar
#define ASSIGN assign
#define CONTCLEAR contclear
#define CHECKVAR checkvar
#define CHECKVAR_F2C checkvar_f2c
#define F_MSG_OK f_msg_ok
#define F_MSG_OK_CANCEL f_msg_ok_cancel
#define F_SAISIE f_saisie
#define SETVCONTEXT setvcontext
#define GETVCONTEXT getvcontext
#define SHIFT_IMAGE shift_image
#define ZOOM_PARAM_RETURN zoom_param_return
#define DOREFRESH dorefresh
#define SET_SCALE set_scale
#define SET_ZOOM_ZERO set_zoom_zero
#define RESET_ALL reset_all
#define WHICH_DIM which_dim
#define WHICH_VIEW which_view
#define SET_POINT_XY set_point_xy
#define SET_LAST_BUTT set_last_butt
#define RECUP_UNIT recup_unit
#define UPDATE_LABEL_DIM update_label_dim
#define CREATE_PHASEBOX create_phasebox
#define SET_PHASE_VAR set_phase_var
#define DISPLAY_PIVOT_POINT display_pivot_point
#define CURRUNIT currunit
#define CURRUNITR currunitr
#define GET_VAR_3D get_var_3d
#define SET_VAR_3D set_var_3d
#define WIN_SET_POINTER_PATTERN win_set_pointer_pattern
#define WIN_GET_POINTER_POSITION win_get_pointer_position
#define WIN_UPDATE win_update
#define CLOSE_3DBOX close_3dbox
#define DISPLAY_ICON display_icon
#define GET_ZOOM_COORD get_zoom_coord
#define TRACE_CADRE_ICON trace_cadre_icon
#define WHICH_INT which_int
#define SET_PDMENU set_pdmenu
#define SET_NB_ROWS set_nb_rows
#define SET_AXIS set_axis
#define UNIT_2_WINCOORD unit_2_wincoord
#define WIN_WRITE win_write
#define WIN_PLOT_1D win_plot_1d
#define GET_CURRUNIT get_currunit
#define WIN_CONFIG win_config
#define WIN_OPEN_GENE win_open_gene
#define WIN_CLOSE win_close
#define WIN_SNAPSHOT win_snapshot
#define WIN_FGCOLOR win_fgcolor
#define WIN_BGCOLOR win_bgcolor
#define WIN_IMAGE_2D win_image_2d
#define WIN_SET_WRITING_MODE win_set_writing_mode
#define WIN_ENABLE_DISPLAY_LIST win_enable_display_list
#define WIN_PLOT_ARRAY win_plot_array
#define WIN_GET_BUTTONS win_get_buttons
#define CREATEFREEZE createfreeze
#define MONOPOINT monopoint
#define ZOOM_CATCHCB zoom_catchcb
#define D_ITOPR d_itopr
#define D_PTOIR d_ptoir
#define WIN2INDEXR win2indexr
#define INDEX2WINR index2winr
#define SETUP_VIEW setup_view

#endif
#endif


#define APPLY_MASK 01
#define CANCEL_MASK 02
#define OK_MASK 04
#define HELP_MASK 08
#define BLOQ_MASK 16
#define NORMVAR_MASK 32
#define ORIGC_MASK 64

#include "X_sizes.h"

float D_ITOPR(float *index, int *dim, int *axis, int *error);
float D_PTOIR(float *ppm, int *dim, int *axis, int *error);