package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.carting.domain.Authority;
import net.carting.domain.Role;

@Repository
public class RoleDAOImpl implements RoleDAO {
		
    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public Role getRole(int id) {
	   return (Role) entityManager
                .createQuery("from Role where id = :id")
                .setParameter("id", id).getSingleResult();
	}

}
