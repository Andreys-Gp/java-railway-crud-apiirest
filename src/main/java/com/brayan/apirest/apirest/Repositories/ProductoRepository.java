package com.brayan.apirest.apirest.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.brayan.apirest.apirest.Entities.Producto;


public interface ProductoRepository extends JpaRepository<Producto, Long> {
    
}
