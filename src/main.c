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

void init(void)
{
   glClearColor(0.0, 0.0, 0.2, 0.0);
   glShadeModel(GL_SMOOTH);
   glViewport(0,0,screen_width,screen_height);
   glMatrixMode(GL_PROJECTION);
   glLoadIdentity();
   gluPerspective(45.0f,(GLfloat)screen_width/(GLfloat)screen_height,1.0f,1000.0f);
   glEnable(GL_DEPTH_TEST);
   glPolygonMode (GL_FRONT_AND_BACK, GL_FILL);
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
