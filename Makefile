CC					=	clang
NAME				=	scop
FLAGS				=	-Werror -Wextra -Wall

INC					=	./inc
SRC					=	main.c					\
						glfw_handler.c
SRCS				=	$(patsubst %, src/%, $(SRC))
OBJS				=	$(SRCS:src/%.c=obj/%.o)

# necessary files for sfml
BREW				=	/usr/local/bin/brew
BREW_INCLUDE		=	$(BREW)/include

MAKE				=	make
CMAKE				=	cmake

# LIBFT
LIBFT_DIR			=	libft
LIBFT_PATH			=	$(LIBFT_DIR)/libft.a
LIBFT_INC			=	$(LIBFT_DIR)/includes

# GLFW
GLFW_DIR			=	glfw
GLFW_LIB			=	libglfw3.a
GLFW_LIB_DIR		=	$(GLFW_DIR)/src
GLFW_LIB_PATH		=	$(GLFW_LIB_DIR)/$(GLFW_LIB)
GLFW_CMAKELIST		=	$(GLFW_DIR)/CMakeLists.txt
GLFW_INC			=	$(GLFW_DIR)/include/GLFW
GLFW_OPTS			=	# -DGLFW_BUILD_EXAMPLES=OFF -DGLFW_BUILD_TESTS=OFF -DGLFW_BUILD_DOCS=OFF

FRAMEWORKS			=	Cocoa OpenGL IOKit CoreVideo Carbon GLUT
FRAMEWORK_OPTS		=	$(addprefix -framework , $(FRAMEWORKS))

INCLUDES			=	$(INC) $(LIBFT_INC) $(GLFW_INC)
INCLUDE_OPTS		=	$(addprefix -I , $(INCLUDES))

# COLORS
C_NO				=	"\033[00m"
C_OK				=	"\033[35m"
C_GOOD				=	"\033[32m"
C_ERROR				=	"\033[31m"
C_WARN				=	"\033[33m"

# DBG MESSAGE
SUCCESS				=	$(C_GOOD)SUCCESS$(C_NO)
OK					=	$(C_OK)OK$(C_NO)

all: $(NAME)

$(NAME): $(LIBFT_PATH) $(GLFW_LIB_PATH) $(OBJS)
	@$(CC) -o $@ $(OBJS) -L $(GLFW_LIB_DIR) -lglfw3 -L $(LIBFT_DIR) -lft $(FRAMEWORK_OPTS)
	@echo "Compiling" [ $@ ] $(SUCCESS)

obj/%.o: src/%.c obj
	@$(CC) -c -o $@ $< $(INCLUDE_OPTS)
	@echo "Linking" [ $< ] $(OK)

obj:
	@mkdir -p obj

# LIBRARIES

$(LIBFT_PATH):
	@$(MAKE) -C $(LIBFT_DIR)

$(GLFW_LIB_PATH): $(GLFW_CMAKELIST)
	@cd $(GLFW_DIR) && $(CMAKE) $(GLFW_OPTS) . && $(MAKE)

$(GLFW_CMAKELIST):
	@git submodule init
	@git submodule update

clean:
	@rm -f $(OBJS)
	@rm -rf obj
	@echo "Cleaning" [ $(NAME) ] $(OK)

fclean: clean
	@rm -f $(NAME)
	@echo "Delete" [ $(NAME) ] $(OK)

ffclean: fclean
	@$(MAKE) -C $(GLFW_DIR) clean
	@echo "Clean" [ $(GLFW_DIR) ] $(OK)

re: fclean all

.PHONY: all clean fclean re
