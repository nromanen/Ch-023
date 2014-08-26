package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.Document;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class DocumentDAOImpl implements DocumentDAO {
	
	private static final Logger LOG = LoggerFactory.getLogger(DocumentDAOImpl.class);

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<Document> getAllDocuments() {
    	LOG.debug("Get all documents");
        return entityManager.createQuery("from Document").getResultList();
    }

    @Override
    public Document getDocumentById(int id) {
    	LOG.debug("Get document with id = {}", id);
        return (Document) entityManager
                .createQuery("from Document where id = :id")
                .setParameter("id", id)
                .getSingleResult();
    }

    @Override
    public void addDocument(Document document) {
        entityManager.persist(document);
    	LOG.debug("Add document {}", document);
    }

    @Override
    public void updateDocument(Document document) {
        entityManager.merge(document);
        LOG.debug("Updated document with id = {}", document.getId());
    }

    @Override
    public void deleteDocument(Document document) {
            String sql = "DELETE FROM racer_document WHERE document_id= :id";
            Query query = entityManager.createNativeQuery(sql)
                    .setParameter("id", document.getId());
            if (query.executeUpdate() != 0) {
            	LOG.debug("Delete all rows from racer_document where document_id = {}", document.getId());
            } else {
            	LOG.warn("Tried to delete all rows from racer_document where document_id = {}, but errors have occured", document.getId());
            }

            query = entityManager.createNativeQuery(
                    "DELETE FROM files WHERE document_id = :id");
            query.setParameter("id", document.getId());
            if (query.executeUpdate() != 0) {
            	LOG.debug("Delete all rows from files where document_id = {}", document.getId());
            } else {
            	LOG.warn("Tried to delete all rows from files where document_id = {}, but errors have occured", document.getId());
            }

            query = entityManager.createNativeQuery(
                    "DELETE FROM documents WHERE id = :id");
            query.setParameter("id", document.getId());
            if (query.executeUpdate() != 0) {
            	 LOG.debug("Deleted document with id = {}", document.getId());
            } else {
            	LOG.warn("Tried to delete document with id = {}", document.getId());
            }
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
            LOG.debug("Deleted document(id = {}) from racer(id = {})", documentId, racerId);
        } catch (Exception e) {
        	LOG.error("Tried to delete document(id = {}) from racer(id = {})", documentId, racerId);
        }
    }

    @Override
    public boolean isRacerOwnerOfDocument(int documentId) {
        String sql = "SELECT racer_id FROM racer_document WHERE document_id= :documentId  ";
        Query query = entityManager.createNativeQuery(sql).setParameter("documentId", documentId);
        boolean emptyList = query.getResultList().isEmpty();
        LOG.debug("There is {} owner of document with id = {}", (emptyList ? "not" : ""), documentId);
        return !emptyList;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Document> gelAllUncheckedDocuments() {
    	LOG.debug("Get all unchecked documents");
        return entityManager.
                createQuery("from Document where checked= :checked").
                setParameter("checked", false).getResultList();
    }

}
