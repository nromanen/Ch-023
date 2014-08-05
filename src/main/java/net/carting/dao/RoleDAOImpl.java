package net.carting.dao;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;

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
