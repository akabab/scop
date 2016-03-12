#include "scop.h"

void			reset_viewport(GLFWwindow *window)
{
	float	ratio;
	int		width;
	int		height;

	glfwGetFramebufferSize(window, &width, &height);
	ratio = width / (float)height;
	glViewport(0, 0, width, height);
	glClear(GL_COLOR_BUFFER_BIT);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrtho(-ratio, ratio, -1.f, 1.f, 1.f, -1.f);
}

void			free_all(void)
{
}

static void		render()
{
	// GLUquadric* params = gluNewQuadric();
	// gluQuadricDrawStyle(params, GLU_FILL);
	// gluSphere(params,0.15,1000,1000);
	// gluDeleteQuadric(params);
}

int				main(int ac, char *av[])
{
	GLFWwindow	*window;

	init_glfw(&window);
	while (!glfwWindowShouldClose(window))
	{
		reset_viewport(window);
		glMatrixMode(GL_MODELVIEW);
		render();
		glfwSwapBuffers(window);
		glfwPollEvents();
	}
	clean_glfw(window);
	free_all();
	return (0);
}
