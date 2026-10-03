package dao;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import entity.User;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;

import java.io.File;
import java.util.List;

@RequiredArgsConstructor
public class UserDao {
    private final ObjectMapper mapper;
    private final File file;

    @SneakyThrows
    public void save(User user) {
        List<User> list = findAll();
        list.add(user);
        mapper.writeValue(file, list);
    }

    @SneakyThrows
    public List<User> findAll() {
        return mapper.readValue(file, new TypeReference<List<User>>(){});
    }
}
