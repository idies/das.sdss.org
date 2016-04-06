#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.61)
AC_INIT([sdssdas], [2.2], [neilsen@fnal.gov])
AC_CONFIG_AUX_DIR(config)
AC_CONFIG_SRCDIR([src/field.c])

AM_INIT_AUTOMAKE(sdssdas,2.2)

# Checks for programs.
AC_PROG_CC
AC_LANG_C
AC_PROG_INSTALL

# Checks for libraries.
AC_CHECK_LIB(m,main)

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([assert.h stdio.h sys/stat.h sys/types.h])

# If there is no native mkdtemp, use the gnulib one

AC_CHECK_FUNC(mkdtemp,NATIVE_MKDTEMP=1,NATIVE_MKDTEMP=0)
if test $NATIVE_MKDTEMP -eq 0 ; then
   gl_STDLIB_H
   gl_UNISTD_H
   gl_WCHAR_H
   gl_STDINT_H
   gl_FUNC_GEN_TEMPNAME
   gt_FUNC_MKDTEMP		
   gl_STDLIB_MODULE_INDICATOR([mkdtemp])
   GNULIB_MKDTEMP_OBJ=mkdtemp.o
   AC_SUBST(GNULIB_MKDTEMP_OBJ)
   GNULIB_TEMPNAME_OBJ=tempname.o
   AC_SUBST(GNULIB_TEMPNAME_OBJ)
fi
AM_CONDITIONAL(USE_GNULIB_MKDTEMP, [test $NATIVE_MKDTEMP -eq 0])

# Checks for typedefs, structures, and compiler characteristics.
AC_HEADER_STDBOOL
AC_C_CONST
AC_TYPE_SIZE_T

# Determine where to put the config file
DASCONFIG=$(eval echo $(echo ${sysconfdir}/sdssdas.conf))
if test "$prefix" = NONE ; then
   DASCONFIG=$(echo $DASCONFIG | sed 's%^NONE%/usr/local%g') 
fi
AC_DEFINE_UNQUOTED(DAS_CONFIG_FILE,"${DASCONFIG}","The configuration file for the DAS")

# Checks for library functions.
AC_FUNC_MALLOC

AC_OUTPUT([Makefile include/Makefile src/Makefile html/Makefile test/Makefile test/src/Makefile test/bin/Makefile test/data/Makefile])
