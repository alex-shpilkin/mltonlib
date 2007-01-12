/* Copyright (C) 2006 Vesa Karvonen
 *
 * This code is released under the MLton license, a BSD-style license.
 * See the LICENSE file or http://mlton.org/License for details.
 */

ABSTRACT_TYPE(FILE)
ABSTRACT_TYPE(fpos_t)

CONSTANT(BUFSIZ         , size_t)
CONSTANT(EOF            , int)
CONSTANT(FILENAME_MAX   , int)
CONSTANT(FOPEN_MAX      , int)
CONSTANT(L_tmpnam       , int)
CONSTANT(SEEK_CUR       , int)
CONSTANT(SEEK_END       , int)
CONSTANT(SEEK_SET       , int)
CONSTANT(TMP_MAX        , int)
CONSTANT(_IOFBF         , int)
CONSTANT(_IOLBF         , int)
CONSTANT(_IONBF         , int)

PSEUDO_CONSTANT(stderr  , FILE *)
PSEUDO_CONSTANT(stdin   , FILE *)
PSEUDO_CONSTANT(stdout  , FILE *)

FUNCTION(clearerr   , void      , (FILE *stream))
FUNCTION(fclose     , int       , (FILE *stream))
FUNCTION(feof       , int       , (FILE *stream))
FUNCTION(ferror     , int       , (FILE *stream))
FUNCTION(fflush     , int       , (FILE *stream))
FUNCTION(fgetc      , int       , (FILE *stream))
FUNCTION(fgetpos    , int       , (FILE * restrict stream, fpos_t * restrict pos))
FUNCTION(fgets      , char *    , (char * restrict s, int n, FILE * restrict stream))
FUNCTION(fopen      , FILE *    , (const char * restrict filename, const char * restrict mode))
FUNCTION(fputc      , int       , (int c, FILE *stream))
FUNCTION(fputs      , int       , (const char * restrict s, FILE * restrict stream))
FUNCTION(fread      , size_t    , (void * restrict ptr, size_t size, size_t nmemb, FILE * restrict stream))
FUNCTION(freopen    , FILE *    , (const char * restrict filename, const char * restrict mode, FILE * restrict stream))
FUNCTION(fseek      , int       , (FILE *stream, long int offset, int whence))
FUNCTION(fsetpos    , int       , (FILE *stream, const fpos_t *pos))
FUNCTION(ftell      , long      , (FILE *stream))
FUNCTION(fwrite     , size_t    , (const void * restrict ptr, size_t size, size_t nmemb, FILE * restrict stream))
FUNCTION(getc       , int       , (FILE *stream))
FUNCTION(getchar    , int       , (void))
FUNCTION(gets       , char *    , (char *s))
FUNCTION(perror     , void      , (const char *s))
FUNCTION(putc       , int       , (int c, FILE *stream))
FUNCTION(putchar    , int       , (int c))
FUNCTION(puts       , int       , (const char *s))
FUNCTION(remove     , int       , (const char *filename))
FUNCTION(rename     , int       , (const char *old, const char *new))
FUNCTION(rewind     , void      , (FILE *stream))
FUNCTION(setbuf     , void      , (FILE * restrict stream, char * restrict buf))
FUNCTION(setvbuf    , int       , (FILE * restrict stream, char * restrict buf, int mode, size_t size))
FUNCTION(tmpfile    , FILE *    , (void))
FUNCTION(tmpnam     , char *    , (char *s))
FUNCTION(ungetc     , int       , (int c, FILE *stream))

#if 0
FUNCTION(fprintf    , int       , (FILE * restrict stream, const char * restrict format, ...))
FUNCTION(fscanf     , int       , (FILE * restrict stream, const char * restrict format, ...))
FUNCTION(printf     , int       , (const char * restrict format, ...))
FUNCTION(scanf      , int       , (const char * restrict format, ...))
FUNCTION(snprintf   , int       , (char * restrict s, size_t n, const char * restrict format, ...))
FUNCTION(sprintf    , int       , (char * restrict s, const char * restrict format, ...))
FUNCTION(sscanf     , int       , (const char * restrict s, const char * restrict format, ...))
FUNCTION(vfprintf   , int       , (FILE * restrict stream, const char * restrict format, va_list arg))
FUNCTION(vfscanf    , int       , (FILE * restrict stream, const char * restrict format, va_list arg))
FUNCTION(vprintf    , int       , (const char * restrict format, va_list arg))
FUNCTION(vscanf     , int       , (const char * restrict format, va_list arg))
FUNCTION(vsnprintf  , int       , (char * restrict s, size_t n, const char * restrict format, va_list arg))
FUNCTION(vsprintf   , int       , (char * restrict s, const char * restrict format, va_list arg))
FUNCTION(vsscanf    , int       , (const char * restrict s, const char * restrict format, va_list arg))
#endif