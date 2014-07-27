package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import net.carting.domain.Document;

@Repository
public class DocumentDAOImpl implements DocumentDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<Document> getAllDocuments() {
        List<Document> documents = entityManager.createQuery("from Document").getResultList();
        
        return documents;
    }

    @Override
    public Document getDocumentById(int id) {
        Document document = (Document) entityManager
                .createQuery("from Document where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);
        
        return document;
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
        entityManager.remove(document);
        
    }

    @Override
    public void deleteDocumentFromRacerByRacerIdAndDocumentId(int documentId,
                                                              int racerId) {

        String sql = "DELETE FROM racer_document WHERE document_id= :documentId AND racer_id= :racerId";
        Query query = entityManager.createQuery(sql)
                .setParameter("documentId", documentId)
                .setParameter("racerId", racerId);
        query.executeUpdate();

        
    }

    @Override
    public boolean isRacerOwnerOfDocument(int documentId) {
        String sql = "SELECT racer_id FROM racer_document WHERE document_id= :documentId  ";
        Query query = entityManager.createQuery(sql).setParameter("documentId", documentId);
        boolean emptyList = query.getResultList().isEmpty();
        
        if (emptyList) {
            return false;
        }

        return true;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Document> gelAllUncheckedDocuments() {
        List<Document> documents = entityManager.
                createQuery("from Document where checked= :checked").
                setParameter("checked", false).getResultList();
        
        return documents;
    }

}
