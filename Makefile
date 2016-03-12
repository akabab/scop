CC					=	clang
NAME				=	scop
FLAGS				=	-Werror -Wextra -Wall

INC					=	./inc
SRC					=	main.c
SRCS				=	$(patsubst %, src/%, $(SRC))
OBJS				=	$(SRCS:src/%.c=obj/%.o)

# necessary files for sfml
BREW				=	/usr/local/bin/brew
BREW_INCLUDE		=	$(BREW)/include

MAKE				=	make
CMAKE				=	cmake

# GLFW
GLFW_LIB_DIR		=	glfw
GLFW_LIB			=	libglfw3.a
GLFW_LIB_PATH		=	$(GLFW_LIB_DIR)/src/$(GLFW_LIB)
GLFW_CMAKELIST		=	$(GLFW_LIB_DIR)/CMakeLists.txt

FRAMEWORKS			=	Cocoa OpenGL IOKit CoreVideo GLUT
FRAMEWORK_OPTS		=	$(addprefix -framework , $(FRAMEWORKS))

INCLUDES			=	$(INC) $(GLFW_LIB_DIR)/include/GLFW
INCLUDE_OPTS		=	$(addprefix -I , $(INCLUDES))	

# COLORS
C_NO			=	"\033[00m"
C_OK			=	"\033[35m"
C_GOOD			=	"\033[32m"
C_ERROR			=	"\033[31m"
C_WARN			=	"\033[33m"

# DBG MESSAGE
SUCCESS			=	$(C_GOOD)SUCCESS$(C_NO)
OK				=	$(C_OK)OK$(C_NO)

all: $(NAME)

$(NAME): $(OBJS) $(GLFW_LIB_PATH)  
	@$(CC) -o $@ $(OBJS) $(INCLUDE_OPTS) -L $(GLFW_LIB_DIR)/src -lglfw3 $(FRAMEWORK_OPTS)
	@echo "Compiling" [ $@ ] $(SUCCESS)

obj/%.o: src/%.c obj
	$(CC) -c -o $@ $< -I $(INC)
	@echo "Linking" [ $< ] $(OK)

obj:
	@mkdir -p obj

# GLFW
$(GLFW_LIB_PATH):
	@$(CMAKE) $(GLFW_LIB_DIR) && \
	@$(MAKE) -C $(GLFW_LIB_DIR)

glfw/CMakeLists.txt:
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
	@$(MAKE) -C $(GLFW_LIB_DIR) clean
	@echo "Clean" [ $(GLFW_LIB_DIR) ] $(OK)

re: fclean all

.PHONY: all clean fclean re
