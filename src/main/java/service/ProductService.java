package service;

import dao.ProductDao;
import entity.Product;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.UUID;


@RequiredArgsConstructor
public class ProductService {
    private final ProductDao productDao;


    public void saveP(Product product){
        productDao.save(product);
    }

    public List<Product> getAllProducts(UUID userId){
        return productDao.findAll().stream().filter(product -> product.getUserId().equals(userId)).toList();
    }

}
