package net.carting.util;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * Carting
 * Created by manson on 7/26/14.
 */
public class EntityManagerUtil {

    private static EntityManagerFactory entityManagerFactory;

    private static EntityManager entityManager;

    private EntityManagerUtil() { }

    public static EntityManager getEntityManager() {
        beginTransaction();
        return  entityManager;
    }

    private static void beginTransaction() {
        entityManagerFactory = Persistence.createEntityManagerFactory("entityManager");
        entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();
    }

    public static void closeTransaction() {
        entityManager.getTransaction().commit();
        entityManager.close();
        entityManagerFactory.close();
    }



}
