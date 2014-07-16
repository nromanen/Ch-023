package net.carting.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.carting.domain.Document;

@Repository
public class DocumentDAOImpl implements DocumentDAO {
	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	@Override
	public List<Document> getAllDocuments() {
		return sessionFactory.getCurrentSession().createQuery("from Document")
				.list();
	}

	@Override
	public Document getDocumentById(int id) {
		return (Document) sessionFactory.getCurrentSession().get(
				Document.class, id);
	}

	@Override
	public void addDocument(Document document) {
		sessionFactory.getCurrentSession().save(document);

	}

	@Override
	public void updateDocument(Document document) {
		sessionFactory.getCurrentSession().merge(document);

	}

	@Override
	public void deleteDocument(Document document) {
		sessionFactory.getCurrentSession().delete(document);
	}

	@Override
	public void deleteDocumentFromRacerByRacerIdAndDocumentId(int documentId,
			int racerId) {

		String sql = "DELETE FROM racer_document WHERE document_id= :documentId AND racer_id= :racerId";
		Query query = sessionFactory.getCurrentSession().createSQLQuery(sql)
				.setParameter("documentId", documentId)
				.setParameter("racerId", racerId);
		query.executeUpdate();
	}

	@Override
	public boolean isRacerOwnerOfDocument(int documentId) {
		String sql = "SELECT racer_id FROM racer_document WHERE document_id= :documentId  ";
		Query query = sessionFactory.getCurrentSession().createSQLQuery(sql).setParameter("documentId", documentId);

		if(query.list().isEmpty()){
			return false;
		}
		
		return true;		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Document> gelAllUncheckedDocuments() {
		return 	sessionFactory.getCurrentSession()
				.createQuery("from Document where checked= :checked")
				.setParameter("checked", false).list();
	}
}
