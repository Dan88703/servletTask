package filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;

import java.io.IOException;
import java.util.List;

@WebFilter(urlPatterns = "/*")
public class HTTPMethodFilter extends HttpFilter {
    private final List<String> httpMethods = List.of("GET", "POST", "DELETE");

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;

        String method = req.getParameter("_method");

        if (method != null && httpMethods.contains(method)) {
            HttpServletRequestWrapper wrapper = new HttpServletRequestWrapper(request) {
                @Override
                public String getMethod() {
                    return method;
                };
            };

            chain.doFilter(wrapper, res);
        }else {
            chain.doFilter(req, res);
        }
    }
}
