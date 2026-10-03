package listener;


import dao.ProductDao;
import dao.UserDao;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Getter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import service.ProductService;
import service.UserService;

import java.io.File;

@Getter
@WebListener
public class ContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext servletContext = sce.getServletContext();

        ObjectMapper objectMapper = new ObjectMapper();
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        File pFile = new File("D:\\WebAppLogIn\\src\\main\\resources\\products.json");
        File file = new File("D:\\WebAppLogIn\\src\\main\\resources\\users.json");
        UserDao userDao = new UserDao(objectMapper, file);
        ProductDao productDao = new ProductDao(objectMapper, pFile);
        UserService userService = new UserService(userDao, encoder);
        ProductService productService = new ProductService(productDao);
        servletContext.setAttribute("encoder", encoder);
        servletContext.setAttribute("userService", userService);
        servletContext.setAttribute("productService", productService);

    }
}
