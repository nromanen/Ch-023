package net.carting.dao;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import net.carting.domain.Role;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class RoleDAOImpl implements RoleDAO {

	private static final Logger LOG = LoggerFactory.getLogger(RoleDAOImpl.class);
	
    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public Role getRole(int id) {
    	LOG.debug("Get role with id = {}", id);
        return (Role) entityManager
                .createQuery("from Role where id = :id")
                .setParameter("id", id).getSingleResult();
	}

}
