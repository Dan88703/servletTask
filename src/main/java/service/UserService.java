package service;

import dao.UserDao;
import entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
public class UserService {

    private final UserDao userDao;
    private final BCryptPasswordEncoder passwordEncoder;
    public void save(User user){
        userDao.save(user);
    }

    public Optional<User> findUsersByCredentiol(String login, String password) {
        List<User> users = userDao.findAll();

        return users.stream()
                .filter(e -> e.getLogin().equals(login) && passwordEncoder.matches(password, e.getPassword()))
                .findFirst();

    }

}
