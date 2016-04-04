AUTOMAKE_OPTIONS=gnu
INCLUDES = -I$(top_builddir) -I$(top_builddir)/include 
cgidir=$(prefix)/www/cgi-bin
cgi_PROGRAMS = post_fields imlist splist post_fibers segments		\
      download-list dl_request_form spdl_request_form field fieldx	\
      fiber spdownload_list post_coords wholeseg

imlist_SOURCES = $(top_builddir)/include/das_config.h das_config.c	\
      $(top_builddir)/include/segments.h imlist.c			\
      $(top_builddir)/include/segment_table.h segment_table.c		\
      $(top_builddir)/include/checked_link.h checked_link.c		\
      $(top_builddir)/include/file_readable.h file_readable.c		\
      read_segment.c $(top_builddir)/include/segmentlist_table.h	\
      segmentlist_table.c

post_fields_SOURCES = $(top_builddir)/include/das_config.h		\
     das_config.c $(top_builddir)/include/post_utils.h post_utils.c	\
     post_fields.c $(top_builddir)/include/segment_list.h		\
     segment_list.c $(top_builddir)/include/merge_segments.h		\
     merge_segments.c $(top_builddir)/include/segmentlist_table.h	\
     segmentlist_table.c read_segment.c					\
     $(top_builddir)/include/seglist_overlap.h seglist_overlap.c
post_fields_LDADD = @GNULIB_MKDTEMP_OBJ@ @GNULIB_TEMPNAME_OBJ@
post_fields_DEPENDENCIES = @GNULIB_MKDTEMP_OBJ@ @GNULIB_TEMPNAME_OBJ@
EXTRA_post_fields_SOURCES = $(top_builddir)/include/mkdtemp.h mkdtemp.c	\
     $(top_builddir)/include/tempname.h tempname.c

post_fibers_SOURCES = post_fibers.c			\
     $(top_builddir)/include/das_config.h das_config.c	\
     $(top_builddir)/include/post_utils.h post_utils.c
post_fibers_LDADD = @GNULIB_MKDTEMP_OBJ@ @GNULIB_TEMPNAME_OBJ@
post_fibers_DEPENDENCIES = @GNULIB_MKDTEMP_OBJ@ @GNULIB_TEMPNAME_OBJ@
EXTRA_post_fibers_SOURCES = $(top_builddir)/include/mkdtemp.h	\
     mkdtemp.c $(top_builddir)/include/tempname.h tempname.c

post_coords_SOURCES = $(top_builddir)/include/foot_post.h		\
     post_coords.c $(top_builddir)/include/das_config.h das_config.c	\
     $(top_builddir)/include/post_utils.h post_utils.c			\
     $(top_builddir)/include/find_fields.h find_fields.c		\
     $(top_builddir)/include/segment_table.h segment_table.c		\
     read_segment.c $(top_builddir)/include/brittle_fits.h		\
     brittle_fits.c $(top_builddir)/include/checked_link.h		\
     checked_link.c $(top_builddir)/include/file_readable.h		\
     file_readable.c $(top_builddir)/include/coord_xform.h		\
     coord_xform.c $(top_builddir)/include/segmentlist_table.h		\
     segmentlist_table.c $(top_builddir)/include/merge_segments.h	\
     merge_segments.c $(top_builddir)/include/segment_list.h		\
     segment_list.c
post_coords_LDADD = @GNULIB_MKDTEMP_OBJ@ @GNULIB_TEMPNAME_OBJ@
post_coords_DEPENDENCIES = @GNULIB_MKDTEMP_OBJ@ @GNULIB_TEMPNAME_OBJ@
EXTRA_post_coords_SOURCES = $(top_builddir)/include/mkdtemp.h	\
     mkdtemp.c $(top_builddir)/include/tempname.h tempname.c

splist_SOURCES = $(top_builddir)/include/das_config.h das_config.c	\
     $(top_builddir)/include/spectro_post.h splist.c			\
     $(top_builddir)/include/checked_link.h checked_link.c		\
     $(top_builddir)/include/file_readable.h file_readable.c

segments_SOURCES = $(top_builddir)/include/das_config.h das_config.c	\
     $(top_builddir)/include/segments.h segments.c read_segment.c	\
     $(top_builddir)/include/segment_table.h segment_table.c		\
     $(top_builddir)/include/checked_link.h checked_link.c		\
     $(top_builddir)/include/file_readable.h file_readable.c

wholeseg_SOURCES = $(top_builddir)/include/das_config.h das_config.c	\
     wholeseg.c read_segment.c $(top_builddir)/include/segment_table.h	\
     segment_table.c $(top_builddir)/include/checked_link.h		\
     checked_link.c $(top_builddir)/include/file_readable.h		\
     file_readable.c

download_list_SOURCES = $(top_builddir)/include/das_config.h	\
     das_config.c read_segment.c download-list.c

spdownload_list_SOURCES = $(top_builddir)/include/das_config.h	\
     das_config.c spdownload_list.c

dl_request_form_SOURCES = $(top_builddir)/include/das_config.h	\
     das_config.c dl_request_form.c

spdl_request_form_SOURCES = $(top_builddir)/include/das_config.h	\
     das_config.c spdl_request_form.c

field_SOURCES = $(top_builddir)/include/das_config.h das_config.c	\
     field.c $(top_builddir)/include/checked_link.h checked_link.c	\
     $(top_builddir)/include/file_readable.h file_readable.c		\
     $(top_builddir)/include/coord_xform.h coord_xform.c		\
     $(top_builddir)/include/brittle_fits.h brittle_fits.c

fieldx_SOURCES = $(top_builddir)/include/das_config.h das_config.c	\
     fieldx.c $(top_builddir)/include/checked_link.h checked_link.c	\
     $(top_builddir)/include/file_readable.h file_readable.c

fiber_SOURCES = $(top_builddir)/include/das_config.h das_config.c	\
     fiber.c

