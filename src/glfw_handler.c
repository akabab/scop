#include "scop.h"

static void			error_callback(int error, const char *description)
{
	(void)error;
	ft_putstr_fd(description, 2);
}

static void			key_callback(
	GLFWwindow *window, int key, int scancode, int action, int mods)
{
	(void)scancode;
	(void)mods;
	if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS)
		glfwSetWindowShouldClose(window, GL_TRUE);
}

static void			window_size_callback(
	GLFWwindow *window, int width, int height)
{
	(void)window;
	(void)width;
	(void)height;
	return ;
}

int					clean_glfw(GLFWwindow *window)
{
	glfwDestroyWindow(window);
	glfwTerminate();
	return (1);
}

int					init_glfw(GLFWwindow **window)
{
	glfwSetErrorCallback(error_callback);
	if (!glfwInit())
		exit(EXIT_FAILURE);
	if (!WIN_RESIZABLE)
		glfwWindowHint(GLFW_RESIZABLE, GL_FALSE);
	*window = glfwCreateWindow(WIN_WIDTH, WIN_HEIGHT, WIN_TITLE, NULL, NULL);
	if (!*window)
	{
		glfwTerminate();
		exit(EXIT_FAILURE);
	}
	glfwSetWindowSizeCallback(*window, window_size_callback);
	glfwMakeContextCurrent(*window);
	glfwSwapInterval(1);
	glfwSetKeyCallback(*window, key_callback);
	return (1);
}
