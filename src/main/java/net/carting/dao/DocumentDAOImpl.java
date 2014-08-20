package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.Document;

import org.springframework.stereotype.Repository;

@Repository
public class DocumentDAOImpl implements DocumentDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<Document> getAllDocuments() {
        return entityManager.createQuery("from Document").getResultList();
    }

    @Override
    public Document getDocumentById(int id) {
        return (Document) entityManager
                .createQuery("from Document where id = :id")
                .setParameter("id", id)
                .getSingleResult();
    }

    @Override
    public void addDocument(Document document) {
        entityManager.persist(document);
    }

    @Override
    public void updateDocument(Document document) {
        entityManager.merge(document);
    }

    @Override
    public void deleteDocument(Document document) {
            String sql = "DELETE FROM racer_document WHERE document_id= :id";
            Query query = entityManager.createNativeQuery(sql)
                    .setParameter("id", document.getId());
            query.executeUpdate();

            query = entityManager.createNativeQuery(
                    "DELETE FROM files WHERE document_id = :id");
            query.setParameter("id", document.getId());
            query.executeUpdate();

            query = entityManager.createNativeQuery(
                    "DELETE FROM documents WHERE id = :id");
            query.setParameter("id", document.getId());
            query.executeUpdate();
    }

    @Override
    public void deleteDocumentFromRacerByRacerIdAndDocumentId(int documentId,
                                                              int racerId) {
        try {
            String sql = "DELETE FROM racer_document WHERE document_id= :documentId AND racer_id= :racerId";
            Query query = entityManager.createNativeQuery(sql)
                    .setParameter("documentId", documentId)
                    .setParameter("racerId", racerId);
            query.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean isRacerOwnerOfDocument(int documentId) {
        String sql = "SELECT racer_id FROM racer_document WHERE document_id= :documentId  ";
        Query query = entityManager.createNativeQuery(sql).setParameter("documentId", documentId);
        boolean emptyList = query.getResultList().isEmpty();
        return !emptyList;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Document> gelAllUncheckedDocuments() {
        return entityManager.
                createQuery("from Document where checked= :checked").
                setParameter("checked", false).getResultList();
    }

}
