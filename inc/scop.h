#ifndef SCOP_H
# define SCOP_H

# include <glfw3.h>
// # include <GLUT/glut.h>

# include <stdlib.h>
# include "libft.h"


# define WIN_WIDTH			600
# define WIN_HEIGHT			600
# define WIN_TITLE			"SCOP"

# define WIN_RESIZABLE		0

/*
**		glfw_handler.c
*/
int					init_glfw(GLFWwindow **window);
int					clean_glfw(GLFWwindow *window);

#endif
